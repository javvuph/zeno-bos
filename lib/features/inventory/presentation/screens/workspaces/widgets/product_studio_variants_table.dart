// PRODUCT STUDIO TABLE - COPY TO FLUTTER

import 'package:flutter/material.dart';

class ProductStudioVariantsTable extends StatefulWidget {
  const ProductStudioVariantsTable({super.key});

  @override
  _ProductStudioVariantsTableState createState() =>
      _ProductStudioVariantsTableState();
}

class _ProductStudioVariantsTableState extends State<ProductStudioVariantsTable> {
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  List<Map<String, dynamic>> variants = [
    {'colour': 'White', 'colourCode': '#ffffff', 'size': 'M', 'sku': 'White-M', 'stock': 0, 'price': 0.0},
    {'colour': 'White', 'colourCode': '#ffffff', 'size': 'L', 'sku': 'White-L', 'stock': 0, 'price': 0.0},
    {'colour': 'Navy', 'colourCode': '#1a237e', 'size': 'M', 'sku': 'Navy-M', 'stock': 0, 'price': 0.0},
    {'colour': 'Navy', 'colourCode': '#1a237e', 'size': 'L', 'sku': 'Navy-L', 'stock': 0, 'price': 0.0},
    {'colour': 'Red', 'colourCode': '#d32f2f', 'size': 'M', 'sku': 'Red-M', 'stock': 0, 'price': 0.0},
    {'colour': 'Red', 'colourCode': '#d32f2f', 'size': 'L', 'sku': 'Red-L', 'stock': 0, 'price': 0.0},
  ];

  void applyStockToAll() {
    if (_stockController.text.isEmpty) return;
    int stock = int.tryParse(_stockController.text) ?? 0;
    setState(() {
      for (var v in variants) {
        v['stock'] = stock;
      }
    });
  }

  void applyPriceToAll() {
    if (_priceController.text.isEmpty) return;
    double price = double.tryParse(_priceController.text) ?? 0.0;
    setState(() {
      for (var v in variants) {
        v['price'] = price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // BULK FILL INPUTS
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _stockController,
                  decoration: const InputDecoration(
                    labelText: 'Fill Stock for All',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: applyStockToAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text('Apply'),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Fill Price for All',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: applyPriceToAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 12),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
        ),

        // TABLE
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateColor.resolveWith((states) => const Color(0xFFF5F5F5)),
            columns: const [
              DataColumn(label: Center(child: Text('', style: TextStyle(fontWeight: FontWeight.bold)))), // Checkbox
              DataColumn(label: Center(child: Text('Colour', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF666666))))),
              DataColumn(label: Center(child: Text('Size', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF666666))))),
              DataColumn(label: Text('SKU', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF666666)))), // Left-aligned
              DataColumn(label: Center(child: Text('Stock', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF666666))))),
              DataColumn(label: Center(child: Text('Price (₹)', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF666666))))),
              DataColumn(label: Center(child: Text('', style: TextStyle(fontWeight: FontWeight.bold)))), // Delete
            ],
            rows: variants.map((v) {
              return DataRow(
                cells: [
                  DataCell(Center(child: Checkbox(value: false, onChanged: (val) {}))),
                  DataCell(
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(int.parse('0xFF${v['colourCode'].replaceFirst('#', '')}')),
                              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(v['colour']),
                        ],
                      ),
                    ),
                  ),
                  DataCell(Center(child: Text(v['size'], style: const TextStyle(fontWeight: FontWeight.bold)))),
                  DataCell(Text(v['sku'], style: const TextStyle(fontFamily: 'monospace'))),
                  DataCell(
                    Center(
                      child: SizedBox(
                        width: 70,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(8),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          controller: TextEditingController(text: v['stock'].toString()),
                          onChanged: (val) {
                            v['stock'] = int.tryParse(val) ?? 0;
                          },
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: SizedBox(
                        width: 80,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.all(8),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          controller: TextEditingController(text: v['price'].toString()),
                          onChanged: (val) {
                            v['price'] = double.tryParse(val) ?? 0.0;
                          },
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            variants.remove(v);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
