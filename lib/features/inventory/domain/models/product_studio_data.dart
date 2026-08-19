import 'product_studio_enums.dart';
import 'product_enums.dart';
import 'batch.dart';
import 'recipe_ingredient.dart';
import 'media_asset.dart';
import 'market_pricing.dart';
import 'variant_matrix_item.dart';
import 'supplier_relationship.dart';

part 'parts/product_studio_data_core.part.dart';
part 'parts/product_studio_data_enterprise.part.dart';
part 'parts/product_studio_data_industry.part.dart';
part 'parts/product_studio_data_specialized.part.dart';
part 'parts/product_studio_data_traceability.part.dart';

/// Enterprise Product Master Workstation Architecture (V3.5)
/// Lossless Modular Data Model supporting 41 Industry Profiles.
class ProductStudioData with 
    ProductStudioDataCore, 
    ProductStudioDataEnterprise, 
    ProductStudioDataIndustry,
    ProductStudioDataSpecialized,
    ProductStudioDataTraceability {

  ProductStudioData({required String id}) {
    this.id = id;
  }

  factory ProductStudioData.empty() => ProductStudioData(
      id: "PRD-${DateTime.now().year}-${1000 + (DateTime.now().millisecond % 9000)}");
}
