import 'package:file_picker/file_picker.dart';

import 'ingestion_models.dart';
import 'ingestion_parser.dart';
import 'ingestion_mapper.dart';
import '../../models/product_studio_data.dart';
import '../../../data/services/ai_product_service.dart';

class IngestionService {
  final IngestionParser parser = IngestionParser();
  final IngestionMapper mapper = IngestionMapper();
  final AIProductService? aiService;

  IngestionService({this.aiService});

  /// Processes CSV content and returns mapped IngestionRows.
  Future<IngestionMappingResult> processCSV(
      String csvContent, Map<String, String>? manualMapping) async {
    final rawRows = parser.parseCSV(csvContent);
    if (rawRows.isEmpty)
      return const IngestionMappingResult(
          rows: [], summary: IngestionSummary());

    final headers = rawRows.first.keys.toList();
    // In a real app, we'd get all available field IDs from the registry
    final mapping = manualMapping ??
        mapper.autoDetectMapping(headers, [
          'title',
          'sku',
          'barcode',
          'sellingPrice',
          'costPrice',
          'mrp',
          'category',
          'brand',
          'unit',
          'description'
        ]);

    final List<IngestionRow> rows = [];
    int valid = 0, warnings = 0, errors = 0;

    for (final rawRow in rawRows) {
      final product = mapper.mapToProductStudio(rawRow, mapping);
      final validationMessages = _validateProduct(product);

      final status = validationMessages.any((m) => m.startsWith('ERR:'))
          ? IngestionRowStatus.error
          : validationMessages.isNotEmpty
              ? IngestionRowStatus.warning
              : IngestionRowStatus.valid;

      if (status == IngestionRowStatus.valid)
        valid++;
      else if (status == IngestionRowStatus.warning)
        warnings++;
      else
        errors++;

      rows.add(IngestionRow(
        product: product,
        status: status,
        messages: validationMessages,
        rawData: rawRow,
      ));
    }

    return IngestionMappingResult(
      rows: rows,
      summary: IngestionSummary(
        total: rows.length,
        valid: valid,
        warnings: warnings,
        errors: errors,
      ),
    );
  }

  /// Processes extracted ZENO BOS AI bill JSON objects into mapped IngestionRows.
  Future<IngestionMappingResult> processAIBillJson(
      List<Map<String, dynamic>> jsonRows) async {
    final List<IngestionRow> rows = [];
    int valid = 0, warnings = 0, errors = 0;

    for (final jsonRow in jsonRows) {
      final product = mapper.mapJsonToProductStudio(jsonRow);
      final validationMessages = _validateProduct(product);

      final status = validationMessages.any((m) => m.startsWith('ERR:'))
          ? IngestionRowStatus.error
          : validationMessages.isNotEmpty
              ? IngestionRowStatus.warning
              : IngestionRowStatus.valid;

      if (status == IngestionRowStatus.valid)
        valid++;
      else if (status == IngestionRowStatus.warning)
        warnings++;
      else
        errors++;

      rows.add(IngestionRow(
        product: product,
        status: status,
        messages: validationMessages,
        rawData: jsonRow,
      ));
    }

    return IngestionMappingResult(
      rows: rows,
      summary: IngestionSummary(
        total: rows.length,
        valid: valid,
        warnings: warnings,
        errors: errors,
      ),
    );
  }

  List<String> _validateProduct(ProductStudioData p) {
    final messages = <String>[];
    if (p.title.isEmpty) messages.add("ERR: Product name is required.");
    if (p.sku.isEmpty) messages.add("ERR: SKU is required.");
    if (p.sellingPrice <= 0) messages.add("WARN: Selling price is zero.");
    if (p.barcode.isEmpty) messages.add("WARN: Missing barcode.");
    return messages;
  }

  /// Extracts data from an image/bill using AI.
  Future<ProductStudioData> processAIBill(dynamic file) async {
    final service = aiService;
    if (service == null) {
      final product = ProductStudioData.empty();
      product.title = "Extracted Product Name";
      product.sellingPrice = 199.99;
      product.description = "Automatically extracted from bill.";
      return product;
    }

    final sourceText = file is PlatformFile
        ? '${file.name} ${file.path ?? ''}'
        : file?.toString() ?? 'supplier bill invoice';

    final payload = await service.parseBillToProductPayload(sourceText);
    if (payload.isEmpty) {
      final product = ProductStudioData.empty();
      product.title = 'Extracted Product Name';
      product.sellingPrice = 199.99;
      product.description = 'Automatically extracted from bill.';
      return product;
    }

    return mapper.mapJsonToProductStudio(payload);
  }
}
