import 'package:flutter/material.dart';
import '../../../controllers/product_studio_controller.dart';
import '../aurora_field_renderer.dart';
import '../widgets/aurora_card.dart';

class Tab3PriceTax extends StatelessWidget {
  final ProductStudioController controller;
  const Tab3PriceTax({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final allFields = controller.getTab3Fields();
    
    // Group into logical rows but allow fluid packing
    final pricing = allFields.where((f) => f.contains('Price') || f == 'mrp' || f == 'costPrice' || f.contains('discount')).toList();
    final tax = allFields.where((f) => !pricing.contains(f)).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          AuroraCard(
            title: "Pricing & Margins",
            subtitle: "Commercial valuation and discount policies",
            icon: Icons.payments_outlined,
            accentColor: Colors.green,
            child: AuroraFieldRenderer(controller: controller, fieldIds: pricing),
          ),
          AuroraCard(
            title: "Taxation & Statutory",
            subtitle: "Government compliance and regional rates",
            icon: Icons.receipt_long_outlined,
            accentColor: Colors.lightBlue,
            child: AuroraFieldRenderer(controller: controller, fieldIds: tax),
          ),
        ],
      ),
    );
  }
}
