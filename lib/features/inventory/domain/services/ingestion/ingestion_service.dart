
import 'dart:convert';
import 'dart:io';
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
    if (rawRows.isEmpty) {
      return const IngestionMappingResult(
          rows: [], summary: IngestionSummary());
    }

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

      if (status == IngestionRowStatus.valid) {
        valid++;
      } else if (status == IngestionRowStatus.warning)
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

      if (status == IngestionRowStatus.valid) {
        valid++;
      } else if (status == IngestionRowStatus.warning)
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

  /// Extracts product data from a selected bill/image file using the configured AI service.
  Future<ProductStudioData> processAIBill(dynamic file) async {
    final list = await processAIBillMultiple(file);
    return list.isNotEmpty ? list.first : ProductStudioData.empty();
  }

  Future<List<ProductStudioData>> processAIBillMultiple(dynamic file) async {
    if (aiService == null) {
      throw StateError('AI product service is not configured');
    }

    final path = file is String ? file : file?.path?.toString();
    if (path == null || path.isEmpty) {
      throw ArgumentError('A valid file path is required');
    }

    final selectedFile = File(path);
    if (!await selectedFile.exists()) {
      throw FileSystemException('Selected file was not found', path);
    }

    final extension = path.split('.').last.toLowerCase();
    final bytes = await selectedFile.readAsBytes();
    final encoded = base64Encode(bytes);

    final promptSource = 'FILE_TYPE: $extension\\nFILE_BASE64:\\n$encoded';
    final payload = (extension == 'png' ||
            extension == 'jpg' ||
            extension == 'jpeg' ||
            extension == 'webp')
        ? await aiService!.parseImageToProductPayload(promptSource)
        : await aiService!.parseBillToProductPayload(promptSource);

    if (payload.isEmpty) {
      throw StateError('AI returned no product data');
    }

    final dynamic rawProducts =
        payload['products'] ?? payload['line_items'] ?? payload['items'];
    if (rawProducts is List) {
      return rawProducts
          .whereType<Map>()
          .map((row) => mapper.mapJsonToProductStudio(
                Map<String, dynamic>.from(row),
              ))
          .toList();
    }

    return [mapper.mapJsonToProductStudio(payload)];
  }
}
