abstract class IAggregatorAdapter {
  String get providerName;
  
  Future<void> syncMenu(dynamic catalog);
  Future<void> updateItemAvailability(String sku, bool isAvailable);
  Future<void> updatePrice(String sku, double price);
  
  Future<void> acceptOrder(String externalId);
  Future<void> updateOrderStatus(String externalId, String status);
}

class SwiggyAdapter implements IAggregatorAdapter {
  @override String get providerName => "Swiggy";
  
  @override Future<void> syncMenu(dynamic catalog) async {
    // POST /vendor/v1/menu/sync
  }

  @override Future<void> updateItemAvailability(String sku, bool isAvailable) async {
    // PATCH /vendor/v1/item/{sku}/status
  }

  @override Future<void> updatePrice(String sku, double price) async {
    // PUT /vendor/v1/item/{sku}/price
  }

  @override Future<void> acceptOrder(String externalId) async {
    // POST /vendor/v1/order/{externalId}/accept
  }

  @override Future<void> updateOrderStatus(String externalId, String status) async {
    // POST /vendor/v1/order/{externalId}/status
  }
}

class ZomatoAdapter implements IAggregatorAdapter {
  @override String get providerName => "Zomato";
  @override Future<void> syncMenu(dynamic catalog) async {}
  @override Future<void> updateItemAvailability(String sku, bool isAvailable) async {}
  @override Future<void> updatePrice(String sku, double price) async {}
  @override Future<void> acceptOrder(String externalId) async {}
  @override Future<void> updateOrderStatus(String externalId, String status) async {}
}

class TalabatAdapter implements IAggregatorAdapter {
  @override String get providerName => "Talabat";
  @override Future<void> syncMenu(dynamic catalog) async {}
  @override Future<void> updateItemAvailability(String sku, bool isAvailable) async {}
  @override Future<void> updatePrice(String sku, double price) async {}
  @override Future<void> acceptOrder(String externalId) async {}
  @override Future<void> updateOrderStatus(String externalId, String status) async {}
}
