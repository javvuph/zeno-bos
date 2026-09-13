import 'package:flutter/material.dart' hide TableCell;
import 'package:file_picker/file_picker.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/inventory/data/services/ai_product_service.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_models.dart';
import '../../../domain/services/ingestion/ingestion_service.dart';
import '../../../domain/services/ingestion/ingestion_models.dart';
import 'widgets/session_table_widgets.dart';

class BulkScanWorkspace extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const BulkScanWorkspace(
      {super.key, required this.controller, required this.colors});

  @override
  State<BulkScanWorkspace> createState() => _BulkScanWorkspaceState();
}

enum BulkWorkspaceTab {
  basicInfo,
  specs,
  variants,
  stock,
  price,
  media,
}

class _BulkScanWorkspaceState extends State<BulkScanWorkspace> {
  final ScrollController _horizontalController = ScrollController();
  late final IngestionService _ingestionService;
  BulkWorkspaceTab _activeTab = BulkWorkspaceTab.basicInfo;

  @override
  void initState() {
    super.initState();
    _ingestionService = IngestionService(aiService: sl<AIProductService>());
  }

  String getBulkFieldLabel(String fieldId) {
    switch (fieldId) {
      case 'title':
        return 'Product Name / Style Title *';
      case 'category':
        return 'Category *';
      case 'brand':
        return 'Brand / Label';
      case 'sku':
        return 'SKU / Style Code *';
      case 'barcode':
        return 'Barcode / GTIN';
      case 'costPrice':
        return 'Purchase / Cost Price (₹) *';
      case 'sellingPrice':
        return 'Selling Price / MRP (₹) *';
      case 'discountValue':
        return 'Discount Value (%)';
      case 'reorderLevel':
        return 'Low Stock Alert Threshold';
      case 'openingStock':
        return 'Flat Opening Stock Quantity';
      case 'primaryImageUrl':
        return 'Primary Photo';
      case 'description':
        return 'Online Store Description';
      case 'mrp':
        return 'MRP (₹)';
      case 'discountType':
        return 'Discount Type';
      case 'hsnCode':
        return 'HSN / Tax Code';
      case 'taxRate':
        return 'Tax Rate (%)';
      case 'supplier':
        return 'Supplier';
      case 'countryOfOrigin':
        return 'Country of Origin';
      case 'status':
        return 'Status';
      case 'fabric':
        return 'Fabric';
      case 'neckType':
        return 'Neck Type';
      case 'sleeveType':
        return 'Sleeve Type';
      case 'fitType':
        return 'Fit Type';
      case 'pattern':
        return 'Pattern';
      case 'gender':
        return 'Gender';
      case 'ageGroup':
        return 'Age Group';
      case 'season':
        return 'Season';
      case 'shade':
        return 'Shade / Color';
      case 'sizeStandard':
        return 'Size Standard';
      case 'urlSlug':
        return 'URL Slug';
      case 'searchKeywords':
        return 'Search Keywords';
      case 'metaDescription':
        return 'Meta Description';
      case 'marketingTitle':
        return 'Marketing Title';
      default:
        return widget.controller.getFieldLabel(fieldId);
    }
  }

  List<String> _fieldsForTab(List<String> allFields) {
    final isAdvanced = widget.controller.isAdvancedMode;

    if (!isAdvanced) {
      // BASIC MODE (2 views)
      switch (_activeTab) {
        case BulkWorkspaceTab.basicInfo:
          return const [
            'primaryImageUrl',
            'title',
            'category',
            'brand',
            'sku',
            'barcode',
            'costPrice',
            'sellingPrice',
            'discountValue',
            'reorderLevel',
            'openingStock',
            'description',
          ];
        case BulkWorkspaceTab.variants:
        case BulkWorkspaceTab.stock:
        default:
          return const [
            'title',
            'sku',
            'barcode',
            'shade',
            'sizeStandard',
            'openingStock',
            'reorderLevel',
          ];
      }
    }

    // ADVANCED MODE (5 views)
    switch (_activeTab) {
      case BulkWorkspaceTab.basicInfo:
        return const [
          'primaryImageUrl',
          'title',
          'category',
          'brand',
          'sku',
          'barcode',
          'countryOfOrigin',
          'status',
          'description',
        ];
      case BulkWorkspaceTab.specs:
        return const [
          'fabric',
          'neckType',
          'sleeveType',
          'fitType',
          'pattern',
          'gender',
          'ageGroup',
          'season',
        ];
      case BulkWorkspaceTab.variants:
        return const [
          'sizeStandard',
          'shade',
          'sku',
          'barcode',
          'openingStock',
          'sellingPrice',
        ];
      case BulkWorkspaceTab.stock:
      case BulkWorkspaceTab.price:
        return const [
          'costPrice',
          'sellingPrice',
          'mrp',
          'discountType',
          'discountValue',
          'openingStock',
          'reorderLevel',
          'supplier',
          'hsnCode',
          'taxRate',
        ];
      case BulkWorkspaceTab.media:
        return const [
          'urlSlug',
          'searchKeywords',
          'metaDescription',
          'marketingTitle',
        ];
      default:
        return const [
          'primaryImageUrl',
          'title',
          'category',
          'brand',
          'sku',
          'barcode',
          'description',
        ];
    }
  }

