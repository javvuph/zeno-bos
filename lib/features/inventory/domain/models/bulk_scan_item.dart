import 'product_studio_data.dart';
import 'product_studio_enums.dart';

class BulkScanItem {
  final ProductStudioData product;
  BulkScanStatus status;
  bool isSelected;
  String? errorMessage;

  BulkScanItem({
    required this.product,
    this.status = BulkScanStatus.review,
    this.isSelected = false,
    this.errorMessage,
  });
}
