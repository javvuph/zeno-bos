import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class RetailOmnichannelTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const RetailOmnichannelTab({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    return Column(children: [
      ZenoCard(
        title: "🌐 OMNICHANNEL AVAILABILITY",
        padding: const EdgeInsets.all(16),
        child: Wrap(spacing: 24, runSpacing: 16, children: [
          _toggle("AVAILABLE IN-STORE", true, (v) {}),
          _toggle("AVAILABLE ONLINE (B2C)", p.visibility.contains("Online"), (v) => controller.updateField(visibility: v ? "All Channels" : "In-Store Only")),
          _toggle("CLICK & COLLECT ELIGIBLE", true, (v) {}),
          _toggle("SHIP-FROM-STORE ENABLED", true, (v) {}),
          _toggle("MARKETPLACE SYNC (AMAZON/NOON)", true, (v) {}),
        ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "🚀 ONLINE MERCHANDISING",
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(children: [
            Expanded(child: ZenoTextField(label: "URL SLUG", initialValue: p.urlSlug, onChanged: (v) => controller.updateField(urlSlug: v))),
            const SizedBox(width: 12),
            Expanded(child: ZenoTextField(label: "ONLINE PRODUCT TITLE", initialValue: p.marketingTitle, onChanged: (v) => controller.updateField(marketingTitle: v))),
          ]),
          const SizedBox(height: 16),
          ZenoTextField(label: "META DESCRIPTION (SEO)", initialValue: p.metaDescription, onChanged: (v) => controller.updateField(metaDescription: v), maxLines: 2),
        ]),
      ),
    ]);
  }

  Widget _toggle(String l, bool v, ValueChanged<bool> o) => Row(mainAxisSize: MainAxisSize.min, children: [Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)), Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: colors.accentPrimary))]);
}
