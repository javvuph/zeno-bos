import 'package:isar/isar.dart';

part 'fnb_collections.g.dart';

@collection
class RestaurantFloorCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String name;

  late int sortOrder;
  bool isActive = true;
}

@collection
class RestaurantTableCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String tableNumber;

  @Index()
  late String floorId;

  late String section;
  late int capacity;
  late int currentGuestCount;

  @Index()
  late String status; // empty, reserved, seated, ordered, billed, cleaning

  String? activeOrderId;
  
  late double posX;
  late double posY;
  late String shape; // round, square, rectangle
  
  bool isMergeable = true;
}

@collection
class KotCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String orderId;

  String? tableId;
  late String orderType; // dineIn, takeaway, delivery

  late List<KotItemEmbedded> items;

  @Index()
  late String station; // kitchen, bar, tandoor, etc

  @Index()
  late String status; // new, accepted, preparing, ready, served, cancelled

  late DateTime createdAt;
  late int priority; // 0: Normal, 1: High, 2: VIP
  String? notes;
}

@embedded
class KotItemEmbedded {
  late String productId;
  late String name;
  late double quantity;
  String? modifiers;
  String? notes;
}
