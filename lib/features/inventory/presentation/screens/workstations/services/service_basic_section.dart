import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/service_schemas.dart';

class ServiceBasicSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const ServiceBasicSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ZenoCard(
        title: "💈 Service Identity & Booking Specifications",
        titleColor: colors.accentPrimary,
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "SERVICE / PACKAGE NAME *", initialValue: controller.product.title, onChanged: (v) => controller.updateField(title: v), hint: "e.g., Signature Spa Massage & Facial")),
            const SizedBox(width: 16),
            Expanded(child: ZenoTextField(label: "SCOPE OF WORK / DESCRIPTION *", initialValue: controller.product.description, onChanged: (v) => controller.updateField(description: v), maxLines: 2, hint: "Multi-line details for Booking Portal & Invoice")),
          ]),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: _segmented(label: "DELIVERY", value: controller.product.serviceDeliveryMode, items: serviceDeliveryModes, onChanged: (v) => controller.updateField(serviceDeliveryMode: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "DURATION", initialValue: controller.product.serviceDuration.toString(), onChanged: (v) => controller.updateField(serviceDuration: int.tryParse(v)), suffix: const Padding(padding: EdgeInsets.all(12), child: Text("Mins", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))))),
            const SizedBox(width: 12),
            Expanded(child: ZenoDropdown<String>(label: "BILLING MODEL", value: controller.product.billingModel, items: billingModels.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(), onChanged: (v) => controller.updateField(billingModel: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "SAC / TAX CODE", initialValue: controller.product.sacCode, onChanged: (v) => controller.updateField(sacCode: v), hint: "e.g., 998711")),
          ]),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(child: ZenoTextField(label: "SPECIALIST ALLOCATION", initialValue: controller.product.allocatedStaff.join(", "), onChanged: (v) => controller.updateField(allocatedStaff: v.split(",").map((e) => e.trim()).toList()), hint: "Multi-Select Staff")),
            const SizedBox(width: 12),
            Expanded(child: _segmented(label: "TARGET AUDIENCE", value: controller.product.targetAudience, items: targetAudiences, onChanged: (v) => controller.updateField(targetAudience: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "BUFFER / CLEANUP TIME", initialValue: controller.product.bufferTime.toString(), onChanged: (v) => controller.updateField(bufferTime: int.tryParse(v)), suffix: const Padding(padding: EdgeInsets.all(12), child: Text("Mins", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))))),
          ]),
        ]),
      ),
      const SizedBox(height: 16),
      _buildSpecificExtensions(),
    ]);
  }

  Widget _segmented({required String label, required String value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.grey)),
      const SizedBox(height: 8),
      Wrap(spacing: 4, runSpacing: 4, children: items.map((item) {
        final isSelected = value == item;
        return InkWell(onTap: () => onChanged(item), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), decoration: BoxDecoration(color: isSelected ? colors.accentPrimary.withValues(alpha: 0.1) : colors.bgTier3, borderRadius: BorderRadius.circular(6), border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle)), child: Text(item, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isSelected ? colors.accentPrimary : colors.textPrimary))));
      }).toList()),
    ]);
  }

  Widget _buildSpecificExtensions() {
    final cat = controller.product.businessCategory;
    if (cat == "Salon" || cat == "Spa") return _buildWellnessExtension(cat);
    if (cat == "Laundry" || cat == "Dry Cleaning" || cat == "Tailoring") return _buildGarmentExtension(cat);
    if (cat == "Repair Center" || cat == "IT Services") return _buildRepairExtension(cat);
    if (cat == "Courier Service" || cat == "Printing Service") return _buildLogisticsExtension(cat);
    if (cat == "Consultancy" || cat == "Education / Coaching") return _buildProfessionalExtension(cat);
    if (cat == "Gym / Fitness Center") return _buildFitnessExtension();
    return const SizedBox.shrink();
  }

  Widget _buildWellnessExtension(String cat) => ZenoCard(title: "$cat Details", child: Row(children: [Expanded(child: ZenoDropdown<String>(label: "Category", value: controller.product.serviceCategory, items: salonCategories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => controller.updateField(serviceCategory: v))), const SizedBox(width: 12), Expanded(child: ZenoDropdown<String>(label: "Room/Cabin", value: controller.product.therapistRoom, items: spaRooms.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(), onChanged: (v) => controller.updateField(therapistRoom: v))), const SizedBox(width: 12), Expanded(child: ZenoTextField(label: "Commission Rate", initialValue: controller.product.staffCommissionRate.toString(), onChanged: (v) => controller.updateField(staffCommissionRate: double.tryParse(v))))]));
  Widget _buildGarmentExtension(String cat) => ZenoCard(title: "$cat Settings", child: Row(children: [Expanded(child: _segmented(label: "PRICING METRIC", value: controller.product.pricingMetric, items: pricingMetrics, onChanged: (v) => controller.updateField(pricingMetric: v))), const SizedBox(width: 12), Expanded(child: _segmented(label: "TAT", value: controller.product.tat.toString(), items: turnAroundTimes, onChanged: (v) => controller.updateField(tat: int.tryParse(v ?? "0"))))]));
  Widget _buildRepairExtension(String cat) => ZenoCard(title: "Maintenance Details", child: Row(children: [Expanded(child: ZenoDropdown<String>(label: "Asset Type", value: controller.product.unit, items: repairAssetTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => controller.updateField(unit: v))), const SizedBox(width: 12), Expanded(child: ZenoTextField(label: "Diagnosis Charge", initialValue: controller.product.diagnosisCharge.toString(), onChanged: (v) => controller.updateField(diagnosisCharge: double.tryParse(v))))]));
  Widget _buildLogisticsExtension(String cat) => ZenoCard(title: "Service Parameters", child: Row(children: [Expanded(child: ZenoDropdown<String>(label: cat == "Courier Service" ? "Logistics Slab" : "Print Media", value: cat == "Courier Service" ? controller.product.logisticsSlab : controller.product.printMediaSpecs, items: (cat == "Courier Service" ? courierSlabs : printingMedia).map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(), onChanged: (v) => controller.updateField(logisticsSlab: v))), const SizedBox(width: 12), Expanded(child: ZenoTextField(label: cat == "Courier Service" ? "Volumetric Metric" : "Paper Weight", initialValue: cat == "Courier Service" ? controller.product.volumetricWeight : controller.product.paperWeight, onChanged: (v) => controller.updateField(volumetricWeight: v)))]));
  Widget _buildProfessionalExtension(String cat) => ZenoCard(title: "Appointment Info", child: Row(children: [Expanded(child: _segmented(label: "FORMAT", value: controller.product.consultationFormat, items: consultationFormats, onChanged: (v) => controller.updateField(consultationFormat: v))), const SizedBox(width: 12), Expanded(child: ZenoTextField(label: "Platform/Link", initialValue: controller.product.meetingPlatform, onChanged: (v) => controller.updateField(meetingPlatform: v)))]));
  Widget _buildFitnessExtension() => ZenoCard(title: "Membership Settings", child: Row(children: [Expanded(child: _segmented(label: "FREQUENCY", value: controller.product.membershipFrequency, items: membershipFrequencies, onChanged: (v) => controller.updateField(membershipFrequency: v))), const SizedBox(width: 12), Expanded(child: ZenoTextField(label: "Admission Fee", initialValue: controller.product.admissionFee.toString(), onChanged: (v) => controller.updateField(admissionFee: double.tryParse(v))))]));
}
