import '../../models/product.dart';

abstract class MarketplaceMapper {
  Map<String, dynamic> mapToExternal(Product product);
  Product mapFromExternal(Map<String, dynamic> externalData);
}

class AmazonMapper implements MarketplaceMapper {
  @override
  Map<String, dynamic> mapToExternal(Product product) {
    return {
      'sku': product.sku.value,
      'title': product.industry.marketingTitle ?? product.name,
      'standard_price': product.basePrice,
      'quantity': product.openingStock,
      'external_product_id': product.barcode?.value,
      'external_product_id_type': 'EAN',
    };
  }

  @override
  Product mapFromExternal(Map<String, dynamic> externalData) {
    // Logic to create Product from Amazon feed
    throw UnimplementedError();
  }
}

class MyntraMapper implements MarketplaceMapper {
  @override
  Map<String, dynamic> mapToExternal(Product product) {
    return {
      'vendor_sku': product.sku.value,
      'product_name': product.name,
      'mrp': product.mrp,
      'selling_price': product.basePrice,
      'inventory': product.openingStock,
    };
  }

  @override
  Product mapFromExternal(Map<String, dynamic> externalData) => throw UnimplementedError();
}

class AjioMapper implements MarketplaceMapper {
  @override
  Map<String, dynamic> mapToExternal(Product product) {
    return {
      'ajio_sku': product.sku.value,
      'display_name': product.name,
      'price': product.basePrice,
      'stock_qty': product.openingStock,
    };
  }

  @override
  Product mapFromExternal(Map<String, dynamic> externalData) => throw UnimplementedError();
}
