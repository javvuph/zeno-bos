import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/inventory/data/services/ai_product_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../../domain/models/product_studio_models.dart';
import '../../domain/services/product_business_logic.dart';
import '../../domain/services/master_data_service.dart';
import '../../domain/models/batch.dart' as model;
import '../../domain/models/supplier_relationship.dart';
import '../../domain/models/recipe_ingredient.dart';
import '../../domain/services/replenishment_service.dart';
import '../../domain/services/fashion_analytics_service.dart';
import '../../domain/services/markdown_approval_service.dart';
import '../../domain/models/mappers/product_studio_mapper.dart';
import 'product_controller.dart';
import 'registries/sub_business_registry.dart' as sub;
import 'registries/capability_registry.dart' as cap;
import 'registries/capability_fashion.dart';
import 'registries/aurora_tab_registry.dart';
import 'registries/field_visibility_registry.dart' as field;

part 'parts/product_studio_controller_logic.part.dart';
part 'parts/product_studio_controller_logic_persistence.part.dart';
part 'parts/product_studio_controller_logic_fields.part.dart';
part 'parts/product_studio_controller_variants.part.dart';
part 'parts/product_studio_controller_variants_ai.part.dart';
part 'parts/product_studio_controller_session.part.dart';
part 'parts/product_studio_controller_update.part.dart';
part 'parts/product_studio_controller_update_core.part.dart';
part 'parts/product_studio_controller_update_industry.part.dart';
part 'parts/product_studio_controller_update_specialized.part.dart';
part 'parts/product_studio_controller_update_traceability.part.dart';
part 'parts/product_studio_controller_dynamic_update.part.dart';

class ProductStudioController extends ChangeNotifier {
  static final ProductStudioController _instance = ProductStudioController._internal();
  factory ProductStudioController() => _instance;
  ProductStudioController._internal() { 
    _initMD();
    _loadBusinessConfig();
  }

  List<String> get enabledProductTypes {
    final setup = StoreSetupController();
    if (setup.stores.isNotEmpty) {
      return setup.stores.first.enabledSubTypes;
    }
    return [activeProfile];
  }

  void _loadBusinessConfig() {
    final setup = StoreSetupController();
    if (setup.stores.isNotEmpty) {
      final store = setup.stores.first;
      _product.businessType = store.industry;
      _product.businessCategory = store.subType;
      _product.businessScale = BusinessScale.values.firstWhere(
        (e) => e.toString().split('.').last.toUpperCase() == store.businessSize.toUpperCase(),
        orElse: () => BusinessScale.small,
      );
      
      // Auto-activate Variant capability for Fashion profile
      if (_product.businessType.toUpperCase() == "FASHION") {
        _product.capVariant = true;
      }
    }
  }

  final ProductBusinessLogic logic = ProductBusinessLogic();
  final MasterDataService md = MasterDataService();
  final IProductRepository repository = sl<IProductRepository>();
  final FashionAnalyticsService analytics = FashionAnalyticsService(sl<DatabaseService>().isar);
  final MarkdownApprovalService markdownApproval = MarkdownApprovalService(sl<DatabaseService>().isar);
  final ReplenishmentService replenishment = ReplenishmentService();

  Map<String, List<String>> get businessCategoryMap => sub.businessCategoryMap;

  ProductStudioData _product = ProductStudioData.empty();
  ProductStudioData get product => _product;

  // Guards concurrent image picker invocations: desktop file dialogs can only
  // have one instance open, so rapid/duplicate taps must be ignored rather than
  // queued — otherwise the second call silently fails and looks like a dead button.
  bool _isPickingImage = false;

  // --- Profile & Scoping [Enterprise V3.5] ---
  String get activeBusiness => _product.businessType;
  String get activeProfile => _product.businessCategory;
  
  void setProfile(String business, String profile) {
    _product.businessType = business;
    _product.businessCategory = profile;
    
    // Ensure Variant capability is active for Fashion products
    if (business.toUpperCase() == "FASHION") {
      _product.capVariant = true;
    }
    
    notify();
  }

  ProductCreationMode _mode = ProductCreationMode.manual;
  ProductCreationMode get currentMode => _mode;

  ProductStudioSection _activeSection = ProductStudioSection.basic;
  ProductStudioSection get activeSection => _activeSection;

  AuroraStudioTab _activeTab = AuroraStudioTab.identity;
  AuroraStudioTab get activeTab => _activeTab;

  bool isAdvancedMode = false;
  bool isSaving = false;
  bool isFullscreen = false;
  BuildContext? navigationContext;
  bool hasManualSkuOverride = false;

  final List<String> departmentsList = [], categoriesList = [], brandsList = [], unitsList = [], locationsList = [], subcategoriesList = [], suppliersList = [];
  final List<String> taxCategoriesList = ["Standard", "Zero Rated", "Exempt"], jurisdictionsList = ["Default", "India"];

  final List<ScanSessionItem> scanSession = [];
  final List<BulkScanItem> bulkScanItems = [], importItems = [];
  bool isScanning = false, isBulkScanning = false, isImporting = false;

  final List<String> availableColors = ["Black", "Navy", "White", "Red", "Blue", "Grey"];
  final Map<String, Color> customColorMap = {};
  final List<String> selectedColors = [], selectedSizes = [];
  bool isColorManageMode = false;
  VariantSizeType sizeType = VariantSizeType.alpha;
  int? activeVariantIndex;
  String? _activeMediaColor;
  String? get activeMediaColor => _activeMediaColor;
  bool get isClothingSmallProfile {
    return activeProfile.toLowerCase() == "clothing" &&
        _product.businessType.toUpperCase() == "FASHION" &&
        _product.businessScale == BusinessScale.small;
  }
  
  bool get enableBatchTracking => _product.enableBatchTracking;
  bool get enableSerialTracking => false;
  bool get enableIMEITracking => false;
  String get businessCountry => "IN"; // Default region
  String get currentCountryCode => businessCountry;

  void notify() => notifyListeners();

  void toggleTracking(String type, bool value) {
    if (type == "batch") _product.enableBatchTracking = value;
    notify();
  }

  void addSupplierRelationship(String name) {
    bool exists = false;
    for (var r in _product.supplierRelationships) {
      if (r.supplierName == name) {
        exists = true;
        break;
      }
    }
    if (!exists) {
      _product.supplierRelationships.add(SupplierRelationship(id: "SR-${DateTime.now().millisecond}", supplierName: name, isPrimary: _product.supplierRelationships.isEmpty));
      notify();
    }
  }

  void removeSupplierRelationship(int index) {
    if (index >= 0 && index < _product.supplierRelationships.length) {
      _product.supplierRelationships.removeAt(index);
      notify();
    }
  }

  void setPrimarySupplier(int index) {
    for (int i = 0; i < _product.supplierRelationships.length; i++) {
      _product.supplierRelationships[i] = _product.supplierRelationships[i].copyWith(isPrimary: i == index);
    }
    notify();
  }
}
