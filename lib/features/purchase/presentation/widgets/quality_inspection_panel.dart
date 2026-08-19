import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/grn.dart';

class QualityInspectionPanel extends StatelessWidget {
  final GRNItem item;
  final Function(GRNItem) onUpdate;

  const QualityInspectionPanel({
    super.key,
    required this.item,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.fact_check_outlined,
                  size: 20, color: Colors.blue),
              const SizedBox(width: 12),
              Text("INSPECTION: ${item.orderItem.name.toUpperCase()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 20),
          _buildCounter("ACCEPTED QUANTITY", item.acceptedQuantity,
              (v) => onUpdate(item.copyWith(acceptedQuantity: v)), colors),
          const SizedBox(height: 12),
          _buildCounter("REJECTED QUANTITY", item.rejectedQuantity,
              (v) => onUpdate(item.copyWith(rejectedQuantity: v)), colors,
              color: Colors.red),
          const SizedBox(height: 12),
          _buildCounter("DAMAGED QUANTITY", item.damagedQuantity,
              (v) => onUpdate(item.copyWith(damagedQuantity: v)), colors,
              color: Colors.orange),
          const SizedBox(height: 24),
          const Text("INSPECTION STATUS",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              _statusChip(QualityStatus.passed, "PASSED", Colors.green,
                  item.inspectionStatus == QualityStatus.passed),
              const SizedBox(width: 8),
              _statusChip(QualityStatus.failed, "FAILED", Colors.red,
                  item.inspectionStatus == QualityStatus.failed),
              const SizedBox(width: 8),
              _statusChip(QualityStatus.conditional, "HOLD", Colors.orange,
                  item.inspectionStatus == QualityStatus.conditional),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(String label, double value, Function(double) onChanged,
      ZenoSemanticColors colors,
      {Color? color}) {
    return Row(
      children: [
        Expanded(
            child: Text(label,
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey))),
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: colors.bgTier1,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 14),
                onPressed: () => onChanged(value > 0 ? value - 1 : 0),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32),
              ),
              Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(value.toInt().toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: color)),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 14),
                onPressed: () => onChanged(value + 1),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusChip(
      QualityStatus status, String label, Color color, bool isSelected) {
    return Expanded(
      child: InkWell(
        onTap: () {}, // Handle update
        child: Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: isSelected ? color : Colors.grey.withValues(alpha: 0.3)),
          ),
          child: Text(label,
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: isSelected ? color : Colors.grey)),
        ),
      ),
    );
  }
}
