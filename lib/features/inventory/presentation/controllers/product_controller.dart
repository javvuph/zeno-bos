import 'package:flutter/material.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../../domain/services/product_business_logic.dart';
import '../../domain/services/master_data_service.dart';

class ProductController extends ChangeNotifier {
  static ProductController? _lastInstance;
  final IProductRepository _repository;
  final ProductBusinessLogic _logic = ProductBusinessLogic();
  final MasterDataService _masterData = MasterDataService();

  ProductController(this._repository) {
    _lastInstance = this;
  }

  static ProductController? get lastInstance => _lastInstance;

  Product? _currentProduct;
  Product? get currentProduct => _currentProduct;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<Product> _allProducts = [];
  List<Product> get allProducts => _allProducts;

  // Master Data Access
  List get categories => _masterData.getCategories();
  List get brands => _masterData.getBrands();
  List get units => _masterData.getUnits();

  /// Generates a suggested SKU for the current product
  void suggestSKU() {
    if (_currentProduct == null) return;
    final newSku = _logic.generateSKU(
      _currentProduct!.category?.name ?? 'GEN',
      _currentProduct!.brand?.name ?? 'ZN',
      _currentProduct!.name,
    );
    _currentProduct = _currentProduct!.copyWith(sku: newSku);
    notifyListeners();
  }

  /// Generates a new Barcode for the current product
  void generateBarcode() {
    if (_currentProduct == null) return;
    final newBarcode = _logic.generateBarcode();
    _currentProduct = _currentProduct!.copyWith(barcode: newBarcode);
    notifyListeners();
  }

  /// Calculates the current readiness of the product
  double get readinessScore => _currentProduct != null
      ? _logic.calculateReadiness(_currentProduct!)
      : 0.0;

  /// Validates the product and returns errors
  List<String> get validationErrors =>
      _currentProduct != null ? _logic.validateProduct(_currentProduct!) : [];

  Future<void> refreshProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _allProducts = await _repository.getAllProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _allProducts = await _repository.searchProducts(query);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadProduct(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentProduct = await _repository.getProductById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await _repository.deleteProduct(id);
      await refreshProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveProduct(Product product) async {
    final errors = _logic.validateProduct(product);
    if (errors.isNotEmpty) {
      _error = errors.join("\n");
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.saveProduct(product);
      _currentProduct = product;
      await refreshProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
