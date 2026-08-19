import 'package:flutter/material.dart';
import '../../domain/repositories/i_fnb_repository.dart';
import '../../../../core/database/collections/fnb_collections.dart';

class FnbTableController extends ChangeNotifier {
  final IFnbRepository _repository;

  FnbTableController(this._repository);

  List<RestaurantTableCollection> tables = [];
  bool isLoading = false;

  void loadTables(String floorId) async {
    isLoading = true;
    notifyListeners();
    tables = await _repository.getTables(floorId);
    isLoading = false;
    notifyListeners();
  }

  Future<void> seatTable(String tableId, int guests) async {
    await _repository.updateTableStatus(tableId, 'seated', guestCount: guests);
    // Reload local list or use stream
  }

  Future<void> openTable(String tableId, String orderId) async {
    await _repository.updateTableStatus(tableId, 'ordered', orderId: orderId);
  }

  Future<void> clearTable(String tableId) async {
    await _repository.updateTableStatus(tableId, 'empty', orderId: null, guestCount: 0);
  }
}
