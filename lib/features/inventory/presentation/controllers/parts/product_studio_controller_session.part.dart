part of '../product_studio_controller.dart';

extension ProductStudioControllerSession on ProductStudioController {
  void clearScanSession() { scanSession.clear(); notify(); }
  
  Future<void> handleBarcodeScanned(String barcode) async {
    await handleBulkBarcodeScanned(barcode);
  }

  Future<void> addScannedProductToCatalog() async {
    await addBulkReadyToCatalog();
  }

  Future<void> pickImportFile() async {
    if (isImporting) return;
    isImporting = true;
    notify();
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'txt', 'json'],
      );
      if (result.files.isEmpty || result.files.first.path == null) return;
      final file = File(result.files.first.path!);
      final ext = result.files.first.extension?.toLowerCase() ?? '';
      final service = IngestionService(aiService: sl<AIProductService>());

      if (ext == 'json') {
        final decoded = jsonDecode(await file.readAsString());
        final rows = decoded is List
            ? decoded
            : decoded is Map<String, dynamic> && decoded['products'] is List
                ? decoded['products']
                : const [];
        for (final row in rows) {
          if (row is Map) {
            final product = service.mapper.mapJsonToProductStudio(
              Map<String, dynamic>.from(row),
            );
            bulkScanItems.add(BulkScanItem(
              product: product,
              status: isBulkRowComplete(product)
                  ? BulkScanStatus.ready
                  : BulkScanStatus.review,
            ));
          }
        }
      } else {
        final mapping = await service.processCSV(await file.readAsString(), null);
        for (final row in mapping.rows) {
          bulkScanItems.add(BulkScanItem(
            product: row.product,
            status: isBulkRowComplete(row.product)
                ? BulkScanStatus.ready
                : BulkScanStatus.review,
          ));
        }
      }
      _reconcileBulkDuplicateStatus();
      notify();
    } catch (e) {
      final context = navigationContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed: $e')),
        );
      }
    } finally {
      isImporting = false;
      notify();
    }
  }
  
  void addManualImportRow() { bulkScanItems.insert(0, BulkScanItem(product: ProductStudioData.empty(), status: BulkScanStatus.review)); notify(); }
  Future<void> addImportReadyToCatalog() async {
    await addBulkReadyToCatalog();
    return;
    /*
    setSaving(true);
    try {
      for (var item in importItems) {
        if (item.status == BulkScanStatus.ready) {
          await repository.saveProduct(item.product.toDomain());
        }
      }
      final listController = sl<ProductController>();
      await listController.refreshProducts();
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
    */
  }
  void updateImportItemField(int i, Function(ProductStudioData) f) => updateBulkItemField(i, f);
  void toggleImportSelectAll(bool v) => toggleBulkSelectAll(v);
  void toggleImportSelectItem(int i, bool v) => toggleBulkSelectItem(i, v);
  void deleteSelectedImportItems() => deleteSelectedBulkItems();

  String _bulkDuplicateKey(ProductStudioData product) {
    final normalizedBarcode = product.barcode.trim();
    final normalizedSku = product.sku.trim();
    final normalizedTitle = product.title.trim();
    final normalizedBrand = product.brand.trim();
    final normalizedCategory = product.category.trim();

    if (normalizedBarcode.isNotEmpty) return normalizedBarcode.toLowerCase();
    if (normalizedSku.isNotEmpty) return normalizedSku.toLowerCase();
    if (normalizedTitle.isNotEmpty && normalizedBrand.isNotEmpty && normalizedCategory.isNotEmpty) {
      return '${normalizedTitle.toLowerCase()}|${normalizedBrand.toLowerCase()}|${normalizedCategory.toLowerCase()}';
    }
    if (normalizedTitle.isNotEmpty) return normalizedTitle.toLowerCase();
    return '';
  }

  void _reconcileBulkDuplicateStatus() {
    final seen = <String, int>{};

    for (int i = 0; i < bulkScanItems.length; i++) {
      final key = _bulkDuplicateKey(bulkScanItems[i].product);
      if (key.isEmpty) continue;

      final previousIndex = seen[key];
      if (previousIndex != null) {
        bulkScanItems[previousIndex].status = BulkScanStatus.duplicate;
        bulkScanItems[previousIndex].errorMessage = 'Duplicate item detected';
        bulkScanItems[i].status = BulkScanStatus.duplicate;
        bulkScanItems[i].errorMessage = 'Duplicate item detected';
      } else {
        seen[key] = i;
        if (bulkScanItems[i].status == BulkScanStatus.duplicate) {
          bulkScanItems[i].status = BulkScanStatus.ready;
          bulkScanItems[i].errorMessage = null;
        }
      }
    }
  }

  void handleBulkBarcodeScanned(String b) async {
    final existing = await repository.getProductByBarcode(b);
    if (existing != null) {
      bulkScanItems.add(BulkScanItem(product: ProductStudioFromDomain.fromDomain(existing), status: BulkScanStatus.duplicate));
    } else {
      bulkScanItems.add(BulkScanItem(product: ProductStudioData.empty()..barcode = b, status: BulkScanStatus.ready));
    }
    _reconcileBulkDuplicateStatus();
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
      final listController = sl<ProductController>();
      await listController.refreshProducts();
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
      _reconcileBulkDuplicateStatus();
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
  void deleteSelectedBulkItems() {
    bulkScanItems.removeWhere((item) => item.isSelected);
    notify();
  }

  Future<void> saveBulkAsDraft() async {
    if (bulkScanItems.isEmpty) return;
    setSaving(true);
    try {
      for (final item in bulkScanItems) {
        item.product.lifecycleState = ProductLifecycleState.draft;
        await repository.saveProduct(item.product.toDomain());
      }
      await sl<ProductController>().refreshProducts();
      final context = navigationContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Draft saved successfully')),
        );
      }
    } catch (e) {
      final context = navigationContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save draft: $e')),
        );
      }
    } finally {
      setSaving(false);
      notify();
    }
  }

  Future<void> bulkEditSelected({
    double? costPrice,
    double? sellingPrice,
    double? reorderLevel,
  }) async {
    for (final item in bulkScanItems.where((item) => item.isSelected)) {
      if (costPrice != null) item.product.costPrice = costPrice;
      if (sellingPrice != null) item.product.sellingPrice = sellingPrice;
      if (reorderLevel != null) item.product.reorderLevel = reorderLevel;
    }
    _reconcileBulkDuplicateStatus();
    notify();
  }
}
