part of '../bulk_scan_workspace.dart';

extension _BulkScanWorkspaceDrawerState on _BulkScanWorkspaceState {
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
                _setActiveTab(BulkWorkspaceTab.variants);
              },
              child: const Text('Add to Bulk'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTableBody(List<String> fields) {
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
          fields: fields,
        );
      },
    );
  }
}
