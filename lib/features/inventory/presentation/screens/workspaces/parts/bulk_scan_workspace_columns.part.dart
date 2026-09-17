part of '../bulk_scan_workspace.dart';

extension _BulkScanWorkspaceColumnsState on _BulkScanWorkspaceState {
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
}
