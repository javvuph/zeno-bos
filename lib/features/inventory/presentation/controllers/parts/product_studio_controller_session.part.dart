part of '../product_studio_controller.dart';

extension ProductStudioControllerSession on ProductStudioController {
  void clearScanSession() { scanSession.clear(); notify(); }
  
  void handleBarcodeScanned(String barcode) async {
    isScanning = true; notify();
    final existing = await repository.getProductByBarcode(barcode);
    if (existing != null) { scanSession.insert(0, ScanSessionItem(product: ProductStudioFromDomain.fromDomain(existing), status: ScanItemStatus.exists)); }
    else { scanSession.insert(0, ScanSessionItem(product: ProductStudioData.empty()..barcode = barcode, status: ScanItemStatus.notFound)); }
    isScanning = false; notify();
  }

  void addScannedProductToCatalog() async { await saveProduct(); if (scanSession.isNotEmpty) scanSession.first.status = ScanItemStatus.added; resetProduct(); }

  void pickImportFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) { isImporting = true; notify(); await Future.delayed(const Duration(seconds: 1)); isImporting = false; notify(); }
  }
  
  void addManualImportRow() { importItems.insert(0, BulkScanItem(product: ProductStudioData.empty(), status: BulkScanStatus.review)); notify(); }
  void addImportReadyToCatalog() async {
    setSaving(true);
    try {
      for (var item in importItems) {
        if (item.status == BulkScanStatus.ready) {
          await repository.saveProduct(item.product.toDomain());
        }
      }
      final listController = ProductController.lastInstance;
      if (listController != null) {
        await listController.refreshProducts();
      }
      final context = navigationContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product saved successfully")),
        );
      }
      notify();
    } catch (e) {
      final context = navigationContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save product: $e")),
        );
      }
      rethrow;
    } finally {
      setSaving(false);
    }
  }
  void updateImportItemField(int i, Function(ProductStudioData) f) {
    if (i < importItems.length) {
      f(importItems[i].product);
      notify();
    }
  }
  void toggleImportSelectAll(bool v) {
    for (var item in importItems) {
      item.isSelected = v;
    }
    notify();
  }
  void toggleImportSelectItem(int i, bool v) {
    if (i < importItems.length) {
      importItems[i].isSelected = v;
      notify();
    }
  }
  void deleteSelectedImportItems() { importItems.removeWhere((item) => item.isSelected); notify(); }

  void handleBulkBarcodeScanned(String b) async {
    final existing = await repository.getProductByBarcode(b);
    if (existing != null) {
      bulkScanItems.add(BulkScanItem(product: ProductStudioFromDomain.fromDomain(existing), status: BulkScanStatus.duplicate));
    } else {
      bulkScanItems.add(BulkScanItem(product: ProductStudioData.empty()..barcode = b, status: BulkScanStatus.ready));
    }
    notify();
  }
  bool isBulkRowComplete(ProductStudioData product) {
    final requiredFields = <String, bool>{
      'title': product.title.trim().isNotEmpty,
      'costPrice': product.costPrice > 0,
      'sellingPrice': product.sellingPrice > 0,
      'openingStock': product.openingStock > 0,
    };
    return requiredFields.values.every((isValid) => isValid);
  }

  List<String> getBulkRowErrors(ProductStudioData product) {
    final errors = <String>[];
    if (product.title.trim().isEmpty) errors.add('Item Name');
    if (product.costPrice <= 0) errors.add('Purchase Price');
    if (product.sellingPrice <= 0) errors.add('Selling Price');
    if (product.openingStock <= 0) errors.add('Quantity');
    return errors;
  }

  void addBulkReadyToCatalog() async {
    final invalidRows = bulkScanItems
        .where((item) => item.status == BulkScanStatus.ready || item.status == BulkScanStatus.review)
        .where((item) => !isBulkRowComplete(item.product))
        .toList();

    if (invalidRows.isNotEmpty) {
      final context = navigationContext;
      final missing = invalidRows.first;
      final errors = getBulkRowErrors(missing.product).join(', ');
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Missing required fields: $errors')),
        );
      }
      return;
    }

    setSaving(true);
    try {
      for (var item in bulkScanItems) {
        if (item.status == BulkScanStatus.ready || item.status == BulkScanStatus.review) {
          if (isBulkRowComplete(item.product)) {
            await repository.saveProduct(item.product.toDomain());
          }
        }
      }
      final listController = ProductController.lastInstance;
      if (listController != null) {
        await listController.refreshProducts();
      }
      final context = navigationContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product saved successfully")),
        );
      }
      notify();
    } catch (e) {
      final context = navigationContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save product: $e")),
        );
      }
      rethrow;
    } finally {
      setSaving(false);
    }
  }
  void updateBulkItemField(int i, Function(ProductStudioData) f) {
    if (i < bulkScanItems.length) {
      f(bulkScanItems[i].product);
      notify();
    }
  }
  void toggleBulkSelectAll(bool v) {
    for (var item in bulkScanItems) {
      item.isSelected = v;
    }
    notify();
  }
  void toggleBulkSelectItem(int i, bool v) {
    if (i < bulkScanItems.length) {
      bulkScanItems[i].isSelected = v;
      notify();
    }
  }
  void deleteSelectedBulkItems() { bulkScanItems.removeWhere((item) => item.isSelected); notify(); }
}
