import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';

class ItemDetailsDialog extends StatefulWidget {
  final BillItem item;
  final Function(String?, String?, DateTime?, String?) onSave;

  const ItemDetailsDialog({
    super.key,
    required this.item,
    required this.onSave,
  });

  @override
  State<ItemDetailsDialog> createState() => _ItemDetailsDialogState();
}

class _ItemDetailsDialogState extends State<ItemDetailsDialog> {
  late TextEditingController _serialController;
  late TextEditingController _batchController;
  late TextEditingController _notesController;
  DateTime? _selectedExpiry;

  @override
  void initState() {
    super.initState();
    _serialController = TextEditingController(text: widget.item.serialNumber);
    _batchController = TextEditingController(text: widget.item.batchNumber);
    _notesController = TextEditingController(text: widget.item.notes);
    _selectedExpiry = widget.item.expiryDate;
  }

  @override
  void dispose() {
    _serialController.dispose();
    _batchController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 450,
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(ZenoRadius.lg),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(colors),
            Padding(
              padding: const EdgeInsets.all(ZenoSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField('SERIAL NUMBER', _serialController, colors,
                      icon: Icons.qr_code_scanner),
                  const SizedBox(height: ZenoSpacing.md),
                  _buildTextField('BATCH NUMBER', _batchController, colors,
                      icon: Icons.layers_outlined),
                  const SizedBox(height: ZenoSpacing.md),
                  _buildExpiryPicker(colors),
                  const SizedBox(height: ZenoSpacing.md),
                  _buildTextField('LINE NOTES', _notesController, colors,
                      maxLines: 3, icon: Icons.note_alt_outlined),
                  const SizedBox(height: ZenoSpacing.xl),
                  _buildActionButtons(colors),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(ZenoRadius.lg)),
      ),
      child: Row(
        children: [
          const Icon(Icons.inventory_2_outlined, size: 20),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.productName,
                    style: ZenoTypography.headlineMD(colors.textPrimary)),
                Text(widget.item.sku,
                    style: ZenoTypography.micro(colors.textSecondary)),
              ],
            ),
          ),
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, size: 18)),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, ZenoSemanticColors colors,
      {int maxLines = 1, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: ZenoTypography.caption(colors.textDisabled)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            prefixIcon: icon != null
                ? Icon(icon, size: 16, color: colors.textSecondary)
                : null,
            filled: true,
            fillColor: colors.bgTier3,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ZenoRadius.sm),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildExpiryPicker(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('EXPIRY DATE', style: ZenoTypography.caption(colors.textDisabled)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _selectedExpiry ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 3650)),
            );
            if (picked != null) setState(() => _selectedExpiry = picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                color: colors.bgTier3,
                borderRadius: BorderRadius.circular(ZenoRadius.sm)),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: colors.textSecondary),
                const SizedBox(width: 12),
                Text(
                  _selectedExpiry == null
                      ? 'Not Set'
                      : _selectedExpiry!.toString().substring(0, 10),
                  style: const TextStyle(fontSize: 13),
                ),
                const Spacer(),
                if (_selectedExpiry != null)
                  IconButton(
                    onPressed: () => setState(() => _selectedExpiry = null),
                    icon: const Icon(Icons.clear, size: 14),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ZenoSemanticColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL')),
        const SizedBox(width: ZenoSpacing.md),
        ElevatedButton(
          onPressed: () {
            widget.onSave(
              _serialController.text.isEmpty ? null : _serialController.text,
              _batchController.text.isEmpty ? null : _batchController.text,
              _selectedExpiry,
              _notesController.text.isEmpty ? null : _notesController.text,
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: colors.accentPrimary,
              foregroundColor: Colors.black),
          child: const Text('SAVE CHANGES',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
