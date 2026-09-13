import 'product_studio_data.dart';
import 'product_studio_enums.dart';

class ScanSessionItem {
  final ProductStudioData product;
  ScanItemStatus status;

  ScanSessionItem({required this.product, required this.status});
}
