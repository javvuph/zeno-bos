import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

Widget buildShoesLayout(ProductStudioController controller) {
  return Column(children: [
    Row(children: [
      _f25("Style Category", controller.product.styleCategory, (v) => controller.updateField(styleCategory: v)),
      _f25("Season", controller.product.season, (v) => controller.updateField(season: v)),
      _f25("Sole Material", controller.product.soleMaterial, (v) => controller.updateField(soleMaterial: v)),
      _f25("Closure Type", controller.product.closureType, (v) => controller.updateField(closureType: v)),
    ]),
    const SizedBox(height: 16),
    Row(children: [
      _f25("Width Fit", controller.product.widthFit, (v) => controller.updateField(widthFit: v)),
      _f25("Size Standard", controller.product.sizeStandard, (v) => controller.updateField(sizeStandard: v)),
      _f25("Gender", controller.product.gender, (v) => controller.updateField(gender: v)),
      _f25("Materials", controller.product.material, (v) => controller.updateField(material: v)),
    ]),
  ]);
}

Widget buildClothingLayout(ProductStudioController controller) {
  return Column(children: [
    Row(children: [
      _f25("Apparel Category", controller.product.apparelCategory, (v) => controller.updateField(apparelCategory: v)),
      _f25("Pattern / Design", controller.product.patternDesign, (v) => controller.updateField(patternDesign: v)),
      _f25("Fit Type", controller.product.fitType, (v) => controller.updateField(fitType: v)),
      _f25("Sleeve / Neck", controller.product.sleeveNeckType, (v) => controller.updateField(sleeveNeckType: v)),
    ]),
    const SizedBox(height: 16),
    Row(children: [
      _f33("Fabric / Material", controller.product.material, (v) => controller.updateField(material: v)),
      _f33("Care Guide", controller.product.careGuide, (v) => controller.updateField(careGuide: v)),
      _f33("Gender", controller.product.gender, (v) => controller.updateField(gender: v)),
    ]),
  ]);
}

Widget buildBoutiqueLayout(ProductStudioController controller, Color iris) {
  return Column(children: [
    Row(children: [
      _f33("Artisan / Label", controller.product.artisanLabel, (v) => controller.updateField(artisanLabel: v)),
      _f33("Collection / Edition", controller.product.collectionEdition, (v) => controller.updateField(collectionEdition: v)),
      _f33("Lead Time (Days)", controller.product.productionLeadTime.toString(), (v) => controller.updateField(productionLeadTime: int.tryParse(v))),
    ]),
    const SizedBox(height: 16),
    Row(children: [
      Expanded(child: _sw("Exclusive Single Piece", controller.product.exclusiveSinglePiece, (v) => controller.updateField(exclusiveSinglePiece: v), iris)),
      const SizedBox(width: 16),
      Expanded(child: _sw("Made to Order", controller.product.madeToOrder, (v) => controller.updateField(madeToOrder: v), iris)),
    ]),
    const SizedBox(height: 16),
    Row(children: [
      _f25("Bust", controller.product.measurementBust, (v) => controller.updateField(measurementBust: v)),
      _f25("Waist", controller.product.measurementWaist, (v) => controller.updateField(measurementWaist: v)),
      _f25("Hip", controller.product.measurementHip, (v) => controller.updateField(measurementHip: v)),
      _f25("Full Length", controller.product.measurementFullLength, (v) => controller.updateField(measurementFullLength: v)),
    ]),
  ]);
}

