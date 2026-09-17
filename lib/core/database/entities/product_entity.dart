import 'package:isar/isar.dart';

part 'product_entity.g.dart';

@collection
class ProductEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String sku;

  late String name;

  late double basePrice;

  /// Schema-driven attributes.
  /// Example: {'category': 'Electronics', 'brand': 'Sony'}
  @ignore
  late Map<String, String> attributes;

  /// The industry module this product belongs to (optional, for filtering)
  late String industryId;

  late DateTime lastModified;

  /// Whether this product is synced to the cloud
  @Index()
  late bool isSynced;
}
