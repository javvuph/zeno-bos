import 'package:flutter/material.dart';

part 'parts/product_studio_variants_table_row.part.dart';

class ProductStudioVariantsTable extends StatefulWidget {
  const ProductStudioVariantsTable({super.key});

  @override
  State<ProductStudioVariantsTable> createState() => _ProductStudioVariantsTableState();
}

class _ProductStudioVariantsTableState extends State<ProductStudioVariantsTable> {
  final TextEditingController _stockAllController = TextEditingController();
  final TextEditingController _priceAllController = TextEditingController();

  List<VariantData> variants = [
    VariantData(colorName: 'White', colorCode: 0xFFFFFFFF, size: 'M', sku: 'White-M'),
    VariantData(colorName: 'White', colorCode: 0xFFFFFFFF, size: 'L', sku: 'White-L'),
    VariantData(colorName: 'Navy', colorCode: 0xFF1A237E, size: 'M', sku: 'Navy-M'),
    VariantData(colorName: 'Navy', colorCode: 0xFF1A237E, size: 'L', sku: 'Navy-L'),
    VariantData(colorName: 'Red', colorCode: 0xFFD32F2F, size: 'M', sku: 'Red-M'),
    VariantData(colorName: 'Red', colorCode: 0xFFD32F2F, size: 'L', sku: 'Red-L'),
  ];

  int? hoveredIndex;

  void _applyStockToAll() {
    final stock = _stockAllController.text;
    if (stock.isNotEmpty) {
      setState(() {
        for (var v in variants) {
          v.stockController.text = stock;
        }
      });
    }
  }

  void _applyPriceToAll() {
    final price = _priceAllController.text;
    if (price.isNotEmpty) {
      setState(() {
        for (var v in variants) {
          v.priceController.text = price;
        }
      });
    }
  }

  @override
  void dispose() {
    _stockAllController.dispose();
    _priceAllController.dispose();
    for (var v in variants) {
      v.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              _buildBulkInput(
                label: 'Fill Stock for All',
                controller: _stockAllController,
                onApply: _applyStockToAll,
              ),
              const SizedBox(width: 20),
              _buildBulkInput(
                label: 'Fill Price for All',
                controller: _priceAllController,
                onApply: _applyPriceToAll,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(50),
                1: FixedColumnWidth(80),
                2: FixedColumnWidth(60),
                3: FixedColumnWidth(140),
                4: FixedColumnWidth(70),
                5: FixedColumnWidth(80),
                6: FixedColumnWidth(50),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: Color(0xFFF5F5F5)),
                  children: [
                    _buildHeaderCell(''),
                    _buildHeaderCell('Colour'),
                    _buildHeaderCell('Size'),
                    _buildHeaderCell('SKU', textAlign: TextAlign.left),
                    _buildHeaderCell('Stock'),
                    _buildHeaderCell('Price (₹)'),
                    _buildHeaderCell('Delete'),
                  ],
                ),
                ...variants.asMap().entries.map((entry) {
                  final index = entry.key;
                  final variant = entry.value;
                  return _buildDataRow(variant, index);
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulkInput({
    required String label,
    required TextEditingController controller,
    required VoidCallback onApply,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 180,
          height: 40,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: label,
            ),
            style: const TextStyle(fontSize: 13),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            minimumSize: const Size(0, 40),
            elevation: 0,
            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
