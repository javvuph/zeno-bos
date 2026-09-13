import '../../controllers/product_studio_controller.dart';
import '../../../domain/models/product_studio_enums.dart';

// Small composition/visibility utilities for Aurora tabs.
// Decides whether a tab has any visible fields for the active profile.

bool hasAuroraContentForTab(ProductStudioController controller, AuroraStudioTab tab) {
  // Get all candidate fields for the tab as determined by the controller's ordered fields
  final List<String> allFields = controller.getFieldsForTab(tab);

  // Consider a field visible if controller.isFieldVisible reports true
  final visible = allFields.where((f) => controller.isFieldVisible(f)).toList();

  // If any visible fields exist, the tab should be shown
  if (visible.isNotEmpty) return true;

  // Fallback: some tabs may be meaningful even if no mapped registry fields
  // For example identity should always show (handled elsewhere), but pricing/stock/etc
  // are driven by common fields; controller.getFieldsForTab includes common fields.

  return false;
}
