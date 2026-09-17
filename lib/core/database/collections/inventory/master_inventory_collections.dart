part of '../inventory_collections.dart';

@collection
class CategoryCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  String? parentId;
  bool isDeleted = false;
}

@collection
class BrandCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  bool isDeleted = false;
}

@collection
class WarehouseCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  @Index(unique: true)
  late String code;

  late String address;
  bool isMain = false;
  bool isDeleted = false;
}

@collection
class StockItemCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String productId;

  @Index()
  late String warehouseId;

  late double quantity;
  late double reservedQuantity;

  DateTime lastUpdated = DateTime.now();
}
