part of '../product_studio_controller.dart';

extension ProductStudioControllerLogicPersistence on ProductStudioController {
  Future<void> saveProduct([BuildContext? context]) async {
    await _persistProduct(ProductLifecycleState.published, context, resetAfterSave: true);
  }

  Future<void> saveDraft([BuildContext? context]) async {
    await _persistProduct(ProductLifecycleState.draft, context);
  }

  Future<void> _persistProduct(
    ProductLifecycleState lifecycleState,
    BuildContext? context, {
    bool resetAfterSave = false,
  }) async {
    setSaving(true);
    try {
      _product.lifecycleState = lifecycleState;

      // Ensure every variant has a unique SKU and unique Barcode before committing to DB
      final seenSkus = <String>{};
      final seenBarcodes = <String>{};

      if (_product.sku.trim().isNotEmpty) {
        seenSkus.add(_product.sku.trim());
      }
      if (_product.barcode.trim().isNotEmpty) {
        seenBarcodes.add(_product.barcode.trim());
      }

      for (int i = 0; i < _product.variants.length; i++) {
        final v = _product.variants[i];

        // Unique SKU check
        String vSku = v.sku.trim();
        if (vSku.isEmpty || seenSkus.contains(vSku)) {
          final fallbackSku = _buildVariantSku(_product.sku.trim(), v.color, v.size);
          vSku = fallbackSku;
          if (seenSkus.contains(vSku)) {
            vSku = '$fallbackSku-${i + 1}';
          }
          v.sku = vSku;
        }
        seenSkus.add(vSku);

        // Unique Barcode check
        String vBc = v.barcode.trim();
        if (vBc.isEmpty || seenBarcodes.contains(vBc)) {
          do {
            vBc = _generateVariantBarcode();
          } while (seenBarcodes.contains(vBc));
          v.barcode = vBc;
        }
        seenBarcodes.add(vBc);
      }

      final productToSave = _product.toDomain();
      await repository.saveProduct(productToSave);
      final listController = ProductController.lastInstance;
      if (listController != null) {
        await listController.refreshProducts();
      }
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product saved successfully")),
        );
      }
      if (resetAfterSave) {
        resetToNew();
      } else {
        notify();
      }
    } catch (e) {
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

  String applyAIPayloadToStudio(Map<String, dynamic> json) {
    if (json.isEmpty) return "Could not parse AI payload";

    if (json.containsKey('product_name') && json['product_name'].toString().isNotEmpty) {
      _product.title = json['product_name'].toString();
    }
    if (json.containsKey('category') && json['category'].toString().isNotEmpty) {
      _product.category = json['category'].toString();
    }
    if (json.containsKey('brand') && json['brand'].toString().isNotEmpty) {
      _product.brand = json['brand'].toString();
    }
    if (json.containsKey('cost_price')) {
      _product.costPrice = double.tryParse(json['cost_price'].toString()) ?? 0.0;
    }
    if (json.containsKey('selling_price')) {
      _product.sellingPrice = double.tryParse(json['selling_price'].toString()) ?? 0.0;
    } else if (_product.costPrice > 0) {
      _product.sellingPrice = (_product.costPrice * 1.6).roundToDouble();
    }
    if (json.containsKey('hsn_code')) {
      _product.hsnCode = json['hsn_code'].toString();
    }
    if (json.containsKey('tax_rate_percentage')) {
      _product.taxRate = double.tryParse(json['tax_rate_percentage'].toString()) ?? 0.0;
    }
    if (json.containsKey('low_stock_threshold')) {
      _product.reorderLevel = double.tryParse(json['low_stock_threshold'].toString()) ?? 0.0;
    }

    int variantCount = 0;
    if (json.containsKey('variants') && json['variants'] is List) {
      final variantsList = json['variants'] as List;
      for (final v in variantsList) {
        if (v is Map<String, dynamic>) {
          final color = (v['color'] ?? v['colour'] ?? "").toString();
          final size = (v['size'] ?? "").toString();

          if (color.isNotEmpty && !selectedColors.contains(color)) {
            selectedColors.add(color);
          }
          if (size.isNotEmpty && !selectedSizes.contains(size)) {
            selectedSizes.add(size);
          }
          variantCount++;
        }
      }
      generateMatrix();

      for (int i = 0; i < generatedVariants.length && i < variantsList.length; i++) {
        final v = variantsList[i] as Map<String, dynamic>;
        if (v.containsKey('stock_quantity')) {
          updateVariantField(i, stock: int.tryParse(v['stock_quantity'].toString()));
        }
        if (v.containsKey('cost_price')) {
          updateVariantField(i, purchasePrice: double.tryParse(v['cost_price'].toString()));
        }
        if (v.containsKey('selling_price')) {
          updateVariantField(i, price: double.tryParse(v['selling_price'].toString()));
        }
        if (v.containsKey('sku') && v['sku'].toString().isNotEmpty) {
          updateVariantField(i, sku: v['sku'].toString());
        }
      }
    }

    notify();
    final totalStock = json['total_calculated_stock'] ?? calculatedTotalStock;
    return "✨ Gemini auto-filled ${variantCount > 0 ? '$variantCount variants' : 'product details'} ($totalStock items total). Ready to Save!";
  }

  void startManualCreationFromScan([dynamic item]) {
    if (item is ProductStudioData) {
      updateProduct(item);
    } else if (item is String) { resetProduct(); _product.barcode = item; }
    setCreationMode(ProductCreationMode.manual);
    setSection(ProductStudioSection.basic);
  }
}
