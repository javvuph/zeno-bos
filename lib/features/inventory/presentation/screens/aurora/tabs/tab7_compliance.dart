import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import '../aurora_field_renderer.dart';

class Tab7Compliance extends StatelessWidget {
  final ProductStudioController controller;
  const Tab7Compliance({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // 07 COMPLIANCE ΓÇö Tax + regulatory + expiry (ZERO-SCROLL)
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ROW 1: TAX
          ZenoCard(
            title: "≡ƒº╛ TAXATION",
            padding: const EdgeInsets.all(12),
            child: AuroraFieldRenderer(
              controller: controller,
              fieldIds: const [
                "taxStatus", "taxCode", "gstRate", "vatRate", "cessRate", "taxMode"
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // ROW 2: REGULATORY
          ZenoCard(
            title: "ΓÜû∩╕Å REGULATORY",
            padding: const EdgeInsets.all(12),
            child: AuroraFieldRenderer(
              controller: controller,
              fieldIds: const [
                "countryOfOrigin", "regulatoryId", "regulatoryType", "legalMetrologyDeclaration", "capEAS"
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BATCH / EXPIRY
              Expanded(
                flex: 2,
                child: ZenoCard(
                  title: "≡ƒºè BATCH / EXPIRY (IF APPLICABLE)",
                  padding: const EdgeInsets.all(12),
                  child: AuroraFieldRenderer(
                    controller: controller,
                    fieldIds: const [
                      "mfgDate", "expiryDate", "bestBeforeDate", "shelfLifeDays"
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // DOCUMENTS
              Expanded(
                flex: 1,
                child: ZenoCard(
                  title: "≡ƒôä DOCUMENTS",
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _buildUploadButton("Certificate"),
                      const SizedBox(height: 8),
                      _buildUploadButton("Regulatory Doc"),
                      const SizedBox(height: 8),
                      _buildUploadButton("Packer Declaration"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Center(child: Text("+ Upload $label", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
    );
  }
}
