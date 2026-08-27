import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import '../aurora_field_renderer.dart';

class Tab6Suppliers extends StatelessWidget {
  final ProductStudioController controller;
  const Tab6Suppliers({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // 06 SUPPLIERS ΓÇö Multi-supplier sourcing matrix (ZERO-SCROLL)
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ROW 1: SUPPLIER SOURCING (Horizontal Table)
          ZenoCard(
            title: "≡ƒñ¥ SUPPLIER SOURCING",
            padding: const EdgeInsets.all(12),
            child: _buildSupplierMatrix(context),
          ),
          const SizedBox(height: 16),
          
          // ROW 2: SOURCE / CONTRACT
          ZenoCard(
            title: "≡ƒîì SOURCE / CONTRACT",
            padding: const EdgeInsets.all(12),
            child: AuroraFieldRenderer(
              controller: controller,
              fieldIds: const [
                "currency", "purchaseUom", "incoterms", "sourcingSplitPct"
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupplierMatrix(BuildContext context) {
    final List<String> headers = ["Supplier", "Role", "Supplier SKU", "Contract", "Cost", "MOQ", "Lead Days", "Payment"];
    
    return Column(
      children: [
        // HEADERS
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: headers.map((h) => Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: const BoxDecoration(color: Color(0xFFF8FAFC), border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))),
              child: Text(h, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF64748B))),
            ),
          )).toList(),
        ),
        // SAMPLE ROW 1 (PRIMARY)
        _buildSupplierRow(["Global Foods Ltd", "PRIMARY", "SUP-GF-990", "CT-2026-01", "Γé╣ 82.00", "50", "3", "Net 30"], isPrimary: true),
        // SAMPLE ROW 2 (SECONDARY)
        _buildSupplierRow(["Metro Supply", "SECONDARY", "M-INV-44", "CT-2026-05", "Γé╣ 84.50", "20", "5", "COD"]),
        // SAMPLE ROW 3 (BACKUP)
        _buildSupplierRow(["Quick Import", "BACKUP", "Q-X-101", "ΓÇö", "Γé╣ 88.00", "5", "1", "Credit"]),
      ],
    );
  }

  Widget _buildSupplierRow(List<String> data, {bool isPrimary = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: data.map((d) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFFF0F9FF) : Colors.transparent,
            border: const Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
          ),
          child: Text(
            d, 
            style: TextStyle(
              fontSize: 10, 
              fontWeight: isPrimary ? FontWeight.w800 : FontWeight.w600,
              color: isPrimary ? const Color(0xFF0284C7) : const Color(0xFF334155),
            )
          ),
        ),
      )).toList(),
    );
  }
}
