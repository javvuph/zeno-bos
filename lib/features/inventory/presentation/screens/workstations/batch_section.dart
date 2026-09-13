import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/batch.dart';

class BatchSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;

  const BatchSection({
    super.key,
    required this.controller,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "BATCH TRACKING CONTROL",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: colors.textPrimary,
              ),
            ),
            const Spacer(),
            Transform.scale(
              scale: 0.8,
              child: Switch(
                value: controller.product.enableBatchTracking,
                onChanged: (v) => controller.updateField(enableBatchTracking: v),
                activeThumbColor: colors.accentPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (controller.product.enableBatchTracking) ...[
          _buildActiveBatchesHeader(),
          const SizedBox(height: 12),
          ...controller.product.batches.asMap().entries.map((e) => _buildBatchRow(context, e.key, e.value)),
          const SizedBox(height: 16),
          ZenoButton(
            label: "ADD NEW BATCH",
            icon: Icons.add_circle_outline,
            variant: ZenoButtonVariant.secondary,
            onPressed: controller.addNewBatch,
          ),
        ] else
          _buildDisabledState(),
      ],
    );
  }

  Widget _buildActiveBatchesHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          _headerText("BATCH NUMBER", 2),
          _headerText("MFG DATE", 2),
          _headerText("EXP DATE", 2),
          _headerText("QTY", 1),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _headerText(String label, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          color: colors.textDisabled,
        ),
      ),
    );
  }

  Widget _buildBatchRow(BuildContext context, int index, Batch batch) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ZenoTextField(
              label: null,
              initialValue: batch.batchNumber,
              onChanged: (v) => controller.updateBatch(index, batchNumber: v),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: _buildDatePicker(
              context: context,
              value: batch.manufacturingDate,
              onChanged: (v) => controller.updateBatch(index, mfgDate: v),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: _buildDatePicker(
              context: context,
              value: batch.expiryDate,
              onChanged: (v) => controller.updateBatch(index, expiryDate: v),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: ZenoTextField(
              label: null,
              initialValue: batch.quantity.toString(),
              onChanged: (v) => controller.updateBatch(index, quantity: double.tryParse(v) ?? 0),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, color: colors.statusDanger, size: 20),
            onPressed: () => controller.removeBatch(index),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker({required BuildContext context, required DateTime? value, required ValueChanged<DateTime> onChanged}) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(context: context, initialDate: value ?? DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
        if (picked != null) onChanged(picked);
      }, 
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          children: [
            Text(
              value == null ? "Select..." : "${value.day}/${value.month}/${value.year}",
              style: TextStyle(fontSize: 11, color: value == null ? colors.textDisabled : colors.textPrimary),
            ),
            const Spacer(),
            Icon(Icons.calendar_today_rounded, size: 14, color: colors.textDisabled),
          ],
        ),
      ),
    );
  }

  Widget _buildDisabledState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle, style: BorderStyle.solid),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.layers_clear_outlined, size: 48, color: colors.textDisabled),
            const SizedBox(height: 16),
            Text(
              "Batch Tracking is Disabled for this Product",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: colors.textDisabled),
            ),
            const SizedBox(height: 8),
            Text(
              "Enable it to track inventory by manufacturing lots and expiry dates.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: colors.textDisabled.withValues(alpha: 0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
