import 'package:flutter/material.dart' hide TableCell;
import 'package:file_picker/file_picker.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/features/inventory/data/services/ai_product_service.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_models.dart';
import '../../../domain/services/ingestion/ingestion_service.dart';
import 'widgets/session_table_widgets.dart';

part 'parts/bulk_scan_workspace_actions.part.dart';
part 'parts/bulk_scan_workspace_table.part.dart';
part 'parts/bulk_scan_workspace_columns.part.dart';
part 'parts/bulk_scan_workspace_drawer.part.dart';

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

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  void _setActiveTab(BulkWorkspaceTab tab) {
    setState(() => _activeTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.isAdvancedMode &&
        (_activeTab == BulkWorkspaceTab.stock || _activeTab == BulkWorkspaceTab.price)) {
      _activeTab = BulkWorkspaceTab.basicInfo;
    }

    final allFields = widget.controller.getBulkEntryFields();
    final fields = _fieldsForTab(allFields);
    double getBulkColumnWidth(dynamic field) {
      final String key = field?.toString().toLowerCase() ?? '';
      if (key == 'primaryimageurl') return 56.0;
      if (key.contains('name') || key.contains('title')) return 220.0;
      if (key.contains('description')) return 180.0;
      if (key.contains('sku') || key.contains('barcode') || key.contains('code') || key.contains('gtin')) return 130.0;
      if (key.contains('price') || key.contains('cost') || key.contains('mrp') || key.contains('purchase')) return 105.0;
      if (key.contains('discount')) return 95.0;
      if (key.contains('stock') || key.contains('quantity')) return 95.0;
      if (key.contains('alert') || key.contains('threshold') || key.contains('reorder')) return 105.0;
      if (key.contains('category') || key.contains('brand') || key.contains('label') || key.contains('supplier')) return 115.0;
      if (key.contains('country')) return 120.0;
      if (key.contains('action') || key.contains('status')) return 85.0;
      return 110.0;
    }

    double totalWidth = 24 + 42 + 56 + 24; // Static cols + padding
    for (var f in fields) {
      totalWidth += getBulkColumnWidth(f);
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFe8f0f8),
            Color(0xFFd4e4f0),
            Color(0xFFe8f0f8),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                children: [
                  _buildTopActionBar(compact: MediaQuery.of(context).size.width < 1200),
                  _buildBulkTabBar(),
                  if (widget.controller.bulkScanItems.isEmpty) _buildQuickStartPanel(),
                  if (widget.controller.bulkScanItems.isNotEmpty)
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF).withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF0066CC).withValues(alpha: 0.2)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Scrollbar(
                                controller: _horizontalController,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: _horizontalController,
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                    width: totalWidth < constraints.maxWidth ? constraints.maxWidth : totalWidth,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        _buildTableHeader(fields, totalWidth < constraints.maxWidth ? constraints.maxWidth : totalWidth),
                                        Expanded(child: _buildTableBody(fields)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (widget.controller.bulkScanItems.any((i) => i.isSelected))
            _buildBottomActionBar(),
          _buildStickyFooter(),
        ],
      ),
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
          style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              textBaseline: TextBaseline.alphabetic,
              color: Color(0xFF4a5f7f))),
      Text(value,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, color: color)),
    ]);
  }
}

class ColHeader extends StatelessWidget {
  final double width;
  final String label;
  const ColHeader({super.key, required this.width, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: const Color(0xFF0066CC).withValues(alpha: 0.2))),
        color: const Color(0xFFF8F9FA),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: Alignment.centerLeft,
      child: Text(label,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              textBaseline: TextBaseline.alphabetic,
              color: Color(0xFF4a5f7f))),
    );
  }
}
