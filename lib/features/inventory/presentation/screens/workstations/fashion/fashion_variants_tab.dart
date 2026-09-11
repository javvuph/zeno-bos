// @LOCKED: VERSION_CLOTHING_V1
// DO NOT MODIFY THIS FILE WITHOUT EXPLICIT PERMISSION FROM THE USER.
// THIS VERSION CONTAINS THE FINALIZED HIGH-DENSITY CLOTHING POS UI.
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/fashion_config.dart';
import '../variant_matrix.dart';

class FashionVariantsTab extends StatefulWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final FashionCategoryConfig config;
  const FashionVariantsTab({super.key, required this.controller, required this.colors, required this.config});

  @override
  State<FashionVariantsTab> createState() => _FashionVariantsTabState();
}

class _FashionVariantsTabState extends State<FashionVariantsTab> {
  ProductStudioController get controller => widget.controller;
  ZenoSemanticColors get colors => widget.colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Variant Generation & Table
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVariantAttributesCard(context),
              const SizedBox(height: 16),
              Expanded(
                child: VariantMatrix(controller: controller, colors: colors),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Right Column: Colour Media Library Inspector Card
        Expanded(
          flex: 3,
          child: _buildColourMediaLibraryCard(),
        ),
      ],
    );
  }

  Widget _buildVariantAttributesCard(BuildContext context) {
    final availableSizes = controller.getSizesForType(controller.sizeType);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Variant Attributes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 4),
          const Text(
            'Define sizes and colours to automatically create product variants',
            style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 16),

          // SIZES ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('SIZES', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
              Row(
                children: [
                  const Text('SIZE SYSTEM', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  const SizedBox(width: 4),
                  const Icon(Icons.info_outline, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<VariantSizeType>(
                        value: controller.sizeType,
                        items: VariantSizeType.values.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString().split('.').last.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        )).toList(),
                        onChanged: (v) => setState(() => controller.setSizeType(v ?? VariantSizeType.alpha)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Size Chips row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...availableSizes.map((size) {
                final isSelected = controller.selectedSizes.contains(size);
                return InkWell(
                  onTap: () => setState(() => controller.toggleSize(size)),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 50,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF3B66F5) : const Color(0xFFE2E8F0),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? const Color(0xFF3B66F5) : const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                        if (isSelected)
                          const Positioned(
                            top: 2,
                            right: 2,
                            child: Icon(Icons.check_circle, size: 12, color: Color(0xFF3B66F5)),
                          ),
                      ],
                    ),
                  ),
                );
              }),
              // + Add Size Button
              OutlinedButton.icon(
                onPressed: () => _showAddDialog(context, "Size", (v, _) => controller.addCustomSize(v)),
                icon: const Icon(Icons.add, size: 14, color: Color(0xFF3B66F5)),
                label: const Text('Add Size', style: TextStyle(color: Color(0xFF3B66F5), fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1), style: BorderStyle.solid),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          const Text('COLOURS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
          const SizedBox(height: 10),

          // Color swatches row
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 14,
                  runSpacing: 10,
                  children: controller.availableColors.map((cName) {
                    final isSelected = controller.selectedColors.contains(cName);
                    final colorVal = controller.getColorValue(cName);
                    return InkWell(
                      onTap: () => setState(() => controller.toggleColor(cName)),
                      child: Column(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorVal,
                              border: Border.all(
                                color: isSelected ? const Color(0xFF3B66F5) : const Color(0xFFCBD5E1),
                                width: isSelected ? 2.5 : 1,
                              ),
                            ),
                            child: isSelected
                                ? const Center(
                                    child: Icon(Icons.check, size: 18, color: Colors.white),
                                  )
                                : (cName.toLowerCase() == 'white' ? Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300))) : null),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            cName,
                            style: TextStyle(
                              fontSize: 11,
                              color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 14),
              // + Add Colour Button
              OutlinedButton.icon(
                onPressed: () => _showAddDialog(context, "Colour", (v, col) => controller.addCustomColor(v, col)),
                icon: const Icon(Icons.add, size: 14, color: Color(0xFF3B66F5)),
                label: const Text('Add Colour', style: TextStyle(color: Color(0xFF3B66F5), fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () => setState(() => controller.toggleColorManageMode()),
                icon: Icon(controller.isColorManageMode ? Icons.check : Icons.delete_outline, size: 14, color: controller.isColorManageMode ? colors.statusDanger : const Color(0xFF64748B)),
                label: Text(controller.isColorManageMode ? 'Done' : 'Delete', style: TextStyle(color: controller.isColorManageMode ? colors.statusDanger : const Color(0xFF64748B), fontSize: 12)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: controller.isColorManageMode ? colors.statusDanger : const Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // RIGHT PANEL: COLOUR MEDIA LIBRARY
  // ==========================================
  Widget _buildColourMediaLibraryCard() {
    final activeColor = controller.activeMediaColor ?? (controller.selectedColors.isNotEmpty ? controller.selectedColors.first : "Blue");
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Text('Colour Media Library', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
          const SizedBox(height: 2),
          const Text('Upload and manage images for this colourway', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
          const SizedBox(height: 14),

          // Horizontal colour switcher row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.availableColors.map((cName) {
                final isCurrent = cName == activeColor;
                final colorVal = controller.getColorValue(cName);
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => setState(() => controller.setActiveMediaColor(cName)),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isCurrent ? const Color(0xFF3B66F5) : Colors.transparent, width: 1.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 28, height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorVal,
                              border: Border.all(color: cName.toLowerCase() == 'white' ? Colors.grey.shade300 : Colors.black12),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(cName, style: TextStyle(fontSize: 10, color: isCurrent ? const Color(0xFF1E293B) : const Color(0xFF64748B), fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Active Colour header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: controller.getColorValue(activeColor)),
                  ),
                  const SizedBox(width: 8),
                  Text(activeColor, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                ],
              ),
              const Text('4 photos', style: TextStyle(fontSize: 12, color: Color(0xFF3B66F5), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 4),
          Text('These images apply automatically to all $activeColor sizes (${controller.selectedSizes.join(", ")}).', style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          const SizedBox(height: 14),

          // Angle Grid (4 preview tiles)
          Row(
            children: [
              _buildImageThumb('Front View', true),
              const SizedBox(width: 8),
              _buildImageThumb('Back View', false),
              const SizedBox(width: 8),
              _buildImageThumb('Detail', false),
              const SizedBox(width: 8),
              _buildImageThumb('Side View', false),
            ],
          ),
          const SizedBox(height: 16),

          // Upload images dropzone
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
            ),
            child: const Column(
              children: [
                Icon(Icons.cloud_upload_outlined, size: 30, color: Color(0xFF64748B)),
                SizedBox(height: 6),
                Text('Upload Images', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                SizedBox(height: 2),
                Text('JPG, PNG, WebP up to 5MB each', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Additional Images Row
          Row(
            children: [
              ...List.generate(3, (i) => _emptyImageSlot()),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF1E293B), size: 18),
            ],
          ),
          const SizedBox(height: 16),

          // Bottom info pill
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Color(0xFF3B66F5)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '1 colour set will be shared across ${controller.selectedSizes.length} sizes: ${controller.selectedSizes.join(" • ")}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF1E293B)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildImageThumb(String label, bool isPrimary) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                if (isPrimary)
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B66F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Primary', style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                const Positioned(
                  top: 4,
                  right: 4,
                  child: Icon(Icons.more_vert, size: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _emptyImageSlot() => Container(
    width: 44, height: 44,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFCBD5E1)),
    ),
    child: const Center(child: Icon(Icons.add, size: 16, color: Color(0xFF64748B))),
  );

  void _showAddDialog(BuildContext context, String type, Function(String, Color?) onAdd) {
    final textController = TextEditingController();
    Color? selectedPaletteColor = const Color(0xFF6495ED);
    final List<Color> palette = [
      Colors.black, const Color(0xFF000080), Colors.white, Colors.red, Colors.blue, Colors.green,
      Colors.yellow, Colors.orange, Colors.purple, Colors.pink, Colors.brown, Colors.grey,
      Colors.teal, Colors.cyan, Colors.lime, Colors.indigo, Colors.amber, Colors.deepOrange,
      const Color(0xFF6495ED), const Color(0xFFFF69B4), const Color(0xFF8B4513), const Color(0xFF556B2F)
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Add Custom $type", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: "$type Name",
                  hintText: "e.g. Sky Blue",
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                autofocus: true,
              ),
              if (type == "Colour") ...[
                const SizedBox(height: 24),
                const Text("SELECT COLOR PALETTE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 0.5)),
                const SizedBox(height: 12),
                SizedBox(
                  width: 320,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: palette.map((c) {
                      bool isPicked = selectedPaletteColor?.value == c.value;
                      return InkWell(
                        onTap: () => setState(() => selectedPaletteColor = c),
                        child: Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(color: isPicked ? const Color(0xFF3B66F5) : Colors.grey.shade300, width: isPicked ? 3 : 1),
                            boxShadow: isPicked ? [BoxShadow(color: const Color(0xFF3B66F5).withOpacity(0.3), blurRadius: 6)] : null,
                          ),
                          child: isPicked ? const Icon(Icons.check, size: 16, color: Colors.white) : (c == Colors.white ? Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300))) : null),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("CANCEL", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 12))
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  onAdd(textController.text, selectedPaletteColor);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B66F5), 
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text("ADD COLOUR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  final Color color;
  final double radius;
  DashPainter({required this.color, this.radius = 8});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    const double dashWidth = 4;
    const double dashSpace = 4;
    final path = Path();
    path.addRRect(RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(radius)));
    
    final dashPath = Path();
    for (final pathMetric in path.computeMetrics()) {
      double distance = 0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
