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
        color: const Color(0xFFFFFFFF).withValues(alpha:0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
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
              color: const Color(0xFF0066CC).withValues(alpha:0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
            ),
            child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF0066CC), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Bulk workspace ready',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1a2a3a),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Scan a barcode, add a manual row, or upload supplier bills to start filling the bulk sheet.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF4a5f7f),
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
                label: 'MANUAL ROW',
                icon: Icons.add_rounded,
                variant: ZenoButtonVariant.secondary,
                onPressed: () => widget.controller.handleBulkBarcodeScanned(
                    'MANUAL-${DateTime.now().millisecond}'),
              ),
              ZenoButton(
                label: 'UPLOAD BILLS',
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
      color: const Color(0xFFFFFFFF).withValues(alpha:0.8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
          bottom: BorderSide(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
        ),
      ),
      child: Row(
        children: [
          Text(
              "${widget.controller.bulkScanItems.where((i) => i.isSelected).length} SELECTED",
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1a2a3a))),
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
      const SizedBox(width: 10),
      Container(
        width: compact ? 180 : 250,
        height: compact ? 36 : 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF0F8FF).withValues(alpha:0.95),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          decoration: const InputDecoration(
            hintText: "Enter Barcode...",
            hintStyle: TextStyle(fontSize: 13, color: Color(0xFF4a5f7f)),
            border: InputBorder.none,
          ),
          onSubmitted: (v) => widget.controller.handleBulkBarcodeScanned(v),
        ),
      ),
      const SizedBox(width: 10),
      ZenoButton(
        label: "MANUAL ROW",
        variant: ZenoButtonVariant.secondary,
        icon: Icons.add_rounded,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => widget.controller
            .handleBulkBarcodeScanned("MANUAL-${DateTime.now().millisecond}"),
      ),
      const SizedBox(width: 10),
      ZenoButton(
        label: "IMPORT",
        variant: ZenoButtonVariant.secondary,
        icon: Icons.upload_file_rounded,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => _pickAndProcessBill(),
      ),
      const SizedBox(width: 10),
      ZenoButton(
        label: "BILL AI",
        icon: Icons.auto_awesome_rounded,
        variant: ZenoButtonVariant.secondary,
        size: compact ? ZenoButtonSize.sm : ZenoButtonSize.md,
        onPressed: () => _pickAndProcessBill(),
      ),
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF).withValues(alpha:0.9),
        border: Border.all(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
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
                left: BorderSide(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
                right: BorderSide(color: const Color(0xFF0066CC).withValues(alpha:0.2)),
              ),
            ),
            child: Row(
              children: [
                _StatToken(
                    label: "SCANNED",
                    value: "${widget.controller.bulkScanItems.length}",
                    color: const Color(0xFF0066CC)),
                const SizedBox(width: 16),
                _StatToken(
                    label: "READY",
                    value:
                        "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.ready).length}",
                    color: const Color(0xFF0066CC)),
                const SizedBox(width: 16),
                _StatToken(
                    label: "REVIEW",
                    value:
                        "${widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.review || i.status == BulkScanStatus.notFound).length + widget.controller.bulkScanItems.where((i) => i.status == BulkScanStatus.duplicate).length}",
                    color: const Color(0xFFf97316)),
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
            const Color(0xFFd4e4f0).withValues(alpha: 0.9),
            const Color(0xFFe8f0f8).withValues(alpha: 0.95),
          ],
        ),
        border: Border(top: BorderSide(color: const Color(0xFF0066CC).withValues(alpha: 0.2))),
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
            onPressed: () {},
          ),
          const SizedBox(width: 12),
          ZenoButton(
            label: "SAVE AS DRAFT",
            variant: ZenoButtonVariant.secondary,
            onPressed: () {},
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
}
