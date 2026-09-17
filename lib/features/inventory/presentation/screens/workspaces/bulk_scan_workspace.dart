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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
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
                      Expanded(child: _buildTableBody(fields)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.controller.bulkScanItems.any((i) => i.isSelected))
            _buildBottomActionBar(),
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
