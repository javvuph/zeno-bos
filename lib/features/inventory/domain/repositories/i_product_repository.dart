import '../models/product.dart';

abstract class IProductRepository {
  Future<Product?> getProductById(String id);
  Future<Product?> getProductByBarcode(String barcode);
  Future<List<Product>> getAllProducts();
  Future<void> saveProduct(Product product);
  Future<void> deleteProduct(String id);
  Future<void> restoreProduct(String id);
  Future<List<Product>> searchProducts(String query);
}
