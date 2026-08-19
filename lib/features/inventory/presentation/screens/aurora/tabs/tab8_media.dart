import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class Tab8Media extends StatelessWidget {
  final ProductStudioController controller;
  const Tab8Media({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final p = controller.product;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "Visual Assets",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('primaryImageUrl'),
                        label: "Hero Image URL",
                        initialValue: p.primaryImageUrl,
                        onChanged: (v) => controller.updateField(primaryImageUrl: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('galleryUrls'),
                        label: "Gallery Images (Comma Separated URLs)",
                        initialValue: p.galleryUrls.join(", "),
                        onChanged: (v) => controller.updateField(galleryUrls: v.split(",").map((e) => e.trim()).where((e) => e.isNotEmpty).toList()),
                        maxLines: 2,
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ZenoCard(
                  title: "Hardware Integration",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('eslId'),
                        label: "Electronic Shelf Label (ESL) ID",
                        initialValue: p.eslId,
                        onChanged: (v) => controller.updateField(eslId: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('rfidTagId'),
                        label: "RFID Tag ID",
                        initialValue: p.rfidTagId,
                        onChanged: (v) => controller.updateField(rfidTagId: v),
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                ZenoCard(
                  title: "SEO & Web Optimization",
                  child: Column(
                    children: [
                      ZenoTextField(
                        key: const ValueKey('seoTitle'),
                        label: "SEO Title",
                        initialValue: p.seoTitle,
                        onChanged: (v) => controller.updateField(seoTitle: v),
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('metaDescription'),
                        label: "Meta Description",
                        initialValue: p.metaDescription,
                        onChanged: (v) => controller.updateField(metaDescription: v),
                        maxLines: 2,
                        width: ZenoFieldWidth.full,
                      ),
                      const SizedBox(height: 12),
                      ZenoTextField(
                        key: const ValueKey('urlSlug'),
                        label: "URL Slug",
                        initialValue: p.urlSlug,
                        onChanged: (v) => controller.updateField(urlSlug: v),
                        width: ZenoFieldWidth.full,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ZenoCard(
                  title: "🔐 AUDIT TRAIL",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAuditRow("Created By", p.auditLog['createdBy'] ?? "SYSTEM"),
                      _buildAuditRow("Created At", p.auditLog['createdAt'] ?? "2026-08-19 10:30"),
                      _buildAuditRow("Modified By", p.auditLog['modifiedBy'] ?? "ADMIN_102"),
                      _buildAuditRow("Modified At", p.auditLog['modifiedAt'] ?? "JUST NOW"),
                      _buildAuditRow("Revision", p.auditLog['version'] ?? "v3.5.0-ALPHA"),
                      const Divider(height: 16),
                      Text(
                        "CRYPTOGRAPHIC HASH: ${p.auditLog['hash'] ?? '0x7F4A...B2C9'}",
                        style: TextStyle(fontSize: 9, fontFamily: 'monospace', color: colors.textDisabled),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