  void _openVariantDrawer() {
    final sizeController = TextEditingController();
    final colorController = TextEditingController();
    final skuController = TextEditingController();
    final priceController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Variant Editor'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    controller: sizeController,
                    decoration: const InputDecoration(labelText: 'Size')),
                const SizedBox(height: 12),
                TextField(
                    controller: colorController,
                    decoration: const InputDecoration(labelText: 'Color')),
                const SizedBox(height: 12),
                TextField(
                    controller: skuController,
                    decoration:
                        const InputDecoration(labelText: 'Variant SKU')),
                const SizedBox(height: 12),
                TextField(
                    controller: priceController,
                    decoration:
                        const InputDecoration(labelText: 'Variant Price'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true)),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                final variant = ProductStudioData.empty();
                variant.title = sizeController.text.isNotEmpty
                    ? '${sizeController.text} / ${colorController.text}'
                    : 'Variant';
                variant.shade = colorController.text;
                variant.sizeStandard = sizeController.text;
                variant.sku = skuController.text.isNotEmpty
                    ? skuController.text
                    : 'VAR-${DateTime.now().millisecondsSinceEpoch}';
                if (priceController.text.isNotEmpty) {
                  variant.sellingPrice =
                      double.tryParse(priceController.text) ?? 0;
                }
                widget.controller.bulkScanItems.add(BulkScanItem(
                    product: variant, status: BulkScanStatus.ready));
                widget.controller.notify();
                Navigator.pop(dialogContext);
                setState(() {
                  _activeTab = BulkWorkspaceTab.variants;
                });
              },
              child: const Text('Add to Bulk'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _productToBillJson(ProductStudioData product) {
    return {
      'product_name': product.title,
      'sku': product.sku,
      'barcode_gtin': product.barcode,
      'selling_price': product.sellingPrice,
      'purchase_cost': product.costPrice,
      'mrp': product.mrp,
      'opening_stock': product.openingStock,
      'description': product.description,
      'primary_supplier': product.supplier,
    };
  }

  Future<void> _pickAndProcessBill() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'webp'],
      allowMultiple: true,
      withData: true,
    );

    if (!mounted || result == null || result.files.isEmpty) {
      return;
    }

    if (context.mounted) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => const SimpleDialog(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text('AI is scanning bills...'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    try {
      for (final file in result.files) {
        final products = await _ingestionService.processAIBillMultiple(file);
        for (final product in products) {
          widget.controller.bulkScanItems.add(
            BulkScanItem(
              product: product,
              status: BulkScanStatus.ready,
            ),
          );
        }
      }
      widget.controller.notify();

      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to scan invoices: $e')),
        );
      }
    }
  }

  Widget _buildQuickStartPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.colors.bgTier2,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: widget.colors.borderSubtle),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bulk workspace ready',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: widget.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Scan a barcode, add a manual row, or upload supplier bills to start filling the bulk sheet.',
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ZenoButton(
                label: 'MANUAL ROW',
                icon: Icons.add_rounded,
                variant: ZenoButtonVariant.secondary,
                size: ZenoButtonSize.sm,
                onPressed: () => widget.controller.handleBulkBarcodeScanned(
                    'MANUAL-${DateTime.now().millisecond}'),
              ),
              ZenoButton(
                label: 'UPLOAD BILLS',
                icon: Icons.receipt_long_outlined,
                variant: ZenoButtonVariant.secondary,
                size: ZenoButtonSize.sm,
                onPressed: _pickAndProcessBill,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableBody() {
    if (widget.controller.bulkScanItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      itemCount: widget.controller.bulkScanItems.length,
      itemBuilder: (context, index) {
        return SessionRow(
          index: index,
          item: widget.controller.bulkScanItems[index],
          controller: widget.controller,
          colors: widget.colors,
          updateField: widget.controller.updateBulkItemField,
        );
      },
    );
  }

  Widget _buildBulkTabBar() {
    final isAdvanced = widget.controller.isAdvancedMode;
    final List<_BulkTabConfig> tabs = isAdvanced
        ? [
            _BulkTabConfig(label: 'BASIC INFO', tab: BulkWorkspaceTab.basicInfo),
            _BulkTabConfig(label: 'SPECS', tab: BulkWorkspaceTab.specs),
            _BulkTabConfig(label: 'VARIANTS', tab: BulkWorkspaceTab.variants),
            _BulkTabConfig(label: 'STOCK & PRICE', tab: BulkWorkspaceTab.stock),
            _BulkTabConfig(label: 'MEDIA & SEO', tab: BulkWorkspaceTab.media),
          ]
        : [
            _BulkTabConfig(label: 'Basic Info', tab: BulkWorkspaceTab.basicInfo),
            _BulkTabConfig(label: 'Variants & Stock', tab: BulkWorkspaceTab.variants),
          ];

    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: widget.colors.bgTier2,
        border: Border(bottom: BorderSide(color: widget.colors.borderSubtle)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final selected = _activeTab == tab.tab;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  if (tab.tab == BulkWorkspaceTab.variants) {
                    _openVariantDrawer();
                    return;
                  }
                  setState(() => _activeTab = tab.tab);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? widget.colors.accentPrimary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    border: Border.all(
                        color: selected
                            ? widget.colors.accentPrimary
                            : widget.colors.borderSubtle),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      color: selected
                          ? widget.colors.accentPrimary
                          : widget.colors.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTableHeader(List<String> fields, double totalWidth) {
    return Container(
      width: totalWidth,
      height: 32,
      decoration: BoxDecoration(
          color: widget.colors.bgTier3,
          border: Border.all(color: widget.colors.borderSubtle)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Checkbox(
            value: widget.controller.bulkScanItems.isNotEmpty &&
                widget.controller.bulkScanItems.every((i) => i.isSelected),
            onChanged: (v) => widget.controller.toggleBulkSelectAll(v ?? false),
            visualDensity: VisualDensity.compact,
          ),
          const ColHeader(width: 36, label: "#"),
          const ColHeader(width: 56, label: "IMG"),
          ...fields.map((f) {
            double width = getBulkColumnWidth(f);
            return ColHeader(
                width: width, label: getBulkFieldLabel(f));
          }),
        ],
      ),
    );
  }

  double getBulkColumnWidth(dynamic field) {
    final String key = field?.toString().toLowerCase() ?? '';
    if (key == 'primaryimageurl') {
      return 80.0;
    } else if (key.contains('name') || key.contains('title') || key.contains('description')) {
      return 220.0;
    } else if (key.contains('sku') || key.contains('barcode') || key.contains('code') || key.contains('gtin')) {
      return 150.0;
    } else if (key.contains('price') || key.contains('cost') || key.contains('mrp') || key.contains('purchase')) {
      return 150.0;
    } else if (key.contains('discount') || key.contains('stock') || key.contains('quantity') || key.contains('alert') || key.contains('threshold') || key.contains('reorder')) {
      return 150.0;
    } else if (key.contains('category') || key.contains('brand') || key.contains('label') || key.contains('supplier')) {
      return 140.0;
    } else if (key.contains('action') || key.contains('status')) {
      return 100.0;
    }
    return 130.0;
  }

  Widget _buildBottomActionBar() {
    return Container(
      height: 48,
      color: widget.colors.accentPrimary.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
              "${widget.controller.bulkScanItems.where((i) => i.isSelected).length} SELECTED",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: widget.colors.accentPrimary)),
          const Spacer(),
          ZenoButton(
              label: "BULK EDIT",
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm,
              onPressed: () {}),
          const SizedBox(width: 12),
          ZenoButton(
              label: "DELETE SELECTED",
              variant: ZenoButtonVariant.ghost,
              size: ZenoButtonSize.sm,
              onPressed: widget.controller.deleteSelectedBulkItems),
        ],
      ),
    );
  }

  Widget _buildTopActionBar({required bool compact}) {
    final actionButtons = <Widget>[
      ZenoButton(
        label: "START SCANNING",
        icon: Icons.camera_alt_outlined,
        variant: ZenoButtonVariant.secondary,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () {},
      ),
      const SizedBox(width: 8),
      SizedBox(
        width: compact ? 180 : 220,
        child: ZenoTextField(
          label: null,
          hint: "Enter Barcode...",
          onSubmitted: (v) => widget.controller.handleBulkBarcodeScanned(v),
        ),
      ),
      const SizedBox(width: 8),
      ZenoButton(
        label: "MANUAL ROW",
        variant: ZenoButtonVariant.secondary,
        icon: Icons.add_rounded,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => widget.controller
            .handleBulkBarcodeScanned("MANUAL-${DateTime.now().millisecond}"),
      ),
      const SizedBox(width: 8),
      ZenoButton(
        label: "IMPORT",
        variant: ZenoButtonVariant.secondary,
        icon: Icons.upload_file_rounded,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => _pickAndProcessBill(),
      ),
      const SizedBox(width: 8),
      ZenoButton(
        label: "BILL AI",
        icon: Icons.auto_awesome_rounded,
        variant: ZenoButtonVariant.secondary,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => _pickAndProcessBill(),
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.colors.bgTier2,
        border: Border(bottom: BorderSide(color: widget.colors.borderSubtle)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: actionButtons,
              ),
            ),
          ),
          const SizedBox(width: 16),
          _StatToken(
              label: "SCANNED",
              value: "${widget.controller.bulkScanItems.length}",
              color: widget.colors.textPrimary),
          const SizedBox(width: 12),
          _StatToken(
              label: "READY",
              value:
                  "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.ready).length}",
              color: widget.colors.statusSuccess),
          const SizedBox(width: 12),
          _StatToken(
              label: "REVIEW",
              value:
                  "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.review || i.status == BulkScanStatus.notFound).length + widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.duplicate).length}",
              color: widget.colors.statusWarning),
          const SizedBox(width: 12),
          ZenoButton(
            label: "SAVE",
            onPressed: widget.controller.addBulkReadyToCatalog,
            isLoading: widget.controller.isSaving,
            size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
          ),
          const SizedBox(width: 8),
          ZenoButton(
            label: "LEGACY FINISH",
            variant: ZenoButtonVariant.ghost,
            size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
            onPressed: widget.controller.addBulkReadyToCatalog,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.isAdvancedMode &&
        (_activeTab == BulkWorkspaceTab.stock || _activeTab == BulkWorkspaceTab.price)) {
      _activeTab = BulkWorkspaceTab.basicInfo;
    }

    final allFields = widget.controller.getBulkEntryFields();
    final fields = _fieldsForTab(allFields);
    double totalWidth = 100 + 56 + 48;
    for (var f in fields) {
      if (f == 'title') {
        totalWidth += 200;
      } else if (f == 'description') {
        totalWidth += 150;
      } else if (f.contains('Price') || f == 'mrp' || f == 'costPrice') {
        totalWidth += 90;
      } else if (f.contains('Stock') || f == 'openingStock') {
        totalWidth += 80;
      } else {
        totalWidth += 120;
      }
    }

    return Column(
      children: [
        _buildTopActionBar(compact: MediaQuery.of(context).size.width < 1200),
        _buildBulkTabBar(),
        if (widget.controller.bulkScanItems.isEmpty) _buildQuickStartPanel(),
        Expanded(
          child: Scrollbar(
            controller: _horizontalController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: totalWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.controller.bulkScanItems.isNotEmpty)
                      _buildTableHeader(fields, totalWidth),
                    Expanded(child: _buildTableBody()),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.controller.bulkScanItems.any((i) => i.isSelected))
          _buildBottomActionBar(),
      ],
    );
  }
}

class _BulkTabConfig {
  final String label;
  final BulkWorkspaceTab tab;
  const _BulkTabConfig({required this.label, required this.tab});
}

class _StatToken extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatToken(
      {required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(label,
          style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      Text(value,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w900, color: color)),
    ]);
  }
}

class ColHeader extends StatelessWidget {
  final double width;
  final String label;
  const ColHeader({super.key, required this.width, required this.label});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: width,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: colors.borderSubtle))),
      padding: const EdgeInsets.only(left: 8),
      alignment: Alignment.centerLeft,
      child: Text(label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
    );
  }
}
