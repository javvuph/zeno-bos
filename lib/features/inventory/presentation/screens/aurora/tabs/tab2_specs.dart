import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import '../../../../domain/models/product_studio_data.dart';
import '../../../controllers/product_studio_controller.dart';

class Tab2Specs extends StatefulWidget {
  final ProductStudioController controller;
  const Tab2Specs({super.key, required this.controller});

  @override
  State<Tab2Specs> createState() => _Tab2SpecsState();
}

class _Tab2SpecsState extends State<Tab2Specs> {
  final TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.controller.product;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
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
                              final tags = p.tags.isEmpty ? [] : p.tags.split(',').map((e)=>e.trim()).toList();
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
                            final tags = p.tags.isEmpty ? [] : p.tags.split(',').map((e)=>e.trim()).toList();
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
                                    final tags = p.tags.split(',').map((e)=>e.trim()).where((e)=>e != trimmedTag).toList();
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
              width: 16, height: 16,
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

  bool _hasAnyCapability(ProductStudioData p) => 
    p.capWeighed || p.capPluCode || p.capBulk || p.capRepack || p.capTare || 
    p.capCatchWeight || p.capVariant || p.capDeposit || p.capColdChain || p.capAgeRestriction;

  Widget _buildWeighedDetails(ProductStudioData p) => Row(
    children: [
      Expanded(child: ZenoTextField(label: "Sales UOM (Read-only)", initialValue: p.salesUnit, readOnly: true)),
      const SizedBox(width: 12),
      Expanded(child: ZenoDropdown<String>(label: "Scale Mode", value: p.scaleMode.isEmpty ? null : p.scaleMode, items: ["Automatic", "Manual", "Pre-packed"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(scaleMode: v))),
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
      Expanded(child: ZenoDropdown<String>(label: "PLU Type", value: p.pluType.isEmpty ? null : p.pluType, items: ["Standard", "EAN-based", "Short Code"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(pluType: v))),
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
      Expanded(child: ZenoDropdown<String>(label: "Tare Mode", value: p.tareMode.isEmpty ? null : p.tareMode, items: ["Fixed", "Percentage", "By Container"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(tareMode: v))),
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
      Expanded(child: ZenoDropdown<String>(label: "Variant Type", value: p.variantType.isEmpty ? null : p.variantType, items: ["Color", "Size", "Flavor", "Material"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(variantType: v))),
      const Spacer(flex: 2),
    ],
  );

  Widget _buildDepositDetails(ProductStudioData p) => Row(
    children: [
      Expanded(child: ZenoDropdown<String>(label: "Deposit Type", value: p.depositType.isEmpty ? null : p.depositType, items: ["Bottle", "Crate", "Pallet"].map((e)=>DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(depositType: v))),
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
}
