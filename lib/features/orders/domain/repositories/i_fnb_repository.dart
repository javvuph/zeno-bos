import '../../../../core/database/collections/fnb_collections.dart';
import '../../../../core/database/collections/fnb_reservation_collection.dart';

abstract class IFnbRepository {
  Future<List<RestaurantFloorCollection>> getFloors();
  Future<List<RestaurantTableCollection>> getTables(String floorId);
  Future<void> updateTableStatus(String tableId, String status, {String? orderId, int? guestCount});
  
  Future<void> saveKot(KotCollection kot);
  Future<List<KotCollection>> getPendingKots(String station);
  Future<void> updateKotStatus(String kotId, String status);

  Future<void> saveReservation(FnbReservationCollection reservation);
  Future<List<FnbReservationCollection>> getReservations(DateTime date);
  Future<void> updateReservationStatus(String reservationId, String status);

  Stream<List<RestaurantTableCollection>> watchTables(String floorId);
}
