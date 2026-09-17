part of '../product_studio_variants_table.dart';

extension _ProductStudioVariantsTableRowState on _ProductStudioVariantsTableState {
  Widget _buildHeaderCell(String text, {TextAlign textAlign = TextAlign.center}) {
    return TableCell(
      child: Container(
        height: 40,
        alignment: textAlign == TextAlign.center ? Alignment.center : Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF666666),
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  TableRow _buildDataRow(VariantData variant, int index) {
    final isHovered = hoveredIndex == index;
    
    return TableRow(
      decoration: BoxDecoration(
        color: isHovered ? Colors.blue.withValues(alpha: 0.05) : Colors.white,
        border: const Border(
          bottom: BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
      children: [
        _wrapCell(
          Center(
            child: Checkbox(
              value: variant.isSelected,
              activeColor: Colors.blue,
              onChanged: (val) => setState(() => variant.isSelected = val ?? false),
            ),
          ),
          index,
        ),
        _wrapCell(
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(variant.colorCode),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  variant.colorName, 
                  style: const TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          index,
        ),
        _wrapCell(
          Center(
            child: Text(
              variant.size,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          index,
        ),
        _wrapCell(
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              variant.sku,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
          index,
        ),
        _wrapCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: variant.stockController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
              style: const TextStyle(fontSize: 13),
              keyboardType: TextInputType.number,
            ),
          ),
          index,
        ),
        _wrapCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: variant.priceController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
              style: const TextStyle(fontSize: 13),
              keyboardType: TextInputType.number,
            ),
          ),
          index,
        ),
        _wrapCell(
          Center(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    variants.removeAt(index);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '✕',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          index,
        ),
      ],
    );
  }

  Widget _wrapCell(Widget child, int index) {
    return TableCell(
      child: MouseRegion(
        onEnter: (_) => setState(() => hoveredIndex = index),
        onExit: (_) => setState(() => hoveredIndex = null),
        child: Container(
          height: 70,
          alignment: Alignment.centerLeft,
          child: child,
        ),
      ),
    );
  }
}

class VariantData {
  final String colorName;
  final int colorCode;
  final String size;
  final String sku;
  bool isSelected;
  final TextEditingController stockController;
  final TextEditingController priceController;

  VariantData({
    required this.colorName,
    required this.colorCode,
    required this.size,
    required this.sku,
    this.isSelected = false,
  })  : stockController = TextEditingController(),
        priceController = TextEditingController();

  void dispose() {
    stockController.dispose();
    priceController.dispose();
  }
}
