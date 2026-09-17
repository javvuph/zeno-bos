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
      Container(
        width: compact ? 180 : 250,
        height: compact ? 36 : 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)), // Subtler border
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          decoration: const InputDecoration(
            hintText: "Enter Barcode...",
            hintStyle: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
            border: InputBorder.none,
          ),
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
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(color: const Color(0xFFD1E0F0)),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 10,
            offset: Offset(0, 4),
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
          _StatToken(
              label: "SCANNED",
              value: "${widget.controller.bulkScanItems.length}",
              color: const Color(0xFF1A2A3A)),
          const SizedBox(width: 16),
          _StatToken(
              label: "READY",
              value:
                  "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.ready).length}",
              color: const Color(0xFF118A36)),
          const SizedBox(width: 16),
          _StatToken(
              label: "REVIEW",
              value:
                  "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.review || i.status == BulkScanStatus.notFound).length + widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.duplicate).length}",
              color: const Color(0xFFEA580C)),
          const SizedBox(width: 24),
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
}
