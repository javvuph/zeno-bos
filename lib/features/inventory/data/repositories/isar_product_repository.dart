import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/inventory_collections.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../../domain/models/product.dart';
import 'mappers/product_mapper.dart';

class IsarProductRepository implements IProductRepository {
  final DatabaseService db;
  IsarProductRepository(this.db);

  IsarCollection<ProductCollection> get collection =>
      db.isar.collection<ProductCollection>();

  @override
  Future<Product?> getProductById(String id) async {
    final pc = await collection.filter().uuidEqualTo(id).findFirst();
    if (pc == null) return null;
    return ProductMapper.mapToDomain(pc);
  }

  @override
  Future<Product?> getProductByBarcode(String barcode) async {
    final pc = await collection.filter().barcodeEqualTo(barcode).findFirst();
    if (pc == null) return null;
    return ProductMapper.mapToDomain(pc);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final list = await collection.filter().isDeletedEqualTo(false).findAll();
    return list.map((pc) => ProductMapper.mapToDomain(pc)).toList();
  }

  @override
  Future<void> saveProduct(Product product) async {
    final existing =
        await collection.filter().uuidEqualTo(product.id).findFirst();

    final pc = ProductMapper.mapToCollection(product, existing: existing);

    if (existing == null) {
      pc.createdAt = product.createdAt;
    }

    await db.isar.writeTxn(() async {
      await collection.put(pc);
    });
  }

  @override
  Future<void> deleteProduct(String id) async {
    await db.isar.writeTxn(() async {
      final pc = await collection.filter().uuidEqualTo(id).findFirst();
      if (pc != null) {
        pc.isDeleted = true;
        pc.updatedAt = DateTime.now();
        await collection.put(pc);
      }
    });
  }

  @override
  Future<void> restoreProduct(String id) async {
    await db.isar.writeTxn(() async {
      final pc = await collection.filter().uuidEqualTo(id).findFirst();
      if (pc != null) {
        pc.isDeleted = false;
        pc.updatedAt = DateTime.now();
        await collection.put(pc);
      }
    });
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    // 1. Exact SKU/Barcode Match (Highest Speed)
    final exact = await collection
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .group((q) => q.skuEqualTo(query).or().barcodeEqualTo(query))
        .findFirst();

    if (exact != null) return [ProductMapper.mapToDomain(exact)];

    // 2. Fuzzy Search
    final list = await collection
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .group((q) => q
            .nameContains(query, caseSensitive: false)
            .or()
            .skuContains(query, caseSensitive: false))
        .findAll();
    return list.map((pc) => ProductMapper.mapToDomain(pc)).toList();
  }
}
