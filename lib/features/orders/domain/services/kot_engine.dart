import 'package:isar/isar.dart';
import '../../../../core/database/collections/fnb_collections.dart';
import '../../../../core/database/collections/inventory_collections.dart';
import '../repositories/i_fnb_repository.dart';

class KotEngine {
  final IFnbRepository _repository;
  final Isar _isar;

  KotEngine(this._repository, this._isar);

  Future<void> generateKotsFromOrder(String orderId, List<KotItemEmbedded> allItems, {String? tableId}) async {
    final Map<String, List<KotItemEmbedded>> stationGroups = {};
    final allProducts = await _isar.collection<ProductCollection>().where().findAll();

    for (var item in allItems) {
      final product = allProducts.firstWhere((p) => p.uuid == item.productId);
      final station = product.kotStation ?? "Main Kitchen";
      
      stationGroups.putIfAbsent(station, () => []).add(item);
    }

    for (var entry in stationGroups.entries) {
      final kot = KotCollection()
        ..uuid = 'KOT-${DateTime.now().millisecondsSinceEpoch}-${entry.key.hashCode}'
        ..orderId = orderId
        ..tableId = tableId
        ..orderType = tableId != null ? 'dineIn' : 'takeaway'
        ..station = entry.key
        ..status = 'new'
        ..items = entry.value
        ..createdAt = DateTime.now()
        ..priority = 0;

      await _repository.saveKot(kot);
    }
  }
}
