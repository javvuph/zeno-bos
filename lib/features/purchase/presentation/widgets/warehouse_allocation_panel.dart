import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/grn.dart';

class WarehouseAllocationPanel extends StatelessWidget {
  final GRNItem item;
  final Function(String) onBinSelected;

  const WarehouseAllocationPanel({
    super.key,
    required this.item,
    required this.onBinSelected,
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
              const Icon(Icons.warehouse_outlined,
                  size: 20, color: Colors.indigo),
              const SizedBox(width: 12),
              Text("ALLOCATION: ${item.orderItem.name.toUpperCase()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          _infoRow("ASSIGNED ZONE", "ZONE-A (ELECTRONICS)"),
          const SizedBox(height: 12),
          _infoRow("RECOMMENDED BIN", "BIN-104", isHighlight: true),
          const SizedBox(height: 24),
          const Text("SELECT STORAGE BIN",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _binPill("BIN-101", false),
              _binPill("BIN-102", false),
              _binPill("BIN-103", false),
              _binPill("BIN-104", true),
              _binPill("BIN-105", false),
              _binPill("BIN-106", false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10, fontWeight: FontWeight.w700, color: Colors.grey)),
        Text(value,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: isHighlight ? const Color(0xFF00F0FF) : null)),
      ],
    );
  }

  Widget _binPill(String id, bool isRecommended) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isRecommended ? const Color(0x1A00F0FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: isRecommended
                ? const Color(0xFF00F0FF)
                : Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Text(id,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isRecommended ? const Color(0xFF00F0FF) : Colors.grey)),
    );
  }
}
