import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/localization/country_registry.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';
import 'business_setup_selector.dart';

class StoreSetupModal extends StatefulWidget {
  const StoreSetupModal({super.key});

  @override
  State<StoreSetupModal> createState() => _StoreSetupModalState();
}

class _StoreSetupModalState extends State<StoreSetupModal> {
  final controller = StoreSetupController();

  // FORM STATE
  int _activeTab = 0;
  String _searchQuery = "";

  bool _isAdmin = true; // Placeholder: In real ZENO this would come from AuthProvider
  bool get _isConfigLocked => _editingStore.industry.isNotEmpty && _editingStore.subType.isNotEmpty;

  void _handleConfigChange(String? main, String? sub, String? scale, {bool isToggle = false}) {
    if (_isConfigLocked) {
      if (!_isAdmin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Only administrators can change business configuration")),
        );
        return;
      }
      _showConfigurationChangeWarning(() {
        _applyConfigChange(main, sub, scale, isToggle: isToggle);
      });
    } else {
      _applyConfigChange(main, sub, scale, isToggle: isToggle);
    }
  }

  bool get _isSmallScale =>
      _editingStore.businessSize.toUpperCase() == 'SMALL';
  bool get _isGrowingScale =>
      _editingStore.businessSize.toUpperCase() == 'GROWING';
  bool get _isEnterpriseScale =>
      _editingStore.businessSize.toUpperCase() == 'ENTERPRISE';

  int get _maxVisibleTabIndex {
    if (_isEnterpriseScale) return 5;
    return 4;
  }

  int get _maxStaffLimit {
    if (_isSmallScale) return 2;
    if (_isGrowingScale) return 10;
    return 999;
  }

  int get _totalSteps => _maxVisibleTabIndex + 1;

  String _getStepTitle(int index) {
    switch (index) {
      case 0:
        return "Store & Business";
      case 1:
        return "Regional & Tax";
      case 2:
        return "Operations & POS";
      case 3:
        return "Online Store & QR";
      case 4:
        return "Team & Access";
      case 5:
        return "Enterprise Workflows";
      default:
        return "Store & Business";
    }
  }

  void _applyConfigChange(String? main, String? sub, String? scale, {bool isToggle = false}) {
    setState(() {
      if (main != null) {
        _editingStore.industry = main;
        final subTypes = controller.getSubTypes(main);
        _editingStore.subType = subTypes.first;
        _editingStore.enabledSubTypes = [subTypes.first];
      }
      if (sub != null) {
        if (isToggle) {
          if (_editingStore.enabledSubTypes.contains(sub)) {
            if (_editingStore.enabledSubTypes.length > 1) {
              _editingStore.enabledSubTypes.remove(sub);
              if (_editingStore.subType == sub) {
                _editingStore.subType = _editingStore.enabledSubTypes.first;
              }
            }
          } else {
            _editingStore.enabledSubTypes.add(sub);
          }
        } else {
          _editingStore.subType = sub;
          _editingStore.enabledSubTypes = [sub];
        }
      }
      if (scale != null) {
        _editingStore.businessSize = scale;
        if (_activeTab > _maxVisibleTabIndex) {
          _activeTab = _maxVisibleTabIndex;
        }
      }
    });
  }

  void _showConfigurationChangeWarning(VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Configuration?"),
        content: const Text(
          "Changing your business configuration may change product fields, "
          "workflows, inventory behavior, reports and other business features. "
          "Are you sure you want to proceed?"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text("CONFIRM CHANGE"),
          ),
        ],
      ),
    );
  }
  bool _isNew = false;
  late StoreBranch _editingStore;

  // CONTROLLERS
  final _nameController = TextEditingController();
  final _legalNameController = TextEditingController();
  final _taxIdController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _assignedUsersController = TextEditingController();
  final _staffPinController = TextEditingController();
  String _selectedStaffRole = "Cashier";

  // PREFIX CONTROLLERS
  final _invoicePrefixController = TextEditingController();
  final _orderPrefixController = TextEditingController();
  final _receiptPrefixController = TextEditingController();
  final _purchasePrefixController = TextEditingController();

  final _sidebarScrollController = ScrollController();
  final _formScrollController = ScrollController();

  bool _isShelfPriceTaxInclusive = true;

  @override
  void initState() {
    super.initState();
    _taxIdController.addListener(_onTaxIdChanged);
    _nameController.addListener(_onReceiptHeaderChanged);
    _addressController.addListener(_onReceiptHeaderChanged);
    _cityController.addListener(_onReceiptHeaderChanged);
    _zipCodeController.addListener(_onReceiptHeaderChanged);
    if (controller.stores.isNotEmpty) {
      _loadStore(controller.stores.first);
    } else {
      _resetForm();
    }
    controller.addListener(_onControllerUpdate);
  }

  void _onReceiptHeaderChanged() {
    if (mounted) setState(() {});
  }

  void _onTaxIdChanged() {
    final countryProfile = CountryRegistry.countries.firstWhere(
      (c) => c.name.toLowerCase() == _editingStore.country.toLowerCase(),
      orElse: () => CountryRegistry.defaultCountry,
    );

    if (countryProfile.code == 'IN') {
      final text = _taxIdController.text.trim();
      final detectedState = CountryRegistry.getStateFromGSTIN(text);
      if (detectedState != null && detectedState != _editingStore.state) {
        setState(() {
          _editingStore.state = detectedState;
        });
      }
    }
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _taxIdController.removeListener(_onTaxIdChanged);
    _nameController.removeListener(_onReceiptHeaderChanged);
    _addressController.removeListener(_onReceiptHeaderChanged);
    _cityController.removeListener(_onReceiptHeaderChanged);
    _zipCodeController.removeListener(_onReceiptHeaderChanged);
    _staffPinController.dispose();
    controller.removeListener(_onControllerUpdate);
    _nameController.dispose();
    _legalNameController.dispose();
    _taxIdController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _assignedUsersController.dispose();
    _invoicePrefixController.dispose();
    _orderPrefixController.dispose();
    _receiptPrefixController.dispose();
    _purchasePrefixController.dispose();
    _sidebarScrollController.dispose();
    _formScrollController.dispose();
    super.dispose();
  }

  void _loadStore(StoreBranch store) {
    setState(() {
      _isNew = false;
      _editingStore = store.copy();
      _nameController.text = _editingStore.name;
      _legalNameController.text = _editingStore.legalName;
      _taxIdController.text = _editingStore.taxId;
      _addressController.text = _editingStore.address;
      _cityController.text = _editingStore.city;
      _zipCodeController.text = _editingStore.zipCode;
      _phoneController.text = _editingStore.phone;
      _emailController.text = _editingStore.email;

      _invoicePrefixController.text =
          _editingStore.numberingPrefixes['invoice'] ?? "";
      _orderPrefixController.text =
          _editingStore.numberingPrefixes['order'] ?? "";
      _receiptPrefixController.text =
          _editingStore.numberingPrefixes['receipt'] ?? "";
      _purchasePrefixController.text =
          _editingStore.numberingPrefixes['purchase'] ?? "";
    });
  }

  void _resetForm() {
    setState(() {
      _isNew = true;
      _editingStore = StoreBranch(
        id: "PENDING",
        name: "",
        legalName: "",
        industry: "RETAIL",
        subType: "Hypermarket",
        country: "India",
        state: "Kerala",
        address: "",
        city: "",
        zipCode: "",
        phone: "",
        email: "",
        currency: "INR (₹)",
        taxEngine: "GST",
        taxId: "",
        isTaxExempt: false,
        status: "Draft",
        qrUrl: "",
        businessSize: "SMALL",
        operationMode: "Counter-Service",
        barcodeTemplate: "EAN-13 Standard",
        receiptTemplate: "Thermal 80mm Standard",
        inventoryMethods: ["FIFO"],
        paymentMethods: ["Cash", "Credit/Debit Card"],
        aiConfig: [],
        workflowApprovals: [],
        numberingPrefixes: {
          "invoice": "INV",
          "order": "ORD",
          "receipt": "REC",
          "purchase": "PUR"
        },
      );
      _nameController.clear();
      _legalNameController.clear();
      _taxIdController.clear();
      _addressController.clear();
      _cityController.clear();
      _zipCodeController.clear();
      _phoneController.clear();
      _emailController.clear();

      _invoicePrefixController.text = "INV";
      _orderPrefixController.text = "ORD";
      _receiptPrefixController.text = "REC";
      _purchasePrefixController.text = "PUR";

      _activeTab = 0;
    });
  }

  void _handleCountryChange(String? country) {
    if (country == null) return;
    final countryProfile = CountryRegistry.countries.firstWhere(
      (c) => c.name.toLowerCase() == country.toLowerCase() || c.code.toLowerCase() == country.toLowerCase(),
      orElse: () => CountryRegistry.defaultCountry,
    );

    setState(() {
      _editingStore.country = countryProfile.name;
      _editingStore.currency = "${countryProfile.currency.code} (${countryProfile.currency.symbol})";
      _editingStore.taxEngine = countryProfile.tax.label;
      _editingStore.timezone = countryProfile.defaultTimezone;

      final availableStates = GlobalSubdivisions.getForCountry(countryProfile.code);

      if (availableStates.isNotEmpty && !availableStates.contains(_editingStore.state)) {
        _editingStore.state = availableStates.first;
      }

      final code = countryProfile.code.toUpperCase();
      if (['IN', 'AE', 'SA', 'KW', 'OM', 'BH', 'QA', 'GB', 'SG', 'AU', 'DE', 'FR', 'ZA'].contains(code)) {
        _isShelfPriceTaxInclusive = true;
      } else if (['US', 'CA', 'JP'].contains(code)) {
        _isShelfPriceTaxInclusive = false;
      }

      // AUTO-GENERATE ID FOR NEW STORES ON COUNTRY CHANGE
      if (_isNew) {
        final newId = controller.generateStoreId(countryProfile.name);
        _editingStore = _editingStore.copy(
          id: newId,
          qrUrl: "https://zeno.store/${newId.toLowerCase()}",
        );
      }
    });
  }

  void _handleIndustryChange(String? industry) {
    if (industry == null) return;
    final subTypes = controller.getSubTypes(industry);
    setState(() {
      _editingStore.industry = industry;
      _editingStore.subType = subTypes.isNotEmpty ? subTypes.first : "General";
    });
  }

  Future<void> _save() async {
    final nameText = _nameController.text.trim();
    final phoneText = _phoneController.text.trim();

    if (nameText.isEmpty) {
      setState(() => _activeTab = 0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                "Store / Business Name is required",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    if (phoneText.isEmpty) {
      setState(() => _activeTab = 0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                "Phone number is required for digital receipts",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.orange.shade800,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    final storeToSave = _editingStore.copy()
      ..name = nameText
      ..legalName = _legalNameController.text.trim().isEmpty ? nameText : _legalNameController.text.trim()
      ..taxId = _taxIdController.text.trim()
      ..address = _addressController.text.trim()
      ..city = _cityController.text.trim()
      ..zipCode = _zipCodeController.text.trim()
      ..phone = phoneText
      ..email = _emailController.text.trim();

    String finalId = storeToSave.id;
    if (_isNew && (finalId == "PENDING" || finalId.isEmpty)) {
      finalId = controller.generateStoreId(storeToSave.country);
    }

    final savedStore = storeToSave.copy(
      id: finalId,
      status: storeToSave.status == "Draft" ? "Active" : storeToSave.status,
      qrUrl: "https://zeno.store/${finalId.toLowerCase()}",
    );

    await controller.saveStore(savedStore);
    _loadStore(savedStore);

    if (mounted) {
      final modelName = savedStore.industry.isNotEmpty ? savedStore.industry : "Retail";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "🎉 ${savedStore.name} successfully configured! Launching $modelName POS...",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    if (_activeTab > _maxVisibleTabIndex) {
      _activeTab = _maxVisibleTabIndex;
    }

    return Padding(
      padding:
          const EdgeInsets.all(1.5), // Tiny gap for the glowing window border
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT SIDEBAR: STORE DIRECTORY (Hidden for SMALL scale)
          if (!_isSmallScale) _buildSidebar(colors),

          // RIGHT PANEL: CONFIGURATION (100% width when sidebar is hidden)
          Expanded(
            child: _buildConfigPanel(colors),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(ZenoSemanticColors colors) {
    final filteredStores = controller.stores
        .where((s) =>
            s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            s.id.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(right: BorderSide(color: colors.borderSubtle)),
      ),
      child: Column(
        children: [
          // SIDEBAR HEADER
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🏢 STORE DIRECTORY",
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: colors.textDisabled,
                      letterSpacing: 1.0),
                ),
                const SizedBox(height: 12),
                // ADD ACTION
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.add_business_rounded, size: 16),
                    label: const Text("ADD NEW BRANCH"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.accentPrimary,
                      foregroundColor: colors.bgTier1,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      textStyle: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: colors.bgTier1,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: colors.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 14, color: colors.textSecondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          onChanged: (v) => setState(() => _searchQuery = v),
                          style: TextStyle(
                              fontSize: 12, color: colors.textPrimary),
                          decoration: InputDecoration(
                            hintText: "Search Stores...",
                            hintStyle: TextStyle(
                                fontSize: 11, color: colors.textDisabled),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // STORE LIST
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                scrollbarTheme: ScrollbarThemeData(
                  thumbColor: WidgetStateProperty.all(
                      colors.accentPrimary.withValues(alpha: 0.3)),
                ),
              ),
              child: Scrollbar(
                controller: _sidebarScrollController,
                thumbVisibility: true,
                thickness: 4,
                radius: const Radius.circular(10),
                child: ListView.builder(
                  controller: _sidebarScrollController,
                  padding: EdgeInsets.zero,
                  itemCount: filteredStores.length,
                  itemBuilder: (context, index) {
                    final store = filteredStores[index];
                    final isSelected = !_isNew && _editingStore.id == store.id;

                    return InkWell(
                      onTap: () => _loadStore(store),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colors.accentPrimary.withValues(alpha: 0.08)
                              : Colors.transparent,
                          border: Border(
                            left: BorderSide(
                                color: isSelected
                                    ? colors.accentPrimary
                                    : Colors.transparent,
                                width: 3),
                            bottom: BorderSide(
                                color:
                                    colors.borderSubtle.withValues(alpha: 0.3)),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    store.name,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? colors.textPrimary
                                            : colors.textSecondary
                                                .withValues(alpha: 0.9)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _StatusBadge(
                                    status: store.status, colors: colors),
                                const Spacer(),
                                if (isSelected)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: colors.accentPrimary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text("EDIT",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black,
                                            letterSpacing: 0.5)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(store.id,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: colors.textDisabled,
                                    fontFamily: 'monospace')),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigPanel(ZenoSemanticColors colors) {
    final storeTitle = _editingStore.name.isNotEmpty
        ? _editingStore.name.toUpperCase()
        : "MAIN STORE IDENTITY";

    return Container(
      color: colors.bgTier1,
      child: Column(
        children: [
          // STORE / BRANCH HEADER BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: colors.bgTier2,
                border: Border(bottom: BorderSide(color: colors.borderSubtle))),
            child: Row(
              children: [
                Icon(Icons.storefront_rounded,
                    size: 16, color: colors.accentPrimary),
                const SizedBox(width: 8),
                if (_isSmallScale)
                  Text(
                    storeTitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: colors.textPrimary,
                      letterSpacing: 0.8,
                    ),
                  )
                else
                  Row(
                    children: [
                      Text(
                        "$storeTitle (Main HQ)",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: colors.textPrimary,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_drop_down,
                          size: 18, color: colors.textSecondary),
                    ],
                  ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: colors.accentPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: colors.accentPrimary.withValues(alpha: 0.3))),
                  child: Text(
                    _editingStore.businessSize.toUpperCase(),
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        color: colors.accentPrimary,
                        letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ),

          // TAB HEADERS (DEPARTMENTS)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 44,
            decoration: BoxDecoration(
                color: colors.bgTier2,
                border: Border(bottom: BorderSide(color: colors.borderSubtle))),
            child: Row(
              children: [
                _TabItem(
                    index: 0,
                    label: "1. Store & Business",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 1,
                    label: "2. Regional & Tax",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 2,
                    label: "3. Operations & POS",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 3,
                    label: "4. Online Store & QR",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                if (!_isSmallScale)
                  _TabItem(
                      index: 4,
                      label: "5. Team & Access",
                      activeIndex: _activeTab,
                      onTap: (i) => setState(() => _activeTab = i),
                      colors: colors),
                if (_isEnterpriseScale)
                  _TabItem(
                      index: 5,
                      label: "6. Enterprise Workflows",
                      activeIndex: _activeTab,
                      onTap: (i) => setState(() => _activeTab = i),
                      colors: colors),
                const Spacer(),
                if (_isNew)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: colors.statusWarning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color:
                                colors.statusWarning.withValues(alpha: 0.3))),
                    child: Text("NEW BRANCH",
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w900,
                            color: colors.statusWarning)),
                  ),
              ],
            ),
          ),

          // STEPPER / PROGRESS HEADER BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
                color: colors.bgTier2,
                border: Border(bottom: BorderSide(color: colors.borderSubtle))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Step ${_activeTab + 1} of $_totalSteps • ${_getStepTitle(_activeTab)} (${(((_activeTab + 1) / _totalSteps) * 100).round()}%)",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: colors.accentPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      "${_editingStore.industry} • ${_editingStore.subType}",
                      style: TextStyle(
                        fontSize: 9,
                        color: colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: SizedBox(
                    height: 3,
                    child: LinearProgressIndicator(
                      value: (_activeTab + 1) / _totalSteps,
                      backgroundColor: colors.borderSubtle,
                      valueColor: AlwaysStoppedAnimation<Color>(colors.accentPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ACTIVE FORM PANEL
          Expanded(
            child: Scrollbar(
              controller: _formScrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _formScrollController,
                padding: const EdgeInsets.fromLTRB(24, 24, 24,
                    60), // Balanced bottom padding for footer clearance
                child: _buildActiveTab(colors),
              ),
            ),
          ),

          // FOOTER ACTIONS
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 8), // Slimmer vertical padding
            decoration: BoxDecoration(
                color: colors.bgTier2,
                border: Border(top: BorderSide(color: colors.borderSubtle))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("CANCEL",
                      style: TextStyle(
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w900,
                          fontSize: 11)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: controller.isSyncing ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accentPrimary,
                    foregroundColor: colors.bgTier1,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: controller.isSyncing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.black))
                      : const Text("SAVE & SYNC CONFIGURATION",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 11)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveTab(ZenoSemanticColors colors) {
    switch (_activeTab) {
      case 0:
        return _buildGeneralTab(colors);
      case 1:
        return _buildRegionalTab(colors);
      case 2:
        return _buildOperationsTab(colors);
      case 3:
        return _buildSyncTab(colors);
      case 4:
        return _buildAccessControlTab(colors);
      case 5:
        return _buildIntelligenceTab(colors);
      default:
        return _buildGeneralTab(colors);
    }
  }

  Widget _buildGeneralTab(ZenoSemanticColors colors) {
    final dialCode = CountryRegistry.countries
        .firstWhere(
          (c) => c.name.toLowerCase() == _editingStore.country.toLowerCase(),
          orElse: () => CountryRegistry.defaultCountry,
        )
        .phoneCode;

    final storeIdentityCard = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _sectionHeader("🏪 Store Identity", colors),
          ZenoTextField(
            label: "Store / Business Name *",
            controller: _nameController,
            hint: "Enter store display name",
            isRequired: true,
          ),
          const SizedBox(height: 12),
          ZenoTextField(
            label: "Legal / Company Name *",
            controller: _legalNameController,
            hint: "Enter registered legal name",
            isRequired: true,
          ),
          const SizedBox(height: 12),
          ZenoTextField(
            label: "Store WhatsApp / Phone *",
            controller: _phoneController,
            hint: "Enter contact phone number",
            isRequired: true,
            prefix: Padding(
              padding: const EdgeInsets.only(left: 10, right: 6),
              child: Text(
                dialCode,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          ZenoTextField(
            label: "Store Email (Optional)",
            controller: _emailController,
            hint: "branch@zeno.store",
            isRequired: false,
          ),
        ],
      ),
    );

    final classificationSelector = BusinessSetupSelector(
      mainBusinesses: controller.industries,
      subBusinesses: controller.getSubTypes(_editingStore.industry),
      scales: controller.businessSizes,
      selectedMain: _editingStore.industry,
      enabledSubs: _editingStore.enabledSubTypes,
      selectedScale: _editingStore.businessSize,
      onMainChanged: (v) => _handleConfigChange(v, null, null),
      onSubToggled: (v) => _handleConfigChange(null, v, null, isToggle: true),
      onScaleChanged: (v) => _handleConfigChange(null, null, v),
      isLocked: _isConfigLocked && !_isAdmin,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              storeIdentityCard,
              const SizedBox(height: 12),
              classificationSelector,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 350,
              child: storeIdentityCard,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: classificationSelector,
            ),
          ],
        );
      },
    );
  }

  Widget _buildOperationsTab(ZenoSemanticColors colors) {
    final card1Hardware = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _sectionHeader("🖥️ Terminal & Hardware", colors),
          ZenoDropdown<String>(
            label: "Operation Mode",
            value: _editingStore.operationMode,
            items: controller.operationModes
                .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12))))
                .toList(),
            onChanged: (v) => setState(() => _editingStore.operationMode = v!),
          ),
          const SizedBox(height: 14),
          ZenoDropdown<String>(
            label: "Receipt Template",
            value: _editingStore.receiptTemplate,
            items: controller.receiptTemplates
                .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12))))
                .toList(),
            onChanged: (v) => setState(() => _editingStore.receiptTemplate = v!),
          ),
          const SizedBox(height: 14),
          ZenoDropdown<String>(
            label: "Barcode Template",
            value: _editingStore.barcodeTemplate,
            items: controller.barcodeTemplates
                .map((i) => DropdownMenuItem(value: i, child: Text(i, style: const TextStyle(fontSize: 12))))
                .toList(),
            onChanged: (v) => setState(() => _editingStore.barcodeTemplate = v!),
          ),
        ],
      ),
    );

    final card2Inventory = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _sectionHeader("⚙️ Accounting & Sequences", colors),
          
          Text(
            "Inventory Costing Method",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textSecondary),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: controller.inventoryMethods.map((method) {
              final isSelected = _editingStore.inventoryMethods.contains(method);
              return InkWell(
                onTap: () {
                  setState(() {
                    _editingStore.inventoryMethods = [method];
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? colors.accentPrimary.withValues(alpha: 0.15) : colors.bgTier1,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSelected ? colors.accentPrimary : colors.borderSubtle,
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        Icon(Icons.check, size: 12, color: colors.accentPrimary),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        method,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? colors.accentPrimary : colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          Text(
            "Supported Payment Methods",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textSecondary),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: controller.paymentMethods.map((pm) {
              final isSelected = _editingStore.paymentMethods.contains(pm);
              return FilterChip(
                label: Text(pm, style: TextStyle(fontSize: 10, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      if (!_editingStore.paymentMethods.contains(pm)) {
                        _editingStore.paymentMethods.add(pm);
                      }
                    } else {
                      if (_editingStore.paymentMethods.length > 1) {
                        _editingStore.paymentMethods.remove(pm);
                      }
                    }
                  });
                },
                selectedColor: colors.accentPrimary.withValues(alpha: 0.15),
                checkmarkColor: colors.accentPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          Text(
            "Document Numbering Prefixes",
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textSecondary),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 85,
                child: ZenoTextField(
                  label: "Invoice",
                  hint: "INV",
                  controller: _invoicePrefixController,
                  onChanged: (v) => setState(() => _editingStore.numberingPrefixes['invoice'] = v),
                ),
              ),
              SizedBox(
                width: 85,
                child: ZenoTextField(
                  label: "Order",
                  hint: "ORD",
                  controller: _orderPrefixController,
                  onChanged: (v) => setState(() => _editingStore.numberingPrefixes['order'] = v),
                ),
              ),
              SizedBox(
                width: 85,
                child: ZenoTextField(
                  label: "Receipt",
                  hint: "REC",
                  controller: _receiptPrefixController,
                  onChanged: (v) => setState(() => _editingStore.numberingPrefixes['receipt'] = v),
                ),
              ),
              SizedBox(
                width: 85,
                child: ZenoTextField(
                  label: "Purchase",
                  hint: "PUR",
                  controller: _purchasePrefixController,
                  onChanged: (v) => setState(() => _editingStore.numberingPrefixes['purchase'] = v),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 850;

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              card1Hardware,
              const SizedBox(height: 12),
              card2Inventory,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: card1Hardware),
            const SizedBox(width: 16),
            Expanded(flex: 1, child: card2Inventory),
          ],
        );
      },
    );
  }

  Widget _buildIntelligenceTab(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("ZENO INTELLIGENCE & WORKFLOWS", colors),
        _buildChipSelector("AI SUBSYSTEM CONFIGURATION", controller.aiConfigs,
            _editingStore.aiConfig, (selected) {
          setState(() => _editingStore.aiConfig = selected);
        }, colors),
        const SizedBox(height: 24),
        _buildChipSelector(
            "ENTERPRISE WORKFLOW APPROVALS",
            controller.workflowApprovals,
            _editingStore.workflowApprovals, (selected) {
          setState(() => _editingStore.workflowApprovals = selected);
        }, colors),
        const SizedBox(height: 32),
        _buildConfigPreviewBox(colors),
      ],
    );
  }

  Widget _buildChipSelector(
      String label,
      List<String> options,
      List<String> selected,
      Function(List<String>) onChanged,
      ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: colors.textPrimary,
                letterSpacing: 0.5)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selected.contains(option);
            return FilterChip(
              label: Text(option,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : colors.textPrimary)),
              selected: isSelected,
              onSelected: (val) {
                final newList = List<String>.from(selected);
                if (val) {
                  newList.add(option);
                } else {
                  newList.remove(option);
                }
                onChanged(newList);
              },
              backgroundColor: colors.bgTier2,
              selectedColor: colors.accentPrimary,
              checkmarkColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                    color: isSelected
                        ? colors.accentPrimary
                        : colors.borderSubtle),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildConfigPreviewBox(ZenoSemanticColors colors) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x0D00F0FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0x3300F0FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics_outlined,
                  size: 16, color: Color(0xFF00F0FF)),
              const SizedBox(width: 8),
              Text("ZENO BOS CONFIGURATION PREVIEW",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF00F0FF),
                      letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 12),
          _previewRow("POS Layout:", "${_editingStore.industry} Optimized"),
          _previewRow("Operation:", _editingStore.operationMode),
          _previewRow(
              "Inventory:",
              _editingStore.inventoryMethods.isEmpty
                  ? "Not Configured"
                  : _editingStore.inventoryMethods.join(", ")),
          _previewRow(
              "AI Engine:",
              _editingStore.aiConfig.isEmpty
                  ? "Standard (Predictive Disabled)"
                  : "${_editingStore.aiConfig.length} Modules Active"),
          _previewRow(
              "Workflows:",
              _editingStore.workflowApprovals.isEmpty
                  ? "Direct Processing"
                  : "${_editingStore.workflowApprovals.length} Approval Gates"),
        ],
      ),
    );
  }

  Widget _previewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(value,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF00F0FF),
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  String _getTaxIdLabel(CountryProfile profile) {
    switch (profile.code.toUpperCase()) {
      case 'IN':
        return "GSTIN Number *";
      case 'AE':
      case 'SA':
      case 'OM':
      case 'BH':
      case 'QA':
      case 'KW':
        return "TRN / VAT Registration No. *";
      case 'US':
        return "EIN / Sales Tax Permit *";
      default:
        return "${profile.tax.taxIdName} Number";
    }
  }

  String _getTaxIdHint(CountryProfile profile) {
    switch (profile.code.toUpperCase()) {
      case 'IN':
        return "32AAAAA0000A1Z5";
      case 'AE':
      case 'SA':
      case 'OM':
      case 'BH':
      case 'QA':
      case 'KW':
        return "100123456700003";
      case 'US':
        return "12-3456789";
      default:
        return "Enter ${profile.tax.taxIdName}";
    }
  }

  Widget _buildRegionalTab(ZenoSemanticColors colors) {
    final countryProfile = CountryRegistry.countries.firstWhere(
      (c) => c.name.toLowerCase() == _editingStore.country.toLowerCase() ||
             c.code.toLowerCase() == _editingStore.country.toLowerCase(),
      orElse: () => CountryRegistry.defaultCountry,
    );

    final availableStates = GlobalSubdivisions.getForCountry(countryProfile.code);

    final selectedState = availableStates.contains(_editingStore.state)
        ? _editingStore.state
        : (availableStates.isNotEmpty ? availableStates.first : "N/A");

    final stateLabel = GlobalSubdivisions.getLabelForCountry(countryProfile.code);

    final detectedStateFromGstin = countryProfile.code == 'IN'
        ? CountryRegistry.getStateFromGSTIN(_taxIdController.text)
        : null;

    final storeNameDisplay = _nameController.text.trim().isNotEmpty
        ? _nameController.text.trim().toUpperCase()
        : (_editingStore.name.isNotEmpty ? _editingStore.name.toUpperCase() : "TAGSOLE MAIN");

    final streetDisplay = _addressController.text.trim().isNotEmpty
        ? _addressController.text.trim()
        : "12/450, Commercial Street";

    final cityDisplay = _cityController.text.trim().isNotEmpty
        ? _cityController.text.trim()
        : "Calicut";

    final zipDisplay = _zipCodeController.text.trim().isNotEmpty
        ? _zipCodeController.text.trim()
        : "673001";

    final taxIdDisplay = _taxIdController.text.trim().isNotEmpty
        ? _taxIdController.text.trim()
        : (countryProfile.code == 'IN' ? "32AAAAA0000A1Z5" : "100123456700003");

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. LEFT CARD — "⚖️ TAX & JURISDICTION COMPLIANCE" (Flex 11)
        Expanded(
          flex: 11,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.bgTier2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _sectionHeader("⚖️ Tax & Jurisdiction Compliance", colors),
                
                // Field 1: Country Dropdown
                ZenoDropdown<String>(
                  label: "Country",
                  value: countryProfile.name,
                  items: CountryRegistry.countries
                      .map((c) => DropdownMenuItem(
                            value: c.name,
                            child: Row(
                              children: [
                                Text(c.flagEmoji, style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 8),
                                Text("${c.name} (${c.phoneCode})", style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: _handleCountryChange,
                ),
                const SizedBox(height: 12),

                // Field 2: State / Place of Supply Dropdown
                ZenoDropdown<String>(
                  label: stateLabel,
                  value: selectedState,
                  items: availableStates
                      .map((i) => DropdownMenuItem(
                            value: i,
                            child: Text(i, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _editingStore.state = v!),
                ),
                const SizedBox(height: 12),

                // Field 3: Tax Registration ID with detection pill
                ZenoTextField(
                  label: _getTaxIdLabel(countryProfile),
                  controller: _taxIdController,
                  hint: _getTaxIdHint(countryProfile),
                  isRequired: countryProfile.tax.taxType != TaxType.none,
                  suffix: detectedStateFromGstin != null
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          margin: const EdgeInsets.only(right: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.green.shade300),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle, size: 11, color: Colors.green),
                              const SizedBox(width: 3),
                              Text(
                                "✓ State: $detectedStateFromGstin",
                                style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 12),

                // Field 4: Currency, Tax & Timezone Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: colors.bgTier1,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: colors.borderSubtle),
                        ),
                        child: Row(
                          children: [
                            Text("Currency: ", style: TextStyle(fontSize: 10, color: colors.textSecondary)),
                            Expanded(
                              child: Text(
                                "🔒 ${countryProfile.currency.code}",
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textPrimary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          color: colors.bgTier1,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: colors.borderSubtle),
                        ),
                        child: Row(
                          children: [
                            Text("Tax: ", style: TextStyle(fontSize: 10, color: colors.textSecondary)),
                            Expanded(
                              child: Text(
                                "🔒 ${countryProfile.tax.taxIdName}",
                                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textPrimary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: countryProfile.hasMultipleTimezones
                          ? ZenoDropdown<String>(
                              label: "Timezone",
                              value: countryProfile.timezones.contains(_editingStore.timezone)
                                  ? _editingStore.timezone
                                  : countryProfile.defaultTimezone,
                              items: countryProfile.timezones
                                  .map((tz) => DropdownMenuItem(
                                        value: tz,
                                        child: Text(tz, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10)),
                                      ))
                                  .toList(),
                              onChanged: (v) => setState(() => _editingStore.timezone = v!),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                color: colors.bgTier1,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: colors.borderSubtle),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time_rounded, size: 12, color: colors.textSecondary),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "🔒 ${_editingStore.timezone}",
                                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.textPrimary),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Field 5: Price Inclusivity Radio Row
                Text(
                  "Price Inclusivity",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.textSecondary),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: colors.bgTier1,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: colors.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _isShelfPriceTaxInclusive = true),
                          child: Row(
                            children: [
                              Radio<bool>(
                                value: true,
                                groupValue: _isShelfPriceTaxInclusive,
                                onChanged: (v) => setState(() => _isShelfPriceTaxInclusive = v!),
                                activeColor: colors.accentPrimary,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                "MRP (Inclusive)",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: _isShelfPriceTaxInclusive ? FontWeight.bold : FontWeight.normal,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => _isShelfPriceTaxInclusive = false),
                          child: Row(
                            children: [
                              Radio<bool>(
                                value: false,
                                groupValue: _isShelfPriceTaxInclusive,
                                onChanged: (v) => setState(() => _isShelfPriceTaxInclusive = v!),
                                activeColor: colors.accentPrimary,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              Text(
                                "+Tax Checkout",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: !_isShelfPriceTaxInclusive ? FontWeight.bold : FontWeight.normal,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // 2. RIGHT CARD — "📍 STORE PHYSICAL ADDRESS & RECEIPT HEADER" (Flex 10)
        Expanded(
          flex: 10,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.bgTier2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _sectionHeader("📍 Store Address & Receipt Header", colors),
                
                // Field 1: Street Address / Building
                ZenoTextField(
                  label: "Street Address / Building",
                  controller: _addressController,
                  hint: "Building name, Street, Area",
                ),
                const SizedBox(height: 12),

                // Field 2: Compact Row for City & Zip
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ZenoTextField(
                        label: "City",
                        controller: _cityController,
                        hint: "Enter city",
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 130,
                      child: ZenoTextField(
                        label: "Postal Code",
                        controller: _zipCodeController,
                        hint: "673001",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Field 3: Live Mini Receipt Header Box
                Text(
                  "🧾 Live Thermal Receipt Header Preview",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.textSecondary),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: colors.bgTier1,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: colors.borderSubtle, style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: [
                      Text(
                        storeNameDisplay,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: colors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "$streetDisplay, $cityDisplay - $zipDisplay",
                        style: TextStyle(
                          fontSize: 10,
                          color: colors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${countryProfile.tax.taxIdName}: $taxIdDisplay",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: colors.accentPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "--------------------------------------------------",
                        style: TextStyle(fontSize: 8, color: colors.borderSubtle, letterSpacing: 1),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSyncTab(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("STORE ACCESS & DIGITAL SYNC", colors),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colors.borderSubtle)),
              child: _editingStore.id == "PENDING"
                  ? Icon(Icons.qr_code_2, size: 50, color: colors.textDisabled)
                  : Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${_editingStore.qrUrl}",
                        errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.qr_code_2,
                            size: 50,
                            color: colors.textDisabled),
                      )),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("SYSTEM GENERATED ID",
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: colors.accentPrimary,
                              letterSpacing: 1.0)),
                      const SizedBox(width: 8),
                      Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                              color: colors.accentPrimary,
                              shape: BoxShape.circle)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(_editingStore.id,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colors.textPrimary,
                          fontFamily: 'monospace')),
                  const SizedBox(height: 16),
                  Text("DIGITAL STORE URL (AUTO-SYNCED)",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: colors.textDisabled,
                          letterSpacing: 1.0)),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: colors.bgTier2,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: colors.borderSubtle)),
                    child: Text(_editingStore.qrUrl,
                        style: TextStyle(
                            fontSize: 11,
                            color: colors.textSecondary,
                            fontFamily: 'monospace')),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Switch(
                        value: _editingStore.autoPrintPos,
                        onChanged: (v) =>
                            setState(() => _editingStore.autoPrintPos = v),
                        activeTrackColor:
                            colors.accentPrimary.withValues(alpha: 0.4),
                        activeThumbColor: colors.accentPrimary,
                      ),
                      const SizedBox(width: 8),
                      Text("Auto-Print POS Receipts",
                          style: TextStyle(
                              fontSize: 11, color: colors.textPrimary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccessControlTab(ZenoSemanticColors colors) {
    final isLimitReached = !_isEnterpriseScale && _editingStore.assignedUsers.length >= _maxStaffLimit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("BRANCH PERSONNEL & ACCESS CONTROL", colors),

        // STAFF QUOTA CHIP
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: colors.bgTier2,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Row(
            children: [
              Icon(Icons.people_outline_rounded, size: 16, color: colors.accentPrimary),
              const SizedBox(width: 8),
              Text(
                "Staff Accounts: ${_editingStore.assignedUsers.length} of ${_isEnterpriseScale ? 'Unlimited' : _maxStaffLimit} Used (${_editingStore.businessSize.toUpperCase()} Scale)",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isLimitReached ? Colors.orange.shade50 : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: isLimitReached ? Colors.orange.shade300 : Colors.green.shade300),
                ),
                child: Text(
                  isLimitReached ? "QUOTA FULL" : "QUOTA AVAILABLE",
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: isLimitReached ? Colors.orange.shade800 : Colors.green.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),

        // UPGRADE BANNER IF LIMIT REACHED
        if (isLimitReached)
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 16, color: Colors.amber.shade800),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Maximum of $_maxStaffLimit staff accounts reached for ${_editingStore.businessSize.toUpperCase()} Scale. Switch scale in Tab 1 to add up to ${_isSmallScale ? 10 : 'unlimited'} staff members.",
                    style: TextStyle(fontSize: 11, color: Colors.amber.shade900, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

        // ASSIGNED USERS LIST & INPUT FORM
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.bgTier2,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active Staff Members",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textSecondary),
              ),
              const SizedBox(height: 8),
              if (_editingStore.assignedUsers.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "No staff members assigned yet. Add your first cashier below.",
                    style: TextStyle(fontSize: 11, color: colors.textDisabled, fontStyle: FontStyle.italic),
                  ),
                )
              else
                Column(
                  children: _editingStore.assignedUsers.map((user) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: colors.bgTier1,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: colors.borderSubtle),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person_rounded, size: 16, color: colors.accentPrimary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              user,
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: colors.textPrimary),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, size: 16, color: Colors.redAccent),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              setState(() {
                                _editingStore.assignedUsers.remove(user);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

              const Divider(height: 20),

              Text(
                "Assign New Staff Member",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textSecondary),
              ),
              const SizedBox(height: 10),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: ZenoTextField(
                      label: "Staff Email / Username *",
                      controller: _assignedUsersController,
                      hint: "cashier@zeno.store",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ZenoDropdown<String>(
                      label: "Role",
                      value: _selectedStaffRole,
                      items: const [
                        DropdownMenuItem(value: "Cashier", child: Text("Cashier (Billing Only)", style: TextStyle(fontSize: 11))),
                        DropdownMenuItem(value: "Manager", child: Text("Manager (Edit Stock)", style: TextStyle(fontSize: 11))),
                        DropdownMenuItem(value: "Admin", child: Text("Admin (Full Access)", style: TextStyle(fontSize: 11))),
                      ],
                      onChanged: (v) => setState(() => _selectedStaffRole = v!),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 100,
                    child: ZenoTextField(
                      label: "4-Digit PIN",
                      controller: _staffPinController,
                      hint: "1234",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: ElevatedButton.icon(
                      onPressed: isLimitReached
                          ? null
                          : () {
                              final text = _assignedUsersController.text.trim();
                              if (text.isNotEmpty) {
                                final pin = _staffPinController.text.trim();
                                final pinStr = pin.isNotEmpty ? " • PIN: $pin" : "";
                                final entry = "$text ($_selectedStaffRole$pinStr)";
                                setState(() {
                                  _editingStore.assignedUsers.add(entry);
                                  _assignedUsersController.clear();
                                  _staffPinController.clear();
                                });
                              }
                            },
                      icon: const Icon(Icons.person_add_alt_1_rounded, size: 14),
                      label: const Text("ASSIGN STAFF", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.accentPrimary,
                        foregroundColor: colors.bgTier1,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, ZenoSemanticColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: colors.textDisabled,
                  letterSpacing: 1.0)),
          const SizedBox(width: 12),
          Expanded(
              child:
                  Divider(color: colors.borderSubtle.withValues(alpha: 0.3))),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  final ZenoSemanticColors colors;
  const _StatusBadge({required this.status, required this.colors});

  @override
  Widget build(BuildContext context) {
    final color =
        status == "Active" ? colors.statusSuccess : colors.statusWarning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.3))),
      child: Text(status.toUpperCase(),
          style: TextStyle(
              fontSize: 8, fontWeight: FontWeight.bold, color: color)),
    );
  }
}

class _TabItem extends StatelessWidget {
  final int index;
  final String label;
  final int activeIndex;
  final Function(int) onTap;
  final ZenoSemanticColors colors;

  const _TabItem(
      {required this.index,
      required this.label,
      required this.activeIndex,
      required this.onTap,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    final isActive = index == activeIndex;
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        height: 44,
        margin: const EdgeInsets.only(right: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: isActive ? colors.accentPrimary : Colors.transparent,
                    width: 2.5))),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w900 : FontWeight.w600,
                color: isActive
                    ? colors.accentPrimary
                    : colors.textPrimary.withValues(alpha: 0.6))),
      ),
    );
  }
}
