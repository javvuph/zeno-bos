import 'package:flutter/material.dart';
import '../../../controllers/product_studio_controller.dart';
import '../aurora_field_renderer.dart';
import '../widgets/aurora_card.dart';

class Tab1IdentitySpecs extends StatelessWidget {
  final ProductStudioController controller;
  const Tab1IdentitySpecs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final coreFields = controller.getTab1CoreFields();
    final specFields = controller.getTab1SpecFields();

    // Reorder core fields according to Part 10 requirement:
    // (Name, Arabic, POS Name, Status) -> Description -> (Barcode, SKU, Brand, Dept) -> ...
    
    final row1 = coreFields.where((f) => ['title', 'arabicTitle'].contains(f)).toList();
    final row2 = coreFields.where((f) => f == 'description').toList();
    final row3 = coreFields.where((f) => ['posShortThermalName', 'status', 'barcode', 'sku'].contains(f)).toList();
    final row4 = coreFields.where((f) => ['brand', 'department', 'category', 'subDepartment'].contains(f)).toList();
    final row5 = coreFields.where((f) => ['returnPolicy', 'taxCode'].contains(f)).toList();
    
    final remainingCore = coreFields.where((f) => 
      !row1.contains(f) && !row2.contains(f) && !row3.contains(f) && !row4.contains(f) && !row5.contains(f)
    ).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuroraCard(
            title: "Product Identity & Specifications",
            subtitle: "Universal basics and profile-specific attributes",
            icon: Icons.badge_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuroraFieldRenderer(controller: controller, fieldIds: row1),
                if (row2.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  AuroraFieldRenderer(controller: controller, fieldIds: row2),
                ],
                if (row3.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  AuroraFieldRenderer(controller: controller, fieldIds: row3),
                ],
                if (row4.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  AuroraFieldRenderer(controller: controller, fieldIds: row4),
                ],
                if (row5.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  AuroraFieldRenderer(controller: controller, fieldIds: row5),
                ],
                if (remainingCore.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  AuroraFieldRenderer(controller: controller, fieldIds: remainingCore),
                ],
                if (specFields.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(height: 1, color: Color(0xFFE2E8F0)),
                  ),
                  const Text("Operational Specifications", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF64748B), letterSpacing: 0.5)),
                  const SizedBox(height: 16),
                  AuroraFieldRenderer(controller: controller, fieldIds: specFields),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
