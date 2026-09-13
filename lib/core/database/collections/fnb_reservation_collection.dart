import 'package:isar/isar.dart';

part 'fnb_reservation_collection.g.dart';

@collection
class FnbReservationCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String customerName;
  
  @Index()
  late String phone;

  @Index()
  late DateTime reservationDate;
  
  late DateTime startTime;
  late DateTime endTime;
  
  late int guestCount;
  
  String? tableId;
  String? section;

  @Index()
  late String status; // pending, confirmed, seated, completed, cancelled, no_show

  double? depositAmount;
  late String depositStatus; // unpaid, paid, refunded, forfeited

  String? notes;
  late String createdBy;
  late DateTime createdAt;
}
