part of '../tab2_specs.dart';

extension _Tab2SpecsDetailsState on _Tab2SpecsState {
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
}
