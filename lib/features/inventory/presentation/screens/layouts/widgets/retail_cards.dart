import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'package:zeno/features/inventory/domain/models/supplier_relationship.dart';

class RetailVisualCard extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final Color accentColor;
  final ZenoSemanticColors colors;
  final Widget child;

  const RetailVisualCard({
    super.key,
    required this.index,
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.colors,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: colors.bgTier3,
              border: Border(bottom: BorderSide(color: colors.borderSubtle)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 16, color: accentColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CARD $index", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: accentColor, letterSpacing: 1)),
                      Text(title.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: colors.textPrimary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Padding(padding: const EdgeInsets.all(16), child: SingleChildScrollView(child: child))),
        ],
      ),
    );
  }
}

class SupplierMatrixRetailCard extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;

  const SupplierMatrixRetailCard({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                const Icon(Icons.hub_rounded, color: Colors.lightBlueAccent, size: 20),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("PROCUREMENT HUB", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.lightBlueAccent.withValues(alpha: 0.7), letterSpacing: 1.5)),
                    const Text("MULTI-SOURCE SUPPLIER MATRIX", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white)),
                  ],
                ),
                const Spacer(),
                ZenoButton(
                  label: "ADD SUPPLIER SOURCE",
                  icon: Icons.add_link_rounded,
                  variant: ZenoButtonVariant.secondary,
                  size: ZenoButtonSize.sm,
                  onPressed: () => _showSupplierPicker(context),
                ),
              ],
            ),
          ),
          if (controller.product.supplierRelationships.isEmpty)
            _buildEmptyState(colors)
          else
            _buildSupplierMatrixTable(context),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ZenoSemanticColors colors) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.account_tree_outlined, size: 32, color: colors.textDisabled),
          const SizedBox(height: 12),
          Text("No procurement sources defined. Connect suppliers to enable cost matrix.", style: TextStyle(fontSize: 11, color: colors.textDisabled)),
        ],
      ),
    );
  }

  Widget _buildSupplierMatrixTable(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white10)),
      child: Column(
        children: [
          _buildTableHeader(),
          ...controller.product.supplierRelationships.asMap().entries.map((e) => _buildSupplierRow(context, e.key, e.value)),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(color: Colors.black26, border: Border(bottom: BorderSide(color: Colors.white10))),
      child: const Row(
        children: [
          MatrixCol(flex: 3, label: "SUPPLIER ENTITY"),
          MatrixCol(flex: 2, label: "SUP-SKU"),
          MatrixCol(flex: 2, label: "LANDED COST"),
          MatrixCol(flex: 1, label: "MOQ"),
          MatrixCol(flex: 1, label: "LEAD"),
          MatrixCol(flex: 1, label: "PRIMARY"),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildSupplierRow(BuildContext context, int index, SupplierRelationship rel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(rel.supplierName, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text(rel.supplierSku ?? "-", style: const TextStyle(color: Colors.white70, fontSize: 11))),
          Expanded(flex: 2, child: Text("${controller.product.currency} ${rel.purchaseCost}", style: const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text("${rel.moq}", style: const TextStyle(color: Colors.white70, fontSize: 11))),
          Expanded(flex: 1, child: Text("${rel.leadTime}d", style: const TextStyle(color: Colors.white70, fontSize: 11))),
          Expanded(flex: 1, child: Radio<bool>(value: true, groupValue: rel.isPrimary, onChanged: (v) => controller.setPrimarySupplier(index), activeColor: Colors.blueAccent)),
          SizedBox(width: 40, child: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18), onPressed: () => controller.removeSupplierRelationship(index))),
        ],
      ),
    );
  }

  void _showSupplierPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Supplier"),
        content: SizedBox(width: 300, child: ListView.builder(shrinkWrap: true, itemCount: controller.suppliersList.length, itemBuilder: (context, i) => ListTile(title: Text(controller.suppliersList[i]), onTap: () { controller.addSupplierRelationship(controller.suppliersList[i]); Navigator.pop(context); }))),
      ),
    );
  }
}

class MatrixCol extends StatelessWidget {
  final int flex;
  final String label;
  const MatrixCol({super.key, required this.flex, required this.label});
  @override
  Widget build(BuildContext context) {
    return Expanded(flex: flex, child: Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.white38, letterSpacing: 1)));
  }
}