Widget buildJewelryLayout(ProductStudioController controller) {
  return Column(children: [
    Row(children: [
      _f25("Metal Type", controller.product.metalType, (v) => controller.updateField(metalType: v)),
      _f25("Purity", controller.product.purity, (v) => controller.updateField(purity: v)),
      _f25("Gross Weight", controller.product.grossWeight.toString(), (v) => controller.updateField(grossWeight: double.tryParse(v))),
      _f25("Gemstone Count", controller.product.gemstoneCount.toString(), (v) => controller.updateField(gemstoneCount: int.tryParse(v))),
    ]),
    const SizedBox(height: 16),
    Row(children: [
      _f25("Hallmark Cert", controller.product.hallmarkCert, (v) => controller.updateField(hallmarkCert: v)),
      _f25("Making Mode", controller.product.makingChargeMode, (v) => controller.updateField(makingChargeMode: v)),
      _f25("Making Rate", controller.product.makingChargeRate.toString(), (v) => controller.updateField(makingChargeRate: double.tryParse(v))),
      _f25("Wastage %", controller.product.wastagePct.toString(), (v) => controller.updateField(wastagePct: double.tryParse(v))),
    ]),
    const SizedBox(height: 16),
    ZenoTextField(label: "Live Rate Link", initialValue: controller.product.liveRateLink, onChanged: (v) => controller.updateField(liveRateLink: v)),
  ]);
}

Widget buildCosmeticsLayout(ProductStudioController controller, ZenoSemanticColors colors) {
  return Column(children: [
    Row(children: [
      _f25("Brand Range", controller.product.brandRange, (v) => controller.updateField(brandRange: v)),
      _f25("Shade", controller.product.shade, (v) => controller.updateField(shade: v)),
      _f25("Skin Type", controller.product.skinType, (v) => controller.updateField(skinType: v)),
      _f25("Volume", controller.product.volume, (v) => controller.updateField(volume: v)),
    ]),
    const SizedBox(height: 16),
    Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Shade Hex", style: TextStyle(fontSize: 8, color: Colors.grey)), const SizedBox(height: 4),
        Row(children: [
          Container(width: 24, height: 24, decoration: BoxDecoration(color: _parse(controller.product.shadeHexColor), borderRadius: BorderRadius.circular(4), border: Border.all(color: colors.borderSubtle))),
          const SizedBox(width: 8),
          Expanded(child: ZenoTextField(initialValue: controller.product.shadeHexColor, onChanged: (v) => controller.updateField(shadeHexColor: v))),
        ]),
      ])),
      const SizedBox(width: 16),
      _f25("Safety Certs", controller.product.safetyCertifications.join(", "), (v) => controller.updateField(safetyCertifications: v.split(",").map((e) => e.trim()).toList())),
      _f25("PAO (Months)", controller.product.periodAfterOpening, (v) => controller.updateField(periodAfterOpening: v)),
    ]),
  ]);
}

Widget buildPerfumeLayout(ProductStudioController controller) {
  return Column(children: [
    Row(children: [
      _f25("Perfume House", controller.product.perfumeHouse, (v) => controller.updateField(perfumeHouse: v)),
      _f25("Fragrance Family", controller.product.fragranceFamily, (v) => controller.updateField(fragranceFamily: v)),
      _f25("Concentration", controller.product.concentration, (v) => controller.updateField(concentration: v)),
      _f25("Volume", controller.product.volume, (v) => controller.updateField(volume: v)),
    ]),
    const SizedBox(height: 16),
    Row(children: [
      _f33("Top Notes", controller.product.topNotes, (v) => controller.updateField(topNotes: v)),
      _f33("Middle Notes", controller.product.middleNotes, (v) => controller.updateField(middleNotes: v)),
      _f33("Base Notes", controller.product.baseNotes, (v) => controller.updateField(baseNotes: v)),
    ]),
  ]);
}

Widget _f25(String l, String? v, Function(String) o) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: ZenoTextField(label: l, initialValue: v ?? "", onChanged: o)));
Widget _f33(String l, String? v, Function(String) o) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 12), child: ZenoTextField(label: l, initialValue: v ?? "", onChanged: o)));
Widget _sw(String l, bool v, Function(bool) o, Color i) => Row(children: [Text(l, style: const TextStyle(fontSize: 8, color: Colors.black)), const Spacer(), Switch(value: v, onChanged: o, activeThumbColor: i)]);
Color _parse(String h) { try { if (h.startsWith("#")) h = h.substring(1); if (h.length == 6) h = "FF$h"; return Color(int.parse(h, radix: 16)); } catch (_) { return Colors.transparent; } }
