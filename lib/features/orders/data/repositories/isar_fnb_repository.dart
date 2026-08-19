import 'package:isar/isar.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/fnb_collections.dart';
import 'package:zeno/core/database/collections/fnb_reservation_collection.dart';
import '../../domain/repositories/i_fnb_repository.dart';

class IsarFnbRepository implements IFnbRepository {
  final DatabaseService db;
  IsarFnbRepository(this.db);

  @override
  Future<List<RestaurantFloorCollection>> getFloors() => 
    db.isar.collection<RestaurantFloorCollection>().where().findAll();

  @override
  Future<List<RestaurantTableCollection>> getTables(String floorId) async {
    final all = await db.isar.collection<RestaurantTableCollection>().where().findAll();
    return all.where((t) => t.floorId == floorId).toList();
  }

  @override
  Future<void> updateTableStatus(String tableId, String status, {String? orderId, int? guestCount}) async {
    final all = await db.isar.collection<RestaurantTableCollection>().where().findAll();
    final table = all.firstWhere((t) => t.uuid == tableId); // simplified
    await db.isar.writeTxn(() async {
      table.status = status;
      if (orderId != null) table.activeOrderId = orderId;
      if (guestCount != null) table.currentGuestCount = guestCount;
      await db.isar.collection<RestaurantTableCollection>().put(table);
    });
  }

  @override
  Future<void> saveKot(KotCollection kot) async {
    await db.isar.writeTxn(() async => await db.isar.collection<KotCollection>().put(kot));
  }

  @override
  Future<List<KotCollection>> getPendingKots(String station) async {
    final all = await db.isar.collection<KotCollection>().where().findAll();
    return all.where((k) => k.station == station && k.status == 'new').toList();
  }

  @override
  Future<void> updateKotStatus(String kotId, String status) async {
    final all = await db.isar.collection<KotCollection>().where().findAll();
    final kot = all.firstWhere((k) => k.uuid == kotId);
    await db.isar.writeTxn(() async {
      kot.status = status;
      await db.isar.collection<KotCollection>().put(kot);
    });
  }

  @override
  Future<void> saveReservation(FnbReservationCollection reservation) async {
    await db.isar.writeTxn(() async => await db.isar.collection<FnbReservationCollection>().put(reservation));
  }

  @override
  Future<List<FnbReservationCollection>> getReservations(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    final all = await db.isar.collection<FnbReservationCollection>().where().findAll();
    return all.where((r) => r.reservationDate.isAfter(startOfDay.subtract(const Duration(milliseconds: 1))) && r.reservationDate.isBefore(endOfDay)).toList();
  }

  @override
  Future<void> updateReservationStatus(String reservationId, String status) async {
    final all = await db.isar.collection<FnbReservationCollection>().where().findAll();
    final res = all.firstWhere((r) => r.uuid == reservationId);
    await db.isar.writeTxn(() async {
      res.status = status;
      await db.isar.collection<FnbReservationCollection>().put(res);
    });
  }

  @override
  Stream<List<RestaurantTableCollection>> watchTables(String floorId) =>
    db.isar.collection<RestaurantTableCollection>().where().watch(fireImmediately: true).map((list) => list.where((t) => t.floorId == floorId).toList());
}
