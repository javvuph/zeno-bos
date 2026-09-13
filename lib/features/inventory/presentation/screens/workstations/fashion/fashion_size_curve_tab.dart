import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../controllers/product_studio_controller.dart';

class FashionSizeCurveTab extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const FashionSizeCurveTab({super.key, required this.controller, required this.colors});

  @override
  State<FashionSizeCurveTab> createState() => _FashionSizeCurveTabState();
}

class _FashionSizeCurveTabState extends State<FashionSizeCurveTab> {
  Map<String, double> sizeCurve = {};
  Map<String, double> colorCurve = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurves();
  }

  Future<void> _loadCurves() async {
    final sc = await widget.controller.analytics.calculateSizeCurve(widget.controller.product.id);
    final cc = await widget.controller.analytics.calculateColorCurve(widget.controller.product.id);
    if (mounted) {
      setState(() {
        sizeCurve = sc;
        colorCurve = cc;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return Column(children: [
      ZenoCard(
        title: "📏 HISTORICAL SIZE CURVE",
        padding: const EdgeInsets.all(16),
        child: sizeCurve.isEmpty 
          ? const Center(child: Text("INSUFFICIENT SALES DATA", style: TextStyle(fontSize: 10, color: Colors.grey)))
          : Column(children: [
              ...sizeCurve.entries.map((e) => _buildCurveRow(e.key, (e.value * 100).toInt())),
              const SizedBox(height: 16),
              Row(children: [
                const Text("AUTO-ALLOCATE BY DEMAND", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                const Spacer(),
                Transform.scale(scale: 0.7, child: Switch(value: true, onChanged: (v) {}, activeThumbColor: widget.colors.accentPrimary)),
              ]),
            ]),
      ),
      const SizedBox(height: 12),
      ZenoCard(
        title: "🎨 HISTORICAL COLOR DEMAND",
        padding: const EdgeInsets.all(16),
        child: colorCurve.isEmpty
          ? const Center(child: Text("INSUFFICIENT SALES DATA", style: TextStyle(fontSize: 10, color: Colors.grey)))
          : Row(children: colorCurve.entries.map((e) => _metric(e.key.toUpperCase(), "${(e.value * 100).toInt()}%", widget.controller.getColorValue(e.key))).toList()),
      ),
    ]);
  }

  Widget _buildCurveRow(String size, int pct) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [Text(size, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)), const Spacer(), SizedBox(width: 60, child: ZenoTextField(label: null, initialValue: pct.toString(), textAlign: TextAlign.center)), const SizedBox(width: 8), const Text("%", style: TextStyle(fontSize: 10)), const SizedBox(width: 24), SizedBox(width: 100, child: LinearProgressIndicator(value: pct / 100, backgroundColor: Colors.grey.shade200, color: const Color(0xFF9333EA)))]));
  Widget _metric(String l, String v, Color c) => Expanded(child: Column(children: [Text(l, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey)), const SizedBox(height: 4), Text(v, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: c))]));
}
