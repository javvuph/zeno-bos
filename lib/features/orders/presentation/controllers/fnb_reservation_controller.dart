import 'package:flutter/material.dart';
import '../../domain/repositories/i_fnb_repository.dart';
import '../../../../core/database/collections/fnb_reservation_collection.dart';

class FnbReservationController extends ChangeNotifier {
  final IFnbRepository _repository;

  FnbReservationController(this._repository);

  List<FnbReservationCollection> reservations = [];
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();

  Future<void> loadReservations(DateTime date) async {
    selectedDate = date;
    isLoading = true;
    notifyListeners();
    reservations = await _repository.getReservations(date);
    isLoading = false;
    notifyListeners();
  }

  Future<void> createReservation(FnbReservationCollection reservation) async {
    await _repository.saveReservation(reservation);
    await loadReservations(selectedDate);
  }

  Future<void> confirmReservation(String uuid) async {
    await _repository.updateReservationStatus(uuid, 'confirmed');
    await loadReservations(selectedDate);
  }

  Future<void> cancelReservation(String uuid) async {
    await _repository.updateReservationStatus(uuid, 'cancelled');
    await loadReservations(selectedDate);
  }
}
