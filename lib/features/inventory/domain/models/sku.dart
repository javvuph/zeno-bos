class SKU {
  final String value;

  const SKU(this.value);

  bool get isValid => value.isNotEmpty && value.length >= 3;

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SKU && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
