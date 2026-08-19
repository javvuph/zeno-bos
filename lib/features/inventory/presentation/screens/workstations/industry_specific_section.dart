import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../controllers/product_studio_controller.dart';

class IndustrySpecificSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const IndustrySpecificSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoCard(
          title: "${controller.product.businessCategory} Specifications",
          titleColor: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (controller.isFieldVisible("material"))
                _buildField("Material", controller.product.material, (v) => controller.updateField(material: v)),
              if (controller.isFieldVisible("metalType"))
                _buildField("Metal Type", controller.product.metalType, (v) => controller.updateField(metalType: v)),
              if (controller.isFieldVisible("purity"))
                _buildField("Purity", controller.product.purity, (v) => controller.updateField(purity: v)),
              if (controller.isFieldVisible("weight"))
                _buildField("Weight", controller.product.weight.toString(), (v) => controller.updateField(weight: double.tryParse(v))),
              if (controller.isFieldVisible("stoneType"))
                _buildField("Stone Type", controller.product.stoneType, (v) => controller.updateField(stoneType: v)),
              if (controller.isFieldVisible("stoneWeight"))
                _buildField("Stone Weight", controller.product.stoneWeight.toString(), (v) => controller.updateField(stoneWeight: double.tryParse(v))),
              if (controller.isFieldVisible("jewelrySize"))
                _buildField("Jewelry Size", controller.product.jewelrySize, (v) => controller.updateField(jewelrySize: v)),
              
              if (controller.isFieldVisible("shade"))
                _buildField("Shade", controller.product.shade, (v) => controller.updateField(shade: v)),
              if (controller.isFieldVisible("skinType"))
                _buildField("Skin Type", controller.product.skinType, (v) => controller.updateField(skinType: v)),
              if (controller.isFieldVisible("hairType"))
                _buildField("Hair Type", controller.product.hairType, (v) => controller.updateField(hairType: v)),
              if (controller.isFieldVisible("volume"))
                _buildField("Volume", controller.product.volume, (v) => controller.updateField(volume: v)),
              if (controller.isFieldVisible("ingredients"))
                _buildField("Ingredients", controller.product.ingredients, (v) => controller.updateField(ingredients: v), maxLines: 3),
              if (controller.isFieldVisible("usageInfo"))
                _buildField("Usage Info", controller.product.usageInfo, (v) => controller.updateField(usageInfo: v), maxLines: 3),

              if (controller.isFieldVisible("fragranceFamily"))
                _buildField("Fragrance Family", controller.product.fragranceFamily, (v) => controller.updateField(fragranceFamily: v)),
              if (controller.isFieldVisible("concentration"))
                _buildField("Concentration", controller.product.concentration, (v) => controller.updateField(concentration: v)),
              if (controller.isFieldVisible("gender"))
                _buildField("Gender", controller.product.gender, (v) => controller.updateField(gender: v)),
              if (controller.isFieldVisible("scentNotes"))
                _buildField("Scent Notes", controller.product.scentNotes, (v) => controller.updateField(scentNotes: v), maxLines: 2),

              if (controller.isFieldVisible("serialNumber"))
                _buildField("Serial Number", controller.product.serialNumber, (v) => controller.updateField(serialNumber: v)),
              if (controller.isFieldVisible("imei"))
                _buildField("IMEI", controller.product.imei, (v) => controller.updateField(imei: v)),
              if (controller.isFieldVisible("modelNumber"))
                _buildField("Model Number", controller.product.modelNumber, (v) => controller.updateField(modelNumber: v)),

              if (controller.isFieldVisible("partNumber"))
                _buildField("Part Number", controller.product.partNumber, (v) => controller.updateField(partNumber: v)),
              if (controller.isFieldVisible("oemNumber"))
                _buildField("OEM Number", controller.product.oemNumber, (v) => controller.updateField(oemNumber: v)),
              if (controller.isFieldVisible("compatibility"))
                _buildField("Compatibility", controller.product.compatibility, (v) => controller.updateField(compatibility: v), maxLines: 2),
              if (controller.isFieldVisible("vehicleMake"))
                _buildField("Vehicle Make", controller.product.vehicleMake, (v) => controller.updateField(vehicleMake: v)),
              if (controller.isFieldVisible("vehicleModel"))
                _buildField("Vehicle Model", controller.product.vehicleModel, (v) => controller.updateField(vehicleModel: v)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildField(String label, String? value, ValueChanged<String> onChanged, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ZenoTextField(
        label: label,
        initialValue: value == "0" || value == "0.0" ? "" : (value ?? ""),
        onChanged: onChanged,
        maxLines: maxLines,
      ),
    );
  }
}
