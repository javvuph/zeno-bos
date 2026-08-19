class Barcode {
  final String value;
  final String type; // EAN13, UPC, QR, etc.

  const Barcode(this.value, {this.type = 'EAN13'});

  bool get isValid => value.isNotEmpty;

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Barcode &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
