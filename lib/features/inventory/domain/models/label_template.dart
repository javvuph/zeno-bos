enum LabelType { product, shelf, price, batch, carton, pallet, bin }

class LabelTemplate {
  final String id;
  final String name;
  final LabelType type;
  final double width; // in mm
  final double height; // in mm
  final List<String> fields; // e.g., ["name", "price", "sku", "barcode"]
  final bool hasLogo;
  final String barcodeFormat; // EAN13, QR, CODE128

  const LabelTemplate({
    required this.id,
    required this.name,
    required this.type,
    this.width = 50.0,
    this.height = 30.0,
    this.fields = const ["name", "barcode"],
    this.hasLogo = false,
    this.barcodeFormat = "CODE128",
  });

  String get dimensions => "${width}x${height}mm";
}
