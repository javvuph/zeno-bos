import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';
import '../widgets/product_studio_widgets.dart';
import 'widgets/zeno_master_dropdown_field.dart';
import 'widgets/zeno_hover_description_field.dart';

class AuroraFieldRenderer extends StatelessWidget {
  final ProductStudioController controller;
  final List<String> fieldIds;
  final double spacing;

  const AuroraFieldRenderer({
    super.key,
    required this.controller,
    required this.fieldIds,
    this.spacing = 12.0, // Reduced from 16
  });

  @override
  Widget build(BuildContext context) {
    final visibleFields = fieldIds.where((f) => controller.isFieldVisible(f)).toList();
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: visibleFields.map((fieldId) {
        return _buildField(context, fieldId, colors);
      }).toList(),
    );
  }

  Widget _buildField(BuildContext context, String fieldId, ZenoSemanticColors colors) {
    final widthTier = _getSemanticWidthTier(fieldId);
    final label = controller.getFieldLabel(fieldId);
    final p = controller.product;
    final value = controller.getFieldValueById(p, fieldId);
    final isArabic = fieldId == 'arabicTitle';

    double? pixelWidth;
    switch (widthTier) {
      case ZenoFieldWidth.micro: pixelWidth = 100; break;
      case ZenoFieldWidth.short: pixelWidth = 160; break;
      case ZenoFieldWidth.medium: pixelWidth = 240; break;
      case ZenoFieldWidth.standard: pixelWidth = 360; break;
      case ZenoFieldWidth.full: pixelWidth = double.infinity; break;
    }

    Widget content;

    // SPECIAL DESCRIPTION HOVER
    if (fieldId == 'description' || fieldId == 'recipePrepNotes') {
      content = ZenoHoverDescriptionField(
        label: label,
        initialValue: value.toString(),
        onChanged: (v) => controller.updateFieldById(p, fieldId, v),
        width: widthTier,
      );
    } else if (['brand', 'category', 'department', 'warehouseLocation', 'supplier', 'taxJurisdiction'].contains(fieldId)) {
      // MASTER DATA SELECTORS
      List<String> items;
      String currentVal;
      String typeLabel;
      Function(String) onAdd;

      if (fieldId == 'brand') {
        items = controller.brandsList; currentVal = p.brand; typeLabel = "Brand"; 
        onAdd = (n) => controller.addBrand(n);
      } else if (fieldId == 'category') {
        items = controller.categoriesList; currentVal = p.category; typeLabel = "Category";
        onAdd = (n) => controller.addCategory(n);
      } else if (fieldId == 'department') {
        items = controller.categoriesList; 
        currentVal = p.departmentId; typeLabel = "Department";
        onAdd = (n) => {}; 
      } else if (fieldId == 'warehouseLocation') {
        items = controller.locationsList; currentVal = p.warehouseLocation; typeLabel = "Location";
        onAdd = (n) => controller.addWarehouse(n);
      } else if (fieldId == 'supplier') {
        items = controller.suppliersList; currentVal = p.supplier; typeLabel = "Supplier";
        onAdd = (n) => controller.suppliersList.add(n);
      } else {
        items = controller.jurisdictionsList; currentVal = p.taxJurisdiction; typeLabel = "Jurisdiction";
        onAdd = (n) => controller.addTaxJurisdiction(n);
      }

      content = ZenoMasterDropdownField<String>(
        label: label, width: pixelWidth, value: currentVal.isEmpty ? null : currentVal,
        items: items.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => controller.updateFieldById(p, fieldId, v),
        onQuickAdd: () => showAddDialog(context, colors, typeLabel, onAdd),
        isRequired: _isRequired(fieldId),
      );
    } else if (['subcategory', 'subDepartment', 'productClassification', 'brandType', 'taxStatus', 'taxCategory', 'gstTaxMode', 'gender', 'targetAgeGroup', 'season', 'status', 'productLifecycleStatus', 'prescriptionClass', 'dosageForm', 'foodClass', 'spiceLevel', 'fineDiningCourse', 'storageCondition'].contains(fieldId)) {
      // Standard Dropdowns
      final List<String> dropdownItems;
      if (fieldId == 'productClassification') dropdownItems = ["Food", "Non-Food"];
      else if (fieldId == 'brandType') dropdownItems = ["National", "International", "Private Label"];
      else if (fieldId == 'taxStatus') dropdownItems = (controller.currentTaxConfig['statuses'] as List<String>);
      else if (fieldId == 'taxCategory') dropdownItems = (controller.currentTaxConfig['categories'] as List<String>);
      else if (fieldId == 'gstTaxMode') dropdownItems = (controller.currentTaxConfig['gstModes'] as List<String>);
      else if (fieldId == 'gender') dropdownItems = ["Men", "Women", "Unisex", "Boys", "Girls", "Infant"];
      else if (fieldId == 'targetAgeGroup') dropdownItems = ["Adult", "Teens", "Kids", "Toddler", "Baby"];
      else if (fieldId == 'season') dropdownItems = ["Spring", "Summer", "Autumn", "Winter", "All-Season", "Festive"];
      else if (fieldId == 'status' || fieldId == 'productLifecycleStatus') dropdownItems = ["Active", "Phase-Out", "Discontinued"];
      else if (fieldId == 'prescriptionClass') dropdownItems = ["Rx Mandatory", "OTC", "Schedule H", "Schedule X"];
      else if (fieldId == 'dosageForm') dropdownItems = ["Tablet", "Capsule", "Syrup", "Injection", "Ointment"];
      else if (fieldId == 'foodClass') dropdownItems = ["Veg", "Non-Veg", "Egg", "Vegan", "Jain"];
      else if (fieldId == 'spiceLevel') dropdownItems = ["Mild", "Medium", "Spicy", "Extra Hot"];
      else if (fieldId == 'fineDiningCourse') dropdownItems = ["Starter", "Soup", "Salad", "Main Course", "Dessert", "Beverage"];
      else if (fieldId == 'storageCondition') dropdownItems = ["Ambient", "Chilled", "Frozen", "Dry Dark"];
      else dropdownItems = controller.subcategoriesList;

      content = ZenoDropdown<String>(
        key: ValueKey(fieldId), label: label, value: value.toString().isEmpty ? null : value.toString(),
        items: dropdownItems.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => controller.updateFieldById(p, fieldId, v), width: widthTier,
      );
    } else if (fieldId.contains('Unit') || fieldId == 'unit') {
      content = ZenoDropdown<String>(
        key: ValueKey(fieldId), label: label, value: value.toString().isEmpty ? "Piece (Pc)" : value.toString(),
        items: controller.unitsList.map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: (v) => controller.updateFieldById(p, fieldId, v), width: widthTier,
      );
    } else if (value is bool) {
      return SizedBox(
        width: pixelWidth ?? 240,
        height: 38,
        child: Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
            const Spacer(),
            Switch(
              value: value,
              onChanged: (v) => controller.updateFieldById(p, fieldId, v),
              activeThumbColor: const Color(0xFF4F46E5),
            ),
          ],
        ),
      );
    } else {
      // Default TextField
      content = ZenoTextField(
        key: ValueKey(fieldId),
        label: isArabic ? "Arabic Name" : label,
        suffix: isArabic ? _buildArabicBadge() : null,
        initialValue: value == null ? "" : value.toString(),
        onChanged: (v) => controller.updateFieldById(p, fieldId, v),
        width: widthTier,
        maxLines: 1,
        isRequired: _isRequired(fieldId),
        textAlign: isArabic ? TextAlign.right : (widthTier == ZenoFieldWidth.micro || widthTier == ZenoFieldWidth.short ? TextAlign.center : TextAlign.start),
      );
    }

    return content;
  }

  Widget _buildArabicBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(4)),
      child: const Text("AR", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF4F46E5))),
    );
  }

  ZenoFieldWidth _getSemanticWidthTier(String fieldId) {
    if (fieldId == 'description' || fieldId == 'recipePrepNotes' || fieldId == 'careInstructions' || fieldId == 'notes') {
      return ZenoFieldWidth.full;
    }
    if (fieldId == 'title' || fieldId == 'arabicTitle' || fieldId == 'collectionEdition') {
      return ZenoFieldWidth.standard;
    }
    if (fieldId.contains('Price') || fieldId == 'mrp' || fieldId == 'costPrice' || fieldId == 'discountValue' || fieldId == 'taxCode' || fieldId == 'pluCode') {
      return ZenoFieldWidth.short;
    }
    if (fieldId.contains('Qty') || fieldId == 'taxRate' || fieldId.contains('Stock') || fieldId == 'reorderLevel' || fieldId == 'palletStacking' || fieldId == 'unitsPerStrip') {
      return ZenoFieldWidth.micro;
    }
    return ZenoFieldWidth.medium;
  }

  bool _isRequired(String fieldId) {
    return fieldId == 'title' || fieldId == 'sku' || fieldId == 'brand' || fieldId == 'category';
  }
}
