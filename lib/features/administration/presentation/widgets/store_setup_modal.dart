import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
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

  bool _showConfigWarning = false;
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

  // PREFIX CONTROLLERS
  final _invoicePrefixController = TextEditingController();
  final _orderPrefixController = TextEditingController();
  final _receiptPrefixController = TextEditingController();
  final _purchasePrefixController = TextEditingController();

  final _sidebarScrollController = ScrollController();
  final _formScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (controller.stores.isNotEmpty) {
      _loadStore(controller.stores.first);
    } else {
      _resetForm();
    }
    controller.addListener(_onControllerUpdate);
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
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
    final defaults = controller.getDefaultsForCountry(country);
    final states = controller.getStates(country);

    setState(() {
      _editingStore.country = country;
      _editingStore.currency = defaults['currency']!;
      _editingStore.taxEngine = defaults['taxEngine']!;
      _editingStore.state = states.isNotEmpty ? states.first : "N/A";

      // AUTO-GENERATE ID FOR NEW STORES ON COUNTRY CHANGE
      if (_isNew) {
        final newId = controller.generateStoreId(country);
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
    if (_nameController.text.isEmpty || _legalNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all required fields"),
            backgroundColor: Colors.red),
      );
      return;
    }

    final storeToSave = _editingStore.copy()
      ..name = _nameController.text
      ..legalName = _legalNameController.text
      ..taxId = _taxIdController.text
      ..address = _addressController.text
      ..city = _cityController.text
      ..zipCode = _zipCodeController.text
      ..phone = _phoneController.text
      ..email = _emailController.text;

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Business Configuration Profile Successfully Synced."),
          backgroundColor: Color(0xFF00FF88),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Padding(
      padding:
          const EdgeInsets.all(1.5), // Tiny gap for the glowing window border
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT SIDEBAR: STORE DIRECTORY
          _buildSidebar(colors),

          // RIGHT PANEL: CONFIGURATION
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
    return Container(
      color: colors.bgTier1,
      child: Column(
        children: [
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
                    label: "1. General",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 1,
                    label: "2. Operations",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 2,
                    label: "3. Intelligence",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 3,
                    label: "4. Regional",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 4,
                    label: "5. QR Sync",
                    activeIndex: _activeTab,
                    onTap: (i) => setState(() => _activeTab = i),
                    colors: colors),
                _TabItem(
                    index: 5,
                    label: "6. Access Control",
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
        return _buildOperationsTab(colors);
      case 2:
        return _buildIntelligenceTab(colors);
      case 3:
        return _buildRegionalTab(colors);
      case 4:
        return _buildSyncTab(colors);
      case 5:
        return _buildAccessControlTab(colors);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildGeneralTab(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("BUSINESS PROFILE & CLASSIFICATION", colors),
        ZenoTextField(
            label: "Business / Store Name",
            controller: _nameController,
            hint: "Enter store display name",
            isRequired: true),
        const SizedBox(height: 16),
        ZenoTextField(
            label: "Legal / Company Name",
            controller: _legalNameController,
            hint: "Enter registered legal name",
            isRequired: true),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: ZenoTextField(
                    label: "Branch Email",
                    controller: _emailController,
                    hint: "branch@zeno.store")),
            const SizedBox(width: 16),
            Expanded(
                child: ZenoTextField(
                    label: "Contact Number",
                    controller: _phoneController,
                    hint: "+91 XXXX XXX XXX")),
          ],
        ),
        const SizedBox(height: 16),
        BusinessSetupSelector(
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
        ),
      ],
    );
  }

  Widget _buildOperationsTab(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("ZENO BOS OPERATIONS CONFIGURATION", colors),
        Row(
          children: [
            Expanded(
              child: ZenoDropdown<String>(
                label: "Operation Mode",
                value: _editingStore.operationMode,
                items: controller.operationModes
                    .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _editingStore.operationMode = v!),
              ),
            ),
            const SizedBox(width: 16),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 24),
        _buildChipSelector(
            "Inventory Management Methods",
            controller.inventoryMethods,
            _editingStore.inventoryMethods, (selected) {
          setState(() => _editingStore.inventoryMethods = selected);
        }, colors),
        const SizedBox(height: 24),
        _buildChipSelector(
            "Supported Payment Methods",
            controller.paymentMethods,
            _editingStore.paymentMethods, (selected) {
          setState(() => _editingStore.paymentMethods = selected);
        }, colors),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ZenoDropdown<String>(
                label: "Barcode Template",
                value: _editingStore.barcodeTemplate,
                items: controller.barcodeTemplates
                    .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _editingStore.barcodeTemplate = v!),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ZenoDropdown<String>(
                label: "Receipt Template",
                value: _editingStore.receiptTemplate,
                items: controller.receiptTemplates
                    .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _editingStore.receiptTemplate = v!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _sectionHeader("DOCUMENT NUMBERING PREFIXES", colors),
        Row(
          children: [
            Expanded(
              child: ZenoTextField(
                label: "Invoice",
                hint: "INV",
                controller: _invoicePrefixController,
                onChanged: (v) => setState(
                    () => _editingStore.numberingPrefixes['invoice'] = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ZenoTextField(
                label: "Order",
                hint: "ORD",
                controller: _orderPrefixController,
                onChanged: (v) => setState(
                    () => _editingStore.numberingPrefixes['order'] = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ZenoTextField(
                label: "Receipt",
                hint: "REC",
                controller: _receiptPrefixController,
                onChanged: (v) => setState(
                    () => _editingStore.numberingPrefixes['receipt'] = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ZenoTextField(
                label: "Purchase",
                hint: "PUR",
                controller: _purchasePrefixController,
                onChanged: (v) => setState(
                    () => _editingStore.numberingPrefixes['purchase'] = v),
              ),
            ),
          ],
        ),
      ],
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

  Widget _buildRegionalTab(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("REGIONAL LOCALIZATION & ADDRESS", colors),
        Row(
          children: [
            Expanded(
                child: ZenoDropdown<String>(
                    label: "Country",
                    value: _editingStore.country,
                    items: controller.countries
                        .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                        .toList(),
                    onChanged: _handleCountryChange)),
            const SizedBox(width: 16),
            Expanded(
                child: ZenoDropdown<String>(
                    label: "State / Region",
                    value: _editingStore.state,
                    items: controller
                        .getStates(_editingStore.country)
                        .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _editingStore.state = v!))),
          ],
        ),
        const SizedBox(height: 16),
        ZenoTextField(
            label: "Street Address",
            controller: _addressController,
            hint: "Building name, Street, Area"),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: ZenoTextField(
                    label: "City",
                    controller: _cityController,
                    hint: "Enter city")),
            const SizedBox(width: 16),
            Expanded(
                child: ZenoTextField(
                    label: "Zip / Postal Code",
                    controller: _zipCodeController,
                    hint: "XXXXXX")),
          ],
        ),
        const SizedBox(height: 24),
        _sectionHeader("TAX COMPLIANCE", colors),
        Row(
          children: [
            Expanded(
                child: ZenoDropdown<String>(
                    label: "Base Currency",
                    value: _editingStore.currency,
                    items: ['INR (₹)', 'USD (\$)', 'AED (د.إ)', 'GBP (£)']
                        .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _editingStore.currency = v!))),
            const SizedBox(width: 16),
            Expanded(
                child: ZenoDropdown<String>(
                    label: "Tax Engine Type",
                    value: _editingStore.taxEngine,
                    items: [
                      'GST',
                      'VAT',
                      'State Sales Tax',
                      'Flat / Custom Tax'
                    ]
                        .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _editingStore.taxEngine = v!))),
          ],
        ),
        const SizedBox(height: 16),
        ZenoTextField(
            label: "GSTIN / Tax Registration ID",
            controller: _taxIdController,
            hint: "Enter official tax identification number"),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("BRANCH PERSONNEL & ACCESS", colors),
        Container(
          decoration: BoxDecoration(
            color: colors.bgTier2,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Column(
            children: [
              ..._editingStore.assignedUsers.map((email) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.person_outline, size: 16),
                    title: Text(email, style: const TextStyle(fontSize: 12)),
                    trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline,
                            size: 16, color: Colors.redAccent),
                        onPressed: () {
                          setState(
                              () => _editingStore.assignedUsers.remove(email));
                        }),
                  )),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                        child: ZenoTextField(
                            label: "Add User By Email",
                            controller: _assignedUsersController,
                            hint: "user@zeno.store")),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (_assignedUsersController.text.isNotEmpty) {
                          setState(() {
                            _editingStore.assignedUsers
                                .add(_assignedUsersController.text);
                            _assignedUsersController.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colors.accentPrimary,
                          foregroundColor: Colors.black),
                      child: const Text("ASSIGN",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
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
