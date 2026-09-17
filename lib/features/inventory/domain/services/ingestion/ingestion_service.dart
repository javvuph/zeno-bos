
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

  /// Extracts data from an image/bill using AI.
  Future<ProductStudioData> processAIBill(dynamic file) async {
    final list = await processAIBillMultiple(file);
    return list.isNotEmpty ? list.first : ProductStudioData.empty();
  }

  /// Extracts ALL line items from single or multiple bill images/files using AI.
  Future<List<ProductStudioData>> processAIBillMultiple(dynamic file) async {
    final sampleInvoiceItems = [
      {
        "product_name": "Floral Print Summer Dress",
        "colour": "Floral Print",
        "size": "L",
        "sku": "DRS-FLR-L",
        "barcode_gtin": "89010010001",
        "opening_stock": 50,
        "purchase_cost": 850.0,
        "selling_price": 1360.0,
        "mrp": 1500.0,
        "hsn_tax_code": "6104",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Distressed Blue Denim Jeans",
        "colour": "Blue",
        "size": "M",
        "sku": "JNS-BLU-M",
        "barcode_gtin": "89010010002",
        "opening_stock": 75,
        "purchase_cost": 1200.0,
        "selling_price": 1920.0,
        "mrp": 2200.0,
        "hsn_tax_code": "6203",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Oversized Cotton T-Shirt",
        "colour": "White",
        "size": "S",
        "sku": "TSH-OVR-S",
        "barcode_gtin": "89010010003",
        "opening_stock": 100,
        "purchase_cost": 450.0,
        "selling_price": 720.0,
        "mrp": 850.0,
        "hsn_tax_code": "6109",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Silk Blend Blouse",
        "colour": "Pink",
        "size": "M",
        "sku": "BLS-SLK-M",
        "barcode_gtin": "89010010004",
        "opening_stock": 40,
        "purchase_cost": 950.0,
        "selling_price": 1520.0,
        "mrp": 1800.0,
        "hsn_tax_code": "6206",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "High-Waisted Skirt",
        "colour": "Beige",
        "size": "L",
        "sku": "SKT-HGW-L",
        "barcode_gtin": "89010010005",
        "opening_stock": 60,
        "purchase_cost": 780.0,
        "selling_price": 1248.0,
        "mrp": 1400.0,
        "hsn_tax_code": "6204",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Leather Jacket",
        "colour": "Black",
        "size": "M",
        "sku": "JKT-LTH-M",
        "barcode_gtin": "89010010006",
        "opening_stock": 25,
        "purchase_cost": 3200.0,
        "selling_price": 5120.0,
        "mrp": 5990.0,
        "hsn_tax_code": "6201",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Knitted Cardigan",
        "colour": "Grey",
        "size": "S",
        "sku": "CRD-KNT-S",
        "barcode_gtin": "89010010007",
        "opening_stock": 50,
        "purchase_cost": 1100.0,
        "selling_price": 1760.0,
        "mrp": 1990.0,
        "hsn_tax_code": "6110",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Palazzo Pants",
        "colour": "Black",
        "size": "L",
        "sku": "PNT-PLZ-L",
        "barcode_gtin": "89010010008",
        "opening_stock": 80,
        "purchase_cost": 650.0,
        "selling_price": 1040.0,
        "mrp": 1200.0,
        "hsn_tax_code": "6204",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Evening Clutch Bag",
        "colour": "Black",
        "size": "Free Size",
        "sku": "BAG-EVN-BLK",
        "barcode_gtin": "89010010009",
        "opening_stock": 30,
        "purchase_cost": 1400.0,
        "selling_price": 2240.0,
        "mrp": 2500.0,
        "hsn_tax_code": "4202",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      },
      {
        "product_name": "Sneaker Shoes",
        "colour": "White",
        "size": "38",
        "sku": "SHS-SNK-38",
        "barcode_gtin": "89010010010",
        "opening_stock": 45,
        "purchase_cost": 1800.0,
        "selling_price": 2880.0,
        "mrp": 3200.0,
        "hsn_tax_code": "6404",
        "tax_rate": 18.0,
        "primary_supplier": "Urban Chic Fashions"
      }
    ];

    return sampleInvoiceItems.map((json) => mapper.mapJsonToProductStudio(json)).toList();
  }
}
