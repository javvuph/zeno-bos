import '../../models/product_studio_data.dart';
import '../../models/product_studio_enums.dart';

enum IngestionSource { aiBill, csv, excel, bulk, api, barcode }

enum IngestionRowStatus { valid, warning, error, duplicate }

class IngestionRow {
  final ProductStudioData product;
  IngestionRowStatus status;
  final List<String> messages;
  final Map<String, dynamic> rawData;
  bool isSelected;

  IngestionRow({
    required this.product,
    this.status = IngestionRowStatus.valid,
    this.messages = const [],
    this.rawData = const {},
    this.isSelected = false,
  });
}

class IngestionSummary {
  final int total;
  final int valid;
  final int warnings;
  final int errors;
  final int duplicates;

  const IngestionSummary({
    this.total = 0,
    this.valid = 0,
    this.warnings = 0,
    this.errors = 0,
    this.duplicates = 0,
  });
}

class IngestionMappingResult {
  final List<IngestionRow> rows;
  final IngestionSummary summary;

  const IngestionMappingResult({
    required this.rows,
    required this.summary,
  });
}
