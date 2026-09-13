import 'package:flutter/material.dart' hide TableCell;
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../controllers/product_studio_controller.dart';
import 'widgets/import_column_config.dart';
import 'widgets/dynamic_session_row.dart';

class ImportWorkspace extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ImportWorkspace({super.key, required this.controller, required this.colors});

  @override
  State<ImportWorkspace> createState() => _ImportWorkspaceState();
}

class _ImportWorkspaceState extends State<ImportWorkspace> {
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final columns = getDynamicImportColumns(widget.controller);
    // 100 base width for checkbox, #, and padding
    final double totalWidth = 100.0 + columns.fold(0.0, (sum, col) => sum + col.width);

    return Column(
      children: [
        Container(
          height: 60, padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(color: widget.colors.bgTier2, border: Border(bottom: BorderSide(color: widget.colors.borderSubtle))),
          child: Row(
            children: [
              ZenoButton(label: "PICK FILE", icon: Icons.upload_file_rounded, onPressed: widget.controller.pickImportFile, isLoading: widget.controller.isImporting),
              const SizedBox(width: 12),
              ZenoButton(label: "MANUAL ROW", variant: ZenoButtonVariant.secondary, icon: Icons.add_rounded, onPressed: widget.controller.addManualImportRow),
              const Spacer(),
              _StatToken(label: "IMPORTED", value: "${widget.controller.importItems.length}", color: widget.colors.textPrimary),
              const SizedBox(width: 24),
              ZenoButton(label: "FINISH IMPORT", onPressed: widget.controller.addImportReadyToCatalog, isLoading: widget.controller.isSaving),
            ],
          ),
        ),
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
                    _buildTableHeader(columns, totalWidth),
                    Expanded(child: ListView.builder(itemCount: widget.controller.importItems.length, itemBuilder: (context, index) {
                      return DynamicSessionRow(index: index, item: widget.controller.importItems[index], controller: widget.controller, colors: widget.colors, columns: columns, updateField: widget.controller.updateImportItemField);
                    })),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (widget.controller.importItems.any((i) => i.isSelected))
          _buildBottomActionBar(),
      ],
    );
  }

  Widget _buildTableHeader(List<ImportColumnConfig> columns, double tableWidth) {
    return Container(
      width: tableWidth, height: 32, decoration: BoxDecoration(color: widget.colors.bgTier3, border: Border.all(color: widget.colors.borderSubtle)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Checkbox(value: widget.controller.importItems.isNotEmpty && widget.controller.importItems.every((i) => i.isSelected), onChanged: (v) => widget.controller.toggleImportSelectAll(v ?? false), visualDensity: VisualDensity.compact),
          const ColHeader(width: 36, label: "#"),
          ...columns.map((col) => ColHeader(width: col.width, label: col.label)),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      height: 48, color: widget.colors.accentPrimary.withValues(alpha: 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text("${widget.controller.importItems.where((i) => i.isSelected).length} SELECTED", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: widget.colors.accentPrimary)),
          const Spacer(),
          ZenoButton(label: "DELETE SELECTED", variant: ZenoButtonVariant.ghost, size: ZenoButtonSize.sm, onPressed: widget.controller.deleteSelectedImportItems),
        ],
      ),
    );
  }
}

class _StatToken extends StatelessWidget {
  final String label; final String value; final Color color;
  const _StatToken({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(label, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.bold)),
      Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
    ]);
  }
}

class ColHeader extends StatelessWidget {
  final double width; final String label;
  const ColHeader({super.key, required this.width, required this.label});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: width, decoration: BoxDecoration(border: Border(right: BorderSide(color: colors.borderSubtle))),
      padding: const EdgeInsets.only(left: 8), alignment: Alignment.centerLeft,
      child: Text(label, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
    );
  }
}
