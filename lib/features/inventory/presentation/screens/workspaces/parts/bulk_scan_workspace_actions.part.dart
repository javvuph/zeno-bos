part of '../bulk_scan_workspace.dart';

extension _BulkScanWorkspaceActionsState on _BulkScanWorkspaceState {
  Future<void> _pickAndProcessBill() async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'webp'],
    );

    if (!mounted || files.isEmpty) {
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
      for (final file in files) {
        if (file.path == null) continue;
        final products = await _ingestionService.processAIBillMultiple(file.path!);
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
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: colors.bgSurface.withValues(alpha:0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.accentPrimary.withValues(alpha:0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.accentPrimary.withValues(alpha:0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.accentPrimary.withValues(alpha:0.2)),
            ),
            child: Icon(Icons.inventory_2_outlined, color: colors.accentPrimary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product ingestion workspace ready',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Scan one or many items, import a file, or upload a bill/image. Everything stays in one editable product sheet.',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ZenoButton(
                label: 'ADD ROW',
                icon: Icons.add_rounded,
                variant: ZenoButtonVariant.secondary,
                onPressed: () => widget.controller.handleBulkBarcodeScanned(
                    'MANUAL-${DateTime.now().millisecond}'),
              ),
              ZenoButton(
                label: 'IMPORT',
                icon: Icons.file_open_outlined,
                variant: ZenoButtonVariant.secondary,
                onPressed: widget.controller.pickImportFile,
              ),
              ZenoButton(
                label: 'UPLOAD IMAGE',
                icon: Icons.image_outlined,
                variant: ZenoButtonVariant.secondary,
                onPressed: _pickAndProcessImage,
              ),
              ZenoButton(
                label: 'UPLOAD BILL',
                icon: Icons.receipt_long_outlined,
                onPressed: _pickAndProcessBill,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      height: 48,
      color: colors.bgSurface.withValues(alpha:0.8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.accentPrimary.withValues(alpha:0.2)),
          bottom: BorderSide(color: colors.accentPrimary.withValues(alpha:0.2)),
        ),
      ),
      child: Row(
        children: [
          Text(
              "${widget.controller.bulkScanItems.where((i) => i.isSelected).length} SELECTED",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: colors.textPrimary)),
          const Spacer(),
          ZenoButton(
              label: "BULK EDIT",
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm,
              onPressed: _openBulkEditDialog),
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
        label: "SCAN",
        icon: Icons.camera_alt_outlined,
        variant: ZenoButtonVariant.secondary,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: _startScanning,
      ),
      const SizedBox(width: 10),
      Container(
        width: compact ? 180 : 250,
        height: compact ? 36 : 40,
        decoration: BoxDecoration(
          color: colors.accentPrimary.withValues(alpha: 0.04).withValues(alpha:0.95),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: colors.accentPrimary.withValues(alpha:0.2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Enter Barcode...",
            hintStyle: TextStyle(fontSize: 13, color: colors.textSecondary),
            border: InputBorder.none,
          ),
          onSubmitted: (v) => widget.controller.handleBulkBarcodeScanned(v),
        ),
      ),
      const SizedBox(width: 10),
      ZenoButton(
        label: "ADD ROW",
        variant: ZenoButtonVariant.secondary,
        icon: Icons.add_rounded,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => widget.controller
            .handleBulkBarcodeScanned("MANUAL-${DateTime.now().millisecond}"),
      ),
      const SizedBox(width: 10),
      ZenoButton(
        label: "UPLOAD BILL",
        icon: Icons.receipt_long_outlined,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => _pickAndProcessBill(),
      ),
      const SizedBox(width: 10),
      ZenoButton(
        label: "IMPORT",
        icon: Icons.file_open_outlined,
        variant: ZenoButtonVariant.secondary,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: widget.controller.pickImportFile,
      ),
      const SizedBox(width: 10),
      ZenoButton(
        label: "UPLOAD IMAGE",
        icon: Icons.image_outlined,
        variant: ZenoButtonVariant.secondary,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: _pickAndProcessImage,
      ),
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colors.bgSurface.withValues(alpha:0.9),
        border: Border.all(color: colors.accentPrimary.withValues(alpha:0.2)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ]
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: colors.accentPrimary.withValues(alpha:0.2)),
                right: BorderSide(color: colors.accentPrimary.withValues(alpha:0.2)),
              ),
            ),
            child: Row(
              children: [
                _StatToken(
                    label: "SCANNED",
                    value: "${widget.controller.bulkScanItems.length}",
                    color: colors.accentPrimary),
                const SizedBox(width: 16),
                _StatToken(
                    label: "READY",
                    value:
                        "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.ready).length}",
                    color: colors.accentPrimary),
                const SizedBox(width: 16),
                _StatToken(
                    label: "REVIEW",
                    value:
                        "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.review || i.status == BulkScanStatus.notFound).length + widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.duplicate).length}",
                    color: colors.statusWarning),
              ],
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildStickyFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ZenoTheme.auroraLightNested.withValues(alpha: 0.9),
            ZenoTheme.auroraLightBackground.withValues(alpha: 0.95),
          ],
        ),
        border: Border(top: BorderSide(color: colors.accentPrimary.withValues(alpha: 0.2))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -2),
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ZenoButton(
            label: "CANCEL",
            variant: ZenoButtonVariant.secondary,
            onPressed: _cancelSession,
          ),
          const SizedBox(width: 12),
          ZenoButton(
            label: "SAVE AS DRAFT",
            variant: ZenoButtonVariant.secondary,
            onPressed: widget.controller.saveBulkAsDraft,
          ),
          const SizedBox(width: 12),
          ZenoButton(
            label: "SAVE",
            onPressed: widget.controller.addBulkReadyToCatalog,
            isLoading: widget.controller.isSaving,
          ),
        ],
      ),
    );
  }

  void _startScanning() {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Scan Product'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Barcode', hintText: 'Scan or enter barcode'),
          onSubmitted: (value) async {
            Navigator.of(dialogContext).pop();
            await widget.controller.handleBulkBarcodeScanned(value);
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final value = controller.text;
              Navigator.of(dialogContext).pop();
              await widget.controller.handleBulkBarcodeScanned(value);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _cancelSession() {
    widget.controller.bulkScanItems.clear();
    widget.controller.notify();
  }

  Future<void> _openBulkEditDialog() async {
    final cost = TextEditingController();
    final sell = TextEditingController();
    final reorder = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Bulk Edit Selected'),
        content: SizedBox(
          width: 360,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: cost, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Cost Price (optional)')),
              TextField(controller: sell, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Selling Price (optional)')),
              TextField(controller: reorder, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Reorder Level (optional)')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              await widget.controller.bulkEditSelected(
                costPrice: double.tryParse(cost.text),
                sellingPrice: double.tryParse(sell.text),
                reorderLevel: double.tryParse(reorder.text),
              );
              if (dialogContext.mounted) Navigator.of(dialogContext).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickAndProcessImage() async {
    final files = await FilePicker.pickFiles(type: FileType.image);
    if (!mounted || files.isEmpty) return;
    try {
      for (final file in files) {
        if (file.path == null) continue;
        final product = await _ingestionService.processAIImage(file.path!);
        widget.controller.bulkScanItems.add(BulkScanItem(
          product: product,
          status: widget.controller.isBulkRowComplete(product) ? BulkScanStatus.ready : BulkScanStatus.review,
        ));
      }
      widget.controller.notify();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image processing failed: $e')));
      }
    }
  }
}
