import '../../models/product.dart';

enum EslSyncStatus { pending, pushing, synced, failed }

class EslSyncService {
  Future<void> pushPriceUpdate(Product product, String storeId) async {
    // 1. Add to ESL Queue
    // 2. Identify ESL Gateway for Store
    // 3. POST price change
    
    await Future.delayed(const Duration(seconds: 1)); // Mock Network Call
  }

  Stream<EslSyncStatus> monitorSync(String eslId) {
    return Stream.value(EslSyncStatus.synced);
  }
}
