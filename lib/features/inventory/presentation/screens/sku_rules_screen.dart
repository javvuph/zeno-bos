import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class SkuRulesScreen extends StatelessWidget {
  const SkuRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ZenoHeader(
          title: "SKU Generation Rules",
          subtitle:
              "Automate SKU creation based on product attributes and patterns.",
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    ZenoCard(
                      title: "ACTIVE PATTERN",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: ZenoTheme.background,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: ZenoTheme.border)),
                            child: const Row(
                              children: [
                                Text("{CAT}",
                                    style: TextStyle(
                                        color: ZenoTheme.accent,
                                        fontWeight: FontWeight.bold)),
                                Text("-",
                                    style: TextStyle(
                                        color: ZenoTheme.textSecondary)),
                                Text("{BRAND}",
                                    style: TextStyle(
                                        color: ZenoTheme.neonCyan,
                                        fontWeight: FontWeight.bold)),
                                Text("-",
                                    style: TextStyle(
                                        color: ZenoTheme.textSecondary)),
                                Text("{ATTR_COLOR}",
                                    style: TextStyle(
                                        color: ZenoTheme.neonGreen,
                                        fontWeight: FontWeight.bold)),
                                Text("-",
                                    style: TextStyle(
                                        color: ZenoTheme.textSecondary)),
                                Text("{SEQ}",
                                    style: TextStyle(
                                        color: ZenoTheme.warning,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text("Preview: PHN-APL-BLK-001",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ZenoTheme.textSecondary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const ZenoCard(
                      title: "SEQUENCE SETTINGS",
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text("Starting Number")),
                              SizedBox(width: 24),
                              Expanded(
                                  child: Text("001",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                          Divider(height: 32),
                          Row(
                            children: [
                              Expanded(child: Text("Padding Length")),
                              SizedBox(width: 24),
                              Expanded(
                                  child: Text("3",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
