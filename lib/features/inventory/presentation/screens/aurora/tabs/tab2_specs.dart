import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/layouts/zeno_responsive_layout.dart';
import '../../../../domain/models/product_studio_data.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/product_studio_controller.dart';

part 'parts/tab2_specs_details.part.dart';
part 'parts/tab2_specs_capabilities.part.dart';
part 'parts/tab2_specs_clothing.part.dart';

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
          ? _buildClothingSmallLayout(p, colors)
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
}
