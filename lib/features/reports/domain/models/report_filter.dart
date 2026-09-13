enum FilterType { dateRange, branch, department, category, status, text, numeric }

class ReportFilter {
  final String id;
  final String label;
  final FilterType type;
  final dynamic value;

  const ReportFilter({
    required this.id,
    required this.label,
    required this.type,
    this.value,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'type': type.name,
    'value': _valueToJson(value),
  };

  factory ReportFilter.fromJson(Map<String, dynamic> json) => ReportFilter(
    id: json['id'],
    label: json['label'],
    type: FilterType.values.byName(json['type']),
    value: _valueFromJson(json['value'], FilterType.values.byName(json['type'])),
  );

  static dynamic _valueToJson(dynamic val) {
    if (val is DateTime) return val.toIso8601String();
    if (val is List<DateTime>) return val.map((d) => d.toIso8601String()).toList();
    return val;
  }

  static dynamic _valueFromJson(dynamic val, FilterType type) {
    if (type == FilterType.dateRange && val is List) {
      return val.map((d) => DateTime.parse(d)).toList();
    }
    return val;
  }
}
