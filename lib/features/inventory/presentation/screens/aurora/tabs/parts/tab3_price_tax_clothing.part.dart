part of '../tab3_price_tax.dart';

extension _Tab3PriceTaxClothingState on Tab3PriceTax {
  Widget _buildClothingSmallLayout(BuildContext context, ProductStudioData p, ZenoSemanticColors colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _compactSection("STOCK", colors, [
                Row(
                  children: [
                    Expanded(child: ZenoTextField(label: "Opening Stock", initialValue: p.openingStock == 0 ? "" : p.openingStock.toString(), onChanged: (v) => controller.updateField(openingStock: double.tryParse(v) ?? 0.0), keyboardType: TextInputType.number)),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "Reorder Level", initialValue: p.reorderLevel.toString(), onChanged: (v) => controller.updateField(reorderLevel: double.tryParse(v)), keyboardType: TextInputType.number)),
                  ],
                ),
              ]),
              const SizedBox(height: 8), 
              _compactSection("SUPPLIER", colors, [
                ZenoDropdown<String>(label: "Primary Supplier", value: p.supplier.isEmpty ? null : p.supplier, items: controller.suppliersList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(supplier: v), onQuickAdd: () => _showQuickAddDialog(context, "Supplier", (val) => controller.addSupplier(val))),
              ]),
              const SizedBox(height: 8), 
              _compactSection("TAX", colors, [
                Row(
                  children: [
                    Expanded(flex: 2, child: ZenoTextField(label: "HSN / Tax Code", initialValue: p.hsnCode, onChanged: (v) => controller.updateField(hsnCode: v))),
                    const SizedBox(width: 8),
                    Expanded(flex: 3, child: ZenoDropdown<String>(label: "Tax Status", value: p.taxStatus, items: _withCurrent(Tab3PriceTax._taxStatusOptions, p.taxStatus).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(taxStatus: v), onQuickAdd: () => _showQuickAddDialog(context, "Tax Status", (val) => controller.updateField(taxStatus: val)))),
                  ],
                ),
                const SizedBox(height: 8), 
                ZenoTextField(label: "Tax Rate (%)", initialValue: p.taxRate.toString(), onChanged: (v) => controller.updateField(taxRate: double.tryParse(v)), keyboardType: TextInputType.number),
              ]),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _compactSection("PURCHASE & SELLING", colors, [
                Row(
                  children: [
                    Expanded(child: ZenoTextField(label: "Purchase / Cost", initialValue: p.costPrice.toString(), onChanged: (v) => controller.updateField(costPrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "Selling Price", initialValue: p.sellingPrice.toString(), onChanged: (v) => controller.updateField(sellingPrice: double.tryParse(v)), keyboardType: TextInputType.number)),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "MRP", initialValue: p.mrp.toString(), onChanged: (v) => controller.updateField(mrp: double.tryParse(v)), keyboardType: TextInputType.number)),
                  ],
                ),
              ]),
              const SizedBox(height: 8), 
              _compactSection("DISCOUNT & PROMOTION", colors, [
                Row(
                  children: [
                    Expanded(child: ZenoDropdown<String>(label: "Disc Type", value: p.discountType, items: _withCurrent(Tab3PriceTax._discountTypeOptions, p.discountType).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => controller.updateField(discountType: v), onQuickAdd: () => _showQuickAddDialog(context, "Disc Type", (val) => controller.updateField(discountType: val)))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "Disc Value", initialValue: p.discountValue.toString(), onChanged: (v) => controller.updateField(discountValue: double.tryParse(v)), keyboardType: TextInputType.number)),
                  ],
                ),
                const SizedBox(height: 8), 
                ZenoTextField(label: "Promo Price", initialValue: p.promotionalPrice.toString(), onChanged: (v) => controller.updateField(promotionalPrice: double.tryParse(v)), keyboardType: TextInputType.number),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
