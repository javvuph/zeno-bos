import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class SalesPipelineScreen extends StatelessWidget {
  const SalesPipelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Column(
      children: [
        ZenoHeader(
          title: "Sales Pipeline & Deals".toUpperCase(),
          subtitle:
              "VISUALIZE SALES VELOCITY, DEAL STAGES, AND PROJECTED REVENUE CONVERSION.",
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PipelineColumn(
                    title: "DISCOVERY",
                    count: 12,
                    value: "45K",
                    color: Colors.blue,
                    colors: colors),
                _PipelineColumn(
                    title: "QUALIFIED",
                    count: 8,
                    value: "120K",
                    color: Colors.purple,
                    colors: colors),
                _PipelineColumn(
                    title: "PROPOSAL",
                    count: 5,
                    value: "85K",
                    color: Colors.orange,
                    colors: colors),
                _PipelineColumn(
                    title: "NEGOTIATION",
                    count: 3,
                    value: "210K",
                    color: Colors.amber,
                    colors: colors),
                _PipelineColumn(
                    title: "CLOSED WON",
                    count: 42,
                    value: "1.2M",
                    color: Colors.green,
                    colors: colors),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PipelineColumn extends StatelessWidget {
  final String title;
  final int count;
  final String value;
  final Color color;
  final ZenoSemanticColors colors;

  const _PipelineColumn(
      {required this.title,
      required this.count,
      required this.value,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colors.bgTier2,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(bottom: BorderSide(color: color, width: 3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 1)),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(count.toString(),
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 10)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: colors.bgTier3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("STAGED VALUE",
                    style: TextStyle(fontSize: 9, color: Colors.grey)),
                Text("\$$value",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => _DealCard(colors: colors),
            ),
          ),
        ],
      ),
    );
  }
}

class _DealCard extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _DealCard({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ZenoCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enterprise Suite License",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const SizedBox(height: 4),
            Text("Acme Corporation",
                style: TextStyle(color: colors.textSecondary, fontSize: 10)),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("\$25,000",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.green,
                        fontSize: 11)),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 10, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("12d",
                        style: TextStyle(
                            color: colors.textSecondary, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
