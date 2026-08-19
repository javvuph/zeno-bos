import '../../../controllers/product_studio_controller.dart';

class ImportColumnConfig {
  final String fieldId;
  final String label;
  final double width;
  final bool isRequired;

  const ImportColumnConfig({
    required this.fieldId,
    required this.label,
    this.width = 120,
    this.isRequired = false,
  });
}

List<ImportColumnConfig> getDynamicImportColumns(ProductStudioController controller) {
  final fields = controller.getOrderedFields();
  
  return fields.map((f) {
    double width = 120;
    if (f == 'title') width = 200;
    if (f == 'description') width = 150;
    if (f.contains('Price') || f == 'mrp' || f == 'costPrice') width = 90;
    if (f.contains('Stock') || f == 'openingStock') width = 80;

    return ImportColumnConfig(
      fieldId: f,
      label: controller.getFieldLabel(f),
      width: width,
      isRequired: f == 'title' || f == 'sku',
    );
  }).toList();
}
