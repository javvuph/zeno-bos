// @LOCKED: VERSION_CLOTHING_V1
// DO NOT MODIFY THIS FILE WITHOUT EXPLICIT PERMISSION FROM THE USER.
// THIS VERSION CONTAINS THE FINALIZED HIGH-DENSITY CLOTHING POS UI.
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVariantAttributesCard(context),
                const SizedBox(height: 8),
                VariantMatrix(controller: controller, colors: colors),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
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
    final availableColors = controller.availableColors;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Title & SIZE SYSTEM
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Variant Attributes',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
              ),
              Row(
                children: [
                  const Text('SIZE SYSTEM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                  const SizedBox(width: 4),
                  const Icon(Icons.info_outline, size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Container(
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<VariantSizeType>(
                        value: controller.sizeType,
                        items: VariantSizeType.values.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString().split('.').last.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        )).toList(),
                        onChanged: (v) => setState(() => controller.setSizeType(v ?? VariantSizeType.alpha)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // SIZES ROW (sizes label + size chips + add size)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 50,
                child: Text('sizes', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
              ),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...availableSizes.map((size) {
                      final isSelected = controller.selectedSizes.contains(size);
                      return SizedBox(
                        width: 42,
                        child: InkWell(
                          onTap: () => setState(() => controller.toggleSize(size)),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 32,
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
                                      fontSize: 11,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                      color: isSelected ? const Color(0xFF3B66F5) : const Color(0xFF1E293B),
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  const Positioned(
                                    top: 1,
                                    right: 1,
                                    child: Icon(Icons.check_circle, size: 10, color: Color(0xFF3B66F5)),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    OutlinedButton.icon(
                      onPressed: () => _showAddDialog(context, "Size", (v, _) => controller.addCustomSize(v)),
                      icon: const Icon(Icons.add, size: 12, color: Color(0xFF3B66F5)),
                      label: const Text('Add Size', style: TextStyle(color: Color(0xFF3B66F5), fontSize: 10)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1), style: BorderStyle.solid),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // COLOURS ROW (Colours label + color swatches + add colour)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 50,
                child: Text('Colours', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
              ),
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...availableColors.map((cName) {
                      final isSelected = controller.selectedColors.contains(cName);
                      final colorVal = controller.getColorValue(cName);
                      return SizedBox(
                        width: 42,
                        child: InkWell(
                          onTap: () => setState(() => controller.toggleColor(cName)),
                          borderRadius: BorderRadius.circular(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colorVal,
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF3B66F5) : const Color(0xFFCBD5E1),
                                    width: isSelected ? 2.0 : 1,
                                  ),
                                ),
                                child: isSelected
                                    ? const Center(
                                        child: Icon(Icons.check, size: 14, color: Colors.white),
                                      )
                                    : (cName.toLowerCase() == 'white' ? Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300))) : null),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                cName,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    OutlinedButton.icon(
                      onPressed: () => _showAddDialog(context, "Colour", (v, col) => controller.addCustomColor(v, col)),
                      icon: const Icon(Icons.add, size: 12, color: Color(0xFF3B66F5)),
                      label: const Text('Add colour', style: TextStyle(color: Color(0xFF3B66F5), fontSize: 10)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFCBD5E1)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      ),
                    ),
                  ],
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
    final activeAssets = controller.getColorMedia(activeColor);
    final previewAssets = activeAssets.take(4).toList();
    
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Text('Colour Media Library', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
          const SizedBox(height: 2),
          const Text('Upload and manage images for this colourway', style: TextStyle(fontSize: 11, color: Color(0xFF64748B))),
          const SizedBox(height: 4),

          // Horizontal colour switcher row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.availableColors.map((cName) {
                final isCurrent = cName == activeColor;
                final colorVal = controller.getColorValue(cName);
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: InkWell(
                    onTap: () => setState(() => controller.setActiveMediaColor(cName)),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: isCurrent ? const Color(0xFF3B66F5) : Colors.transparent, width: 1.5),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 24, height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorVal,
                              border: Border.all(color: cName.toLowerCase() == 'white' ? Colors.grey.shade300 : Colors.black12),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(cName, style: TextStyle(fontSize: 8, color: isCurrent ? const Color(0xFF1E293B) : const Color(0xFF64748B), fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 4),

          // Active Colour header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 14, height: 14,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: controller.getColorValue(activeColor)),
                  ),
                  const SizedBox(width: 6),
                  Text(activeColor, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                ],
              ),
              Text('${activeAssets.length} photos', style: const TextStyle(fontSize: 11, color: Color(0xFF3B66F5), fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 2),
          Text('These images apply automatically to all $activeColor sizes (${controller.selectedSizes.join(", ")}).', style: const TextStyle(fontSize: 10, color: Color(0xFF64748B))),
          const SizedBox(height: 4),

          // Angle Grid (4 preview tiles)
          Row(
            children: [
              _buildImageThumb('Front View', true, previewAssets.isNotEmpty ? previewAssets[0].url : null),
              const SizedBox(width: 8),
              _buildImageThumb('Back View', false, previewAssets.length > 1 ? previewAssets[1].url : null),
              const SizedBox(width: 8),
              _buildImageThumb('Detail', false, previewAssets.length > 2 ? previewAssets[2].url : null),
              const SizedBox(width: 8),
              _buildImageThumb('Side View', false, previewAssets.length > 3 ? previewAssets[3].url : null),
            ],
          ),
          const SizedBox(height: 8),

          // Upload images dropzone
          InkWell(
            onTap: () async {
              await controller.uploadColorMedia(activeColor);
              if (mounted) {
                setState(() {});
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
              ),
              child: const Column(
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 20, color: Color(0xFF64748B)),
                  SizedBox(height: 2),
                  Text('Upload Images', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  SizedBox(height: 1),
                  Text('JPG, PNG, WebP up to 5MB each', style: TextStyle(fontSize: 9, color: Color(0xFF64748B))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Additional Images Row
          Row(
            children: [
              ...List.generate(3, (i) => _emptyImageSlot(i < activeAssets.length ? activeAssets[i].url : null)),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF1E293B), size: 18),
            ],
          ),
          const SizedBox(height: 6),

          // Bottom info pill
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 14, color: Color(0xFF3B66F5)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '1 colour set will be shared across ${controller.selectedSizes.length} sizes: ${controller.selectedSizes.join(" • ")}',
                    style: const TextStyle(fontSize: 10, color: Color(0xFF1E293B)),
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

  Widget _buildImageThumb(String label, bool isPrimary, String? imagePath) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 58,
            decoration: BoxDecoration(
              color: imagePath == null ? Colors.blue.shade900 : null,
              borderRadius: BorderRadius.circular(8),
              image: imagePath != null ? DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover) : null,
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

  Widget _emptyImageSlot(String? imagePath) => Container(
    width: 44,
    height: 44,
    margin: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: const Color(0xFFCBD5E1)),
      image: imagePath != null ? DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover) : null,
    ),
    child: imagePath == null ? const Center(child: Icon(Icons.add, size: 16, color: Color(0xFF64748B))) : null,
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
