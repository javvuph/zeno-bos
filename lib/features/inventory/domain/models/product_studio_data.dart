import 'product_studio_enums.dart';
import 'product_enums.dart';
import 'batch.dart';
import 'recipe_ingredient.dart';
import 'media_asset.dart';
import 'market_pricing.dart';
import 'variant_matrix_item.dart';
import 'supplier_relationship.dart';
import 'combo_item.dart';

part 'parts/product_studio_data_commerce.part.dart';
part 'parts/product_studio_data_fields_1.part.dart';
part 'parts/product_studio_data_industry.part.dart';
part 'parts/product_studio_data_traceability.part.dart';

class ProductStudioData with _ProductStudioCommerceFields, _ProductStudioIndustryFields, _ProductStudioDataTraceability {
  String id = "";
  String title = "";
  String arabicTitle = "";
  String sku = "";
  String barcode = "";
  String barcodeType = "EAN-13";
  List<String> multiBarcodes = [];
  String category = "";
  String subcategory = "";
  String brand = "";
  String subBrand = "";
  String manufacturer = "";
  String sectorId = "";
  String departmentId = "";
  String subDepartmentId = "";
  String brandType = "";
  String productType = "";
  String segment = "";
  String status = "Active";
  String productLifecycleStatus = "Draft";
  String visibility = "Public";
  String countryOfOrigin = "";
  String manufacturerPartNumber = "";
  String vendorSku = "";
  String internalBarcode = "";
  DateTime? launchDate;
  DateTime? discontinueDate;
  String parentSku = "";
  String description = "";
  String shortDescription = "";
  String marketingTitle = "";
  String seoTitle = "";
  String metaDescription = "";
  String urlSlug = "";
  String tags = "";
  String targetAudience = "";
  bool featuredProduct = false;
  bool appVisibility = false;
  bool b2bVisibility = false;
  bool priceFloorLock = false;
  double promotionalPrice = 0.0;
  ProductLifecycleState lifecycleState = ProductLifecycleState.draft;
  ItemType itemType = ItemType.stockProduct;
  String gstTaxMode = "Intra-State";
  String primaryImageUrl = "";
  List<String> galleryUrls = [];

  String businessType = "Retail";
  String businessCategory = "Supermarket";
  BusinessScale? businessScale;

  List<Batch> batches = [];
  List<String> modifierGroups = [];
  Map<String, List<MediaAsset>> colorMediaLibrary = {};

  // Legacy Aliases
  String get productName => title;
  set productName(String v) => title = v;
  String get masterSku => sku;
  set masterSku(String v) => sku = v;
  String get primaryBarcode => barcode;
  set primaryBarcode(String v) => barcode = v;
  String get categoryId => category;
  set categoryId(String v) => category = v;
  String get subCategoryId => subcategory;
  set subCategoryId(String v) => subcategory = v;
  String get brandId => brand;
  set brandId(String v) => brand = v;
  String get department => departmentId;
  set department(String v) => departmentId = v;
  String get subDepartment => subDepartmentId;
  set subDepartment(String v) => subDepartmentId = v;

  ProductStudioData({required this.id});

  factory ProductStudioData.empty() {
    final now = DateTime.now();
    return ProductStudioData(
      id: "PRD-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.microsecondsSinceEpoch}",
    );
  }
  
  ProductStudioData copyWith({String? id}) => ProductStudioData(id: id ?? this.id);
}
