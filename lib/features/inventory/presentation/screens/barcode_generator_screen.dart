import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';

class BarcodeGeneratorScreen extends StatelessWidget {
  const BarcodeGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Column(
      children: [
        ZenoHeader(
          title: "Barcode & QR Generator".toUpperCase(),
          subtitle:
              "CREATE INDUSTRIAL-STANDARD LABELS FOR PRODUCTS, LOCATIONS, AND ASSETS.",
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "GENERATION SETTINGS",
                    child: Column(
                      children: [
                        ZenoDropdown<String>(
                          label: "Label Type",
                          items: const [
                            DropdownMenuItem(
                                value: "barcode",
                                child: Text("Linear Barcode (Code 128)")),
                            DropdownMenuItem(
                                value: "qr", child: Text("QR Code")),
                            DropdownMenuItem(
                                value: "datamatrix",
                                child: Text("Data Matrix")),
                          ],
                          value: "barcode",
                          onChanged: (v) {},
                        ),
                        const SizedBox(height: 24),
                        const ZenoTextField(
                            label: "Value / SKU", hint: "e.g. PROD-1001"),
                        const SizedBox(height: 24),
                        ZenoDropdown<String>(
                          label: "Print Template",
                          items: const [
                            DropdownMenuItem(
                                value: "standard", child: Text("Standard 4x6")),
                            DropdownMenuItem(
                                value: "small", child: Text("Small 2x1")),
                          ],
                          value: "standard",
                          onChanged: (v) {},
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.print, size: 18),
                            label: const Text("GENERATE & PRINT"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.accentPrimary,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "PREVIEW",
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Container(
                            width: 250,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: colors.borderSubtle)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.reorder,
                                    size: 60, color: Colors.black),
                                Text("PROD-1001",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text("READY TO PRINT TO 'ZEBRA-ZTC-GK420D'",
                              style:
                                  ZenoTypography.micro(colors.textSecondary)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
