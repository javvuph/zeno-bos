import '../../models/product_studio_data.dart';

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

/// A single field pulled out of a bill/document by the AI extractor, shown for
/// human confirmation in [AIReviewDialog] before it is written to a product.
class AIExtractedField {
  final String label;
  String value;

  /// Extractor confidence in the range 0.0–1.0.
  final double confidence;

  /// Where the value came from, e.g. "OCR line 4" or "Vendor catalogue".
  final String source;

  /// Whether the operator has approved this value for population.
  bool isAccepted;

  AIExtractedField({
    required this.label,
    required this.value,
    this.confidence = 0.0,
    this.source = "AI",
    this.isAccepted = true,
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
