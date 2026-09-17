import 'package:flutter/material.dart';
import '../../../controllers/product_studio_controller.dart';
import '../widgets/zeno_master_dropdown_field.dart';
import '../../../../domain/models/product_studio_models.dart';

class ProductRelationshipCard extends StatelessWidget {
  final ProductStudioController controller;

  const ProductRelationshipCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final data = controller.product;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF12121A) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? const Color(0xFF262638) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.hub_outlined, size: 16, color: Color(0xFF0066FF)),
              const SizedBox(width: 6),
              const Text(
                '≡ƒöù PRODUCT RELATIONSHIPS & BUNDLES [HQ]',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0066FF),
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              _buildAddLinkButton(context),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: ZenoMasterDropdownField<String>(
                  label: 'Relationship Type',
                  value: data.productRelationship.isEmpty
                      ? 'STANDALONE'
                      : data.productRelationship,
                  items: const [
                    DropdownMenuItem(value: 'STANDALONE', child: Text('Standalone Master')),
                    DropdownMenuItem(value: 'BUNDLE', child: Text('Bundle / Combo Kit')),
                    DropdownMenuItem(value: 'SUBSTITUTE', child: Text('Substitute / Alternative')),
                    DropdownMenuItem(value: 'REPLACEMENT', child: Text('Direct Replacement')),
                    DropdownMenuItem(value: 'PARENT', child: Text('Parent Style Master')),
                    DropdownMenuItem(value: 'CHILD', child: Text('Child Style Variant')),
                  ],
                  onChanged: (val) {
                    controller.updateField(productRelationship: val ?? 'STANDALONE');
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Linked Parent / Master SKU',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8)),
                    ),
                    const SizedBox(height: 3),
                    SizedBox(
                      height: 38,
                      child: TextField(
                        key: const ValueKey('parentSku_field'),
                        controller: TextEditingController(text: data.parentSku)
                          ..selection = TextSelection.collapsed(offset: data.parentSku.length),
                        onChanged: (val) => controller.updateField(parentSku: val),
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'Search or scan parent SKU...',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (data.comboItems.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              'Linked Bundle Components / Substitutes:',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: data.comboItems.map((item) {
                return Chip(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  label: Text('${item.sku} ├ù ${item.quantity}', style: const TextStyle(fontSize: 11)),
                  deleteIcon: const Icon(Icons.close, size: 14),
                  onDeleted: () {
                    final updated = List<ComboItem>.from(data.comboItems)..remove(item);
                    controller.updateField(comboItems: updated);
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddLinkButton(BuildContext context) {
    return SizedBox(
      height: 26,
      child: TextButton.icon(
        onPressed: () => _openAddRelationModal(context),
        icon: const Icon(Icons.add_link, size: 14),
        label: const Text('Add Component', style: TextStyle(fontSize: 11)),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: const Color(0xFF0066FF).withValues(alpha: 0.1),
          foregroundColor: const Color(0xFF0066FF),
        ),
      ),
    );
  }

  void _openAddRelationModal(BuildContext context) {
    final skuCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Link Product / Component', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: skuCtrl,
              decoration: const InputDecoration(labelText: 'Component SKU / Barcode', hintText: 'e.g. 5449000131805'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: qtyCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity Multiplier', hintText: '1'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (skuCtrl.text.isNotEmpty) {
                final qty = int.tryParse(qtyCtrl.text) ?? 1;
                final updated = List<ComboItem>.from(controller.product.comboItems)
                  ..add(ComboItem(sku: skuCtrl.text.trim(), quantity: qty));
                controller.updateField(comboItems: updated);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Link Item'),
          ),
        ],
      ),
    );
  }
}
