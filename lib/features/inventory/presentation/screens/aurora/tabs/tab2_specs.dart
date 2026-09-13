import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/layouts/zeno_responsive_layout.dart';
import '../../../../domain/models/product_studio_data.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/product_studio_controller.dart';

class Tab2Specs extends StatefulWidget {
  final ProductStudioController controller;
  const Tab2Specs({super.key, required this.controller});

  @override
  State<Tab2Specs> createState() => _Tab2SpecsState();
}

class _Tab2SpecsState extends State<Tab2Specs> {
  final TextEditingController _tagController = TextEditingController();
  static const List<String> _apparelCategories = ["T-Shirt", "Shirt", "Dress", "Trousers", "Saree", "Suit"];
  static const List<String> _genderOptions = ["Men", "Women", "Unisex", "Boys", "Girls", "Infant"];
  static const List<String> _ageGroupOptions = ["Adult", "Teen", "Kids", "Toddler", "Baby"];
  static const List<String> _seasonOptions = ["Summer", "Winter", "Spring", "Autumn", "All-Season"];
  static const List<String> _collectionOptions = ["Core", "Summer Drop", "Festive Edit", "Premium Capsule", "Limited Edition"];
  static const List<String> _materialOptions = ["Cotton", "Polyester", "Linen", "Denim", "Silk", "Wool"];
  static const List<String> _patternOptions = ["Solid", "Striped", "Checked", "Printed", "Floral"];
  static const List<String> _fitOptions = ["Regular", "Slim", "Relaxed", "Oversized"];
  static const List<String> _sleeveOptions = ["Sleeveless", "Short Sleeve", "Full Sleeve", "3/4 Sleeve"];
  static const List<String> _neckOptions = ["Round Neck", "V-Neck", "Polo", "Collar"];

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.controller.product;
    final bType = p.businessType.toUpperCase();
    final scale = p.businessScale;
    final profile = widget.controller.activeProfile;
    final isClothingSmall = profile == "Clothing" && bType == "FASHION" && scale == BusinessScale.small;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoResponsiveLayout(
      child: isClothingSmall
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _compactSection("CLASSIFICATION", colors, [
                        ZenoDropdown<String>(label: "Apparel Category", value: p.apparelCategory.isEmpty ? null : p.apparelCategory, items: _withCurrent(_apparelCategories, p.apparelCategory).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(apparelCategory: v), onQuickAdd: () => _showQuickAddDialog(context, "Apparel Category", (val) => widget.controller.updateField(apparelCategory: val))),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: ZenoDropdown<String>(label: "Gender", value: p.gender.isEmpty ? null : p.gender, items: _withCurrent(_genderOptions, p.gender).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(gender: v), onQuickAdd: () => _showQuickAddDialog(context, "Gender", (val) => widget.controller.updateField(gender: val)))),
                            const SizedBox(width: 8),
                            Expanded(child: ZenoDropdown<String>(label: "Age Group", value: p.targetAgeGroup.isEmpty ? null : p.targetAgeGroup, items: _withCurrent(_ageGroupOptions, p.targetAgeGroup).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(targetAgeGroup: v), onQuickAdd: () => _showQuickAddDialog(context, "Age Group", (val) => widget.controller.updateField(targetAgeGroup: val)))),
                          ],
                        ),
                      ]),
                      const SizedBox(height: 12),
                      _compactSection("COLLECTION & SEASON", colors, [
                        Row(
                          children: [
                            Expanded(child: ZenoDropdown<String>(label: "Season", value: p.season.isEmpty ? null : p.season, items: _withCurrent(_seasonOptions, p.season).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(season: v), onQuickAdd: () => _showQuickAddDialog(context, "Season", (val) => widget.controller.updateField(season: val)))),
                            const SizedBox(width: 8),
                            Expanded(child: ZenoDropdown<String>(label: "Collection / Edition", value: p.collectionEdition.isEmpty ? null : p.collectionEdition, items: _withCurrent(_collectionOptions, p.collectionEdition).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(collectionEdition: v), onQuickAdd: () => _showQuickAddDialog(context, "Collection / Edition", (val) => widget.controller.updateField(collectionEdition: val)))),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      _compactSection("FABRIC & MATERIAL", colors, [
                        Row(
                          children: [
                            Expanded(child: ZenoDropdown<String>(label: "Material", value: p.material.isEmpty ? null : p.material, items: _withCurrent(_materialOptions, p.material).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(material: v), onQuickAdd: () => _showQuickAddDialog(context, "Material", (val) => widget.controller.updateField(material: val)))),
                            const SizedBox(width: 8),
                            Expanded(child: ZenoTextField(label: "Fabric Composition", initialValue: p.ingredients, onChanged: (v) => widget.controller.updateField(ingredients: v))),
                          ],
                        ),
                      ]),
                      const SizedBox(height: 12),
                      _compactSection("DESIGN", colors, [
                        Row(
                          children: [
                            Expanded(child: ZenoDropdown<String>(label: "Pattern / Design", value: p.patternDesign.isEmpty ? null : p.patternDesign, items: _withCurrent(_patternOptions, p.patternDesign).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(patternDesign: v), onQuickAdd: () => _showQuickAddDialog(context, "Pattern / Design", (val) => widget.controller.updateField(patternDesign: val)))),
                            const SizedBox(width: 8),
                            Expanded(child: ZenoDropdown<String>(label: "Fit Type", value: p.fitType.isEmpty ? null : p.fitType, items: _withCurrent(_fitOptions, p.fitType).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(fitType: v), onQuickAdd: () => _showQuickAddDialog(context, "Fit Type", (val) => widget.controller.updateField(fitType: val)))),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(child: ZenoDropdown<String>(label: "Sleeve Type", value: p.styleCategory.isEmpty ? null : p.styleCategory, items: _withCurrent(_sleeveOptions, p.styleCategory).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(styleCategory: v), onQuickAdd: () => _showQuickAddDialog(context, "Sleeve Type", (val) => widget.controller.updateField(styleCategory: val)))),
                            const SizedBox(width: 8),
                            Expanded(child: ZenoDropdown<String>(label: "Neck Type", value: p.sleeveNeckType.isEmpty ? null : p.sleeveNeckType, items: _withCurrent(_neckOptions, p.sleeveNeckType).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(sleeveNeckType: v), onQuickAdd: () => _showQuickAddDialog(context, "Neck Type", (val) => widget.controller.updateField(sleeveNeckType: val)))),
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _compactSection("CARE", colors, [
                    ZenoTextField(label: "Care Guide", initialValue: p.careGuide, onChanged: (v) => widget.controller.updateField(careGuide: v), maxLines: 6),
                  ]),
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Classification
                    Expanded(
                      flex: 4,
                      child: ZenoCard(
                        title: "Classification",
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: ZenoDropdown<String>(
                                label: "Department *",
                                value: p.departmentId.isEmpty ? null : p.departmentId,
                                items: widget.controller.departmentsList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                onChanged: (v) => widget.controller.updateField(departmentId: v),
                                isRequired: true,
                                onQuickAdd: () => _showQuickAddDialog(context, "Department", (val) => widget.controller.addDepartment(val)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ZenoDropdown<String>(
                                label: "Category *",
                                value: p.category.isEmpty ? null : p.category,
                                items: widget.controller.categoriesList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                onChanged: (v) => widget.controller.updateField(category: v),
                                isRequired: true,
                                onQuickAdd: () => _showQuickAddDialog(context, "Category", (val) => widget.controller.addCategory(val)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ZenoDropdown<String>(
                                label: "Subcategory *",
                                value: p.subcategory.isEmpty ? null : p.subcategory,
                                items: widget.controller.categoriesList.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                onChanged: (v) => widget.controller.updateField(subcategory: v),
                                isRequired: true,
                                onQuickAdd: () => _showQuickAddDialog(context, "Subcategory", (val) => widget.controller.addSubcategory(val)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ZenoDropdown<String>(
                                label: "Type *",
                                value: p.productType.isEmpty ? null : p.productType,
                                items: ["Standard", "Service", "Digital", "Bundle"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                onChanged: (v) => widget.controller.updateField(productType: v),
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ZenoTextField(
                                key: const ValueKey('segment'),
                                label: "Segment",
                                initialValue: p.segment,
                                onChanged: (v) => widget.controller.updateField(segment: v),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Tags
                    Expanded(
                      flex: 2,
                      child: ZenoCard(
                        title: "Tags",
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: ZenoTextField(
                                controller: _tagController,
                                label: "Add Tag",
                                onSubmitted: (v) {
                                  if (v.isNotEmpty) {
                                    final tags = p.tags.isEmpty ? [] : p.tags.split(',').map((e) => e.trim()).toList();
                                    if (!tags.contains(v)) {
                                      tags.add(v);
                                      widget.controller.updateField(tags: tags.join(', '));
                                    }
                                    _tagController.clear();
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, color: Color(0xFFC00000), size: 20),
                              onPressed: () {
                                final v = _tagController.text;
                                if (v.isNotEmpty) {
                                  final tags = p.tags.isEmpty ? [] : p.tags.split(',').map((e) => e.trim()).toList();
                                  if (!tags.contains(v)) {
                                    tags.add(v);
                                    widget.controller.updateField(tags: tags.join(', '));
                                  }
                                  _tagController.clear();
                                  setState(() {});
                                }
                              },
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: (p.tags.isEmpty ? [] : p.tags.split(',')).map((tag) {
                                    final trimmedTag = tag.trim();
                                    if (trimmedTag.isEmpty) return const SizedBox.shrink();
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Chip(
                                        label: Text(trimmedTag, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                                        onDeleted: () {
                                          final tags = p.tags.split(',').map((e) => e.trim()).where((e) => e != trimmedTag).toList();
                                          widget.controller.updateField(tags: tags.join(', '));
                                          setState(() {});
                                        },
                                        deleteIcon: const Icon(Icons.close, size: 10),
                                        backgroundColor: colors.bgTier3,
                                        side: BorderSide(color: colors.borderSubtle),
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Section 2: Product Capabilities
                ZenoCard(
                  title: "Product Capabilities",
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _capabilityCompactTile("WEIGHED", p.capWeighed, (v) => widget.controller.updateField(capWeighed: v)),
                      _capabilityCompactTile("PLU CODE", p.capPluCode, (v) => widget.controller.updateField(capPluCode: v)),
                      _capabilityCompactTile("BULK", p.capBulk, (v) => widget.controller.updateField(capBulk: v)),
                      _capabilityCompactTile("REPACK", p.capRepack, (v) => widget.controller.updateField(capRepack: v)),
                      _capabilityCompactTile("TARE", p.capTare, (v) => widget.controller.updateField(capTare: v)),
                      _capabilityCompactTile("CATCH WT", p.capCatchWeight, (v) => widget.controller.updateField(capCatchWeight: v)),
                      _capabilityCompactTile("VARIANT", p.capVariant, (v) => widget.controller.updateField(capVariant: v)),
                      _capabilityCompactTile("DEPOSIT", p.capDeposit, (v) => widget.controller.updateField(capDeposit: v)),
                      _capabilityCompactTile("COLD CHAIN", p.capColdChain, (v) => widget.controller.updateField(capColdChain: v)),
                      _capabilityCompactTile("AGE RESTRICT", p.capAgeRestriction, (v) => widget.controller.updateField(capAgeRestriction: v)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Section 3: Dynamic Capability Details
                if (_hasAnyCapability(p))
                  ZenoCard(
                    title: "Capability Details",
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Column(
                      children: [
                        if (p.capWeighed) _buildDetailGroup("WEIGHED", _buildWeighedDetails(p)),
                        if (p.capPluCode) _buildDetailGroup("PLU CODE", _buildPluDetails(p)),
                        if (p.capBulk) _buildDetailGroup("BULK", _buildBulkDetails(p)),
                        if (p.capRepack) _buildDetailGroup("REPACK", _buildRepackDetails(p)),
                        if (p.capTare) _buildDetailGroup("TARE", _buildTareDetails(p)),
                        if (p.capCatchWeight) _buildDetailGroup("CATCH WEIGHT", _buildCatchWeightDetails(p)),
                        if (p.capVariant) _buildDetailGroup("VARIANT", _buildVariantDetails(p)),
                        if (p.capDeposit) _buildDetailGroup("DEPOSIT", _buildDepositDetails(p)),
                        if (p.capColdChain) _buildDetailGroup("COLD CHAIN", _buildColdChainDetails(p)),
                        if (p.capAgeRestriction) _buildDetailGroup("AGE RESTRICTION", _buildAgeRestrictionDetails(p)),
                      ],
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _capabilityCompactTile(String label, bool value, ValueChanged<bool> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: value ? const Color(0xFFC00000).withValues(alpha: 0.1) : Colors.transparent,
          border: Border.all(color: value ? const Color(0xFFC00000) : const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: Checkbox(
                value: value,
                onChanged: (v) => onChanged(v ?? false),
                activeColor: const Color(0xFFC00000),
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: value ? const Color(0xFFC00000) : const Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  bool _hasAnyCapability(ProductStudioData p) => p.capWeighed || p.capPluCode || p.capBulk || p.capRepack || p.capTare || p.capCatchWeight || p.capVariant || p.capDeposit || p.capColdChain || p.capAgeRestriction;

  Widget _buildWeighedDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "Sales UOM (Read-only)", initialValue: p.salesUnit, readOnly: true)),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "Scale Mode", value: p.scaleMode.isEmpty ? null : p.scaleMode, items: ["Automatic", "Manual", "Pre-packed"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(scaleMode: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Tare Weight", initialValue: p.tareWeight.toString(), onChanged: (v) => widget.controller.updateField(tareWeight: double.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "PLU Code", initialValue: p.pluCode, onChanged: (v) => widget.controller.updateField(pluCode: v))),
        ],
      );

  Widget _buildPluDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "PLU Code", initialValue: p.pluCode, onChanged: (v) => widget.controller.updateField(pluCode: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "PLU Type", value: p.pluType.isEmpty ? null : p.pluType, items: ["Standard", "EAN-based", "Short Code"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(pluType: v))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildBulkDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "Bulk Source Product", initialValue: p.bulkSourceProduct, onChanged: (v) => widget.controller.updateField(bulkSourceProduct: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Available Bulk Quantity", initialValue: p.availableBulkQuantity.toString(), onChanged: (v) => widget.controller.updateField(availableBulkQuantity: double.tryParse(v)))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildRepackDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "Source Product", initialValue: p.repackSourceProduct, onChanged: (v) => widget.controller.updateField(repackSourceProduct: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Conversion Ratio", initialValue: p.repackConversionRatio.toString(), onChanged: (v) => widget.controller.updateField(repackConversionRatio: double.tryParse(v)))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildTareDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoDropdown<String>(label: "Tare Mode", value: p.tareMode.isEmpty ? null : p.tareMode, items: ["Fixed", "Percentage", "By Container"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(tareMode: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Tare Weight", initialValue: p.tareWeight.toString(), onChanged: (v) => widget.controller.updateField(tareWeight: double.tryParse(v)))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildCatchWeightDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "Minimum Weight", initialValue: p.minWeight.toString(), onChanged: (v) => widget.controller.updateField(minWeight: double.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Maximum Weight", initialValue: p.maxWeight.toString(), onChanged: (v) => widget.controller.updateField(maxWeight: double.tryParse(v)))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildVariantDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "Variant Group", initialValue: p.variantGroup, onChanged: (v) => widget.controller.updateField(variantGroup: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoDropdown<String>(label: "Variant Type", value: p.variantType.isEmpty ? null : p.variantType, items: ["Color", "Size", "Flavor", "Material"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(variantType: v))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildDepositDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoDropdown<String>(label: "Deposit Type", value: p.depositType.isEmpty ? null : p.depositType, items: ["Bottle", "Crate", "Pallet"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(depositType: v))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Deposit Amount", initialValue: p.depositAmount.toString(), onChanged: (v) => widget.controller.updateField(depositAmount: double.tryParse(v)))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildColdChainDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "Min Storage Temp (°C)", initialValue: p.minStorageTemp.toString(), onChanged: (v) => widget.controller.updateField(minStorageTemp: double.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Max Storage Temp (°C)", initialValue: p.maxStorageTemp.toString(), onChanged: (v) => widget.controller.updateField(maxStorageTemp: double.tryParse(v)))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildAgeRestrictionDetails(ProductStudioData p) => Row(
        children: [
          Expanded(child: ZenoTextField(label: "Minimum Age", initialValue: p.minAge.toString(), onChanged: (v) => widget.controller.updateField(minAge: int.tryParse(v)))),
          const SizedBox(width: 12),
          Expanded(child: ZenoTextField(label: "Legal Reference", initialValue: p.legalReference, onChanged: (v) => widget.controller.updateField(legalReference: v))),
          const Spacer(flex: 2),
        ],
      );

  Widget _buildDetailGroup(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(title, style: const TextStyle(fontSize: 7, fontWeight: FontWeight.w900, color: Color(0xFFC00000), letterSpacing: 0.5))),
          const SizedBox(width: 10),
          Expanded(child: child),
        ],
      ),
    );
  }

  List<String> _withCurrent(List<String> options, String current) {
    if (current.isEmpty || options.contains(current)) return options;
    return [...options, current];
  }

  Widget _compactSection(String title, ZenoSemanticColors colors, List<Widget> children) {
    return ZenoCard(
      title: title,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  void _showQuickAddDialog(BuildContext context, String type, Function(String) onAdd) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Add Custom $type", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: textController,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            labelText: "$type Name",
            hintText: "Enter $type name",
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                onAdd(textController.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
