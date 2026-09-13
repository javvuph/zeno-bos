import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'package:zeno/features/inventory/domain/models/batch.dart';

class ExpirySection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;

  const ExpirySection({
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
              "EXPIRY & SHELF-LIFE MANAGEMENT",
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
                value: controller.product.enableExpiryTracking,
                onChanged: (v) => controller.updateField(enableExpiryTracking: v),
                activeThumbColor: colors.accentPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (controller.product.enableExpiryTracking) ...[
          _buildExpiryConfigGrid(),
          const SizedBox(height: 32),
          _buildExpiringBatchesTable(),
        ] else
          _buildDisabledState(),
      ],
    );
  }

  Widget _buildExpiryConfigGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 3,
      children: [
        ZenoTextField(
          label: "Expiry Warning Threshold (Days)",
          initialValue: controller.product.expiryWarningThreshold.toString(),
          onChanged: (v) => controller.updateField(expiryWarningThreshold: int.tryParse(v)),
        ),
        ZenoTextField(
          label: "Freshness Duration",
          initialValue: controller.product.freshnessDuration.toString(),
          onChanged: (v) => controller.updateField(freshnessDuration: int.tryParse(v)),
        ),
        _buildDropdown(
          label: "Freshness Unit",
          value: controller.product.freshnessUnit,
          items: const ["Hours", "Days", "Weeks", "Months"],
          onChanged: (v) => controller.updateField(freshnessUnit: v),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Cold Storage Required",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textPrimary),
              ),
            ),
            Switch(
              value: controller.product.coldStorageIndicator,
              onChanged: (v) => controller.updateField(coldStorageIndicator: v),
              activeThumbColor: colors.accentPrimary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({required String label, required String value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: colors.bgTier3,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12)))).toList(),
              onChanged: onChanged,
              isExpanded: true,
              dropdownColor: colors.bgTier2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpiringBatchesTable() {
    final batches = controller.product.batches.where((b) => b.expiryDate != null).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("BATCH EXPIRY MONITOR", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textDisabled, letterSpacing: 1)),
        const SizedBox(height: 12),
        if (batches.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(8)),
            child: const Center(child: Text("No batches with expiry dates defined.", style: TextStyle(fontSize: 11))),
          )
        else
          Container(
            decoration: BoxDecoration(border: Border.all(color: colors.borderSubtle), borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                _buildTableHeader(),
                ...batches.map((b) => _buildBatchExpiryRow(b)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: colors.bgTier3,
      child: const Row(
        children: [
          Expanded(child: Text("BATCH #", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
          Expanded(child: Text("EXPIRY DATE", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
          Expanded(child: Text("STATUS", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildBatchExpiryRow(Batch batch) {
    final now = DateTime.now();
    final isExpired = batch.expiryDate!.isBefore(now);
    final isWarning = !isExpired && batch.expiryDate!.difference(now).inDays < controller.product.expiryWarningThreshold;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          Expanded(child: Text(batch.batchNumber, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
          Expanded(child: Text("${batch.expiryDate!.day}/${batch.expiryDate!.month}/${batch.expiryDate!.year}", style: const TextStyle(fontSize: 11))),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isExpired ? colors.statusDanger.withValues(alpha: 0.1) : (isWarning ? colors.statusWarning.withValues(alpha: 0.1) : colors.statusSuccess.withValues(alpha: 0.1)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isExpired ? "EXPIRED" : (isWarning ? "NEAR EXPIRY" : "HEALTHY"),
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: isExpired ? colors.statusDanger : (isWarning ? colors.statusWarning : colors.statusSuccess)),
              ),
            ),
          ),
        ],
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
            Icon(Icons.timer_off_outlined, size: 48, color: colors.textDisabled),
            const SizedBox(height: 16),
            Text(
              "Expiry Tracking is Disabled",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: colors.textDisabled),
            ),
            const SizedBox(height: 8),
            Text(
              "Products will not be monitored for shelf-life or expiry alerts.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: colors.textDisabled.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              height: 1,
              child: Container(color: colors.borderSubtle),
            ),
          ],
        ),
      ),
    );
  }
}
