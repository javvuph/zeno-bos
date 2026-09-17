part of '../bulk_scan_workspace.dart';

extension _BulkScanWorkspaceColumnsState on _BulkScanWorkspaceState {
  Widget _buildTableHeader(List<String> fields, double totalWidth) {
    return Container(
      width: totalWidth,
      height: 36,
      decoration: BoxDecoration(
          color: const Color(0xFF0066CC).withValues(alpha:0.08),
          border: Border(bottom: BorderSide(color: const Color(0xFF0066CC).withValues(alpha:0.2))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Checkbox(
              value: widget.controller.bulkScanItems.isNotEmpty &&
                  widget.controller.bulkScanItems.every((i) => i.isSelected),
              onChanged: (v) => widget.controller.toggleBulkSelectAll(v ?? false),
              visualDensity: VisualDensity.compact,
            ),
          ),
          const ColHeader(width: 42, label: "#"),
          const ColHeader(width: 56, label: "IMG"),
          ...fields.map((f) {
            double width = getBulkColumnWidth(f);
            return ColHeader(width: width, label: getBulkFieldLabel(f));
          }),
        ],
      ),
    );
  }

  double getBulkColumnWidth(dynamic field) {
    final String key = field?.toString().toLowerCase() ?? '';
    if (key == 'primaryimageurl') {
      return 56.0;
    } else if (key.contains('name') || key.contains('title')) {
      return 220.0;
    } else if (key.contains('description')) {
      return 180.0;
    } else if (key.contains('sku') || key.contains('barcode') || key.contains('code') || key.contains('gtin')) {
      return 130.0;
    } else if (key.contains('price') || key.contains('cost') || key.contains('mrp') || key.contains('purchase')) {
      return 105.0;
    } else if (key.contains('discount')) {
      return 95.0;
    } else if (key.contains('stock') || key.contains('quantity')) {
      return 95.0;
    } else if (key.contains('alert') || key.contains('threshold') || key.contains('reorder')) {
      return 105.0;
    } else if (key.contains('category') || key.contains('brand') || key.contains('label') || key.contains('supplier')) {
      return 115.0;
    } else if (key.contains('country')) {
      return 120.0;
    } else if (key.contains('action') || key.contains('status')) {
      return 85.0;
    }
    return 110.0;
  }
}
