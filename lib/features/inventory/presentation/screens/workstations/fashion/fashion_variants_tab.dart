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

class FashionVariantsTab extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  final FashionCategoryConfig config;
  const FashionVariantsTab({super.key, required this.controller, required this.colors, required this.config});

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
              _buildSelectionHeader(context),
              const SizedBox(height: 8),
              Expanded(
                child: VariantMatrix(controller: controller, colors: colors),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Right Column: Media Upload Sidebar
        Container(
          width: 260,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colors.borderSubtle.withOpacity(0.5)),
          ),
          child: _buildMediaSidebar(),
        ),
      ],
    );
  }

  Widget _buildSelectionHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle.withOpacity(0.5)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SIZES ROW
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SIZES", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: colors.textPrimary, letterSpacing: 0.5)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      ...controller.getSizesForType(controller.sizeType).map((s) => _sizeChip(s, controller.selectedSizes.contains(s), () => controller.toggleSize(s))),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 110,
                child: ZenoDropdown<VariantSizeType>(
                  label: "SIZE SYSTEM",
                  value: controller.sizeType,
                  items: VariantSizeType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.toString().split('.').last.toUpperCase(), style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)))).toList(),
                  onChanged: (v) => controller.setSizeType(v ?? VariantSizeType.alpha),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // COLOURS ROW
          Text("COLOURS", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: colors.textPrimary, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...controller.availableColors.map((c) => _colorCircle(c)),
              const SizedBox(width: 8),
              _addBtn("+ Add Colour", () => _showAddDialog(context, "Colour", (v, c) => controller.addCustomColor(v, c))),
              _manageBtn(controller.isColorManageMode ? "Done" : "Delete", controller.toggleColorManageMode),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sizeChip(String label, bool isSelected, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(4),
    child: Container(
      width: 54,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : colors.bgTier3.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle, width: isSelected ? 1.5 : 1),
      ),
      child: Stack(
        children: [
          Center(child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: isSelected ? colors.accentPrimary : colors.textSecondary))),
          if (isSelected)
            Positioned(
              top: 2, right: 2,
              child: Icon(Icons.check_circle_rounded, size: 12, color: colors.accentPrimary),
            ),
        ],
      ),
    ),
  );

  Widget _colorCircle(String colorName) {
    final isSelected = controller.selectedColors.contains(colorName);
    final colorValue = controller.getColorValue(colorName);
    final bool canDelete = controller.isColorManageMode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () => controller.toggleColor(colorName),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colorValue,
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? colors.accentPrimary : Colors.grey.shade200, width: isSelected ? 2 : 1),
                  boxShadow: isSelected ? [BoxShadow(color: colors.accentPrimary.withOpacity(0.2), blurRadius: 4, spreadRadius: 1)] : null,
                ),
                child: isSelected ? const Icon(Icons.check, size: 18, color: Colors.white) : (colorName.toLowerCase() == 'white' ? Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300))) : null),
              ),
            ),
            if (canDelete)
              Positioned(
                top: -10,
                right: -10,
                child: TweenAnimationBuilder<double>(
                  tween: ConstantTween<double>(1.0),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
                  child: InkWell(
                    onTap: () => controller.removeCustomColor(colorName),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]),
                      child: Icon(Icons.cancel, size: 16, color: colors.statusDanger),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(colorName, style: TextStyle(fontSize: 9, fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600, color: colors.textSecondary)),
      ],
    );
  }

  Widget _buildMediaSidebar() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text("VARIANT IMAGE UPLOAD", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: colors.textPrimary)),
              const SizedBox(width: 4),
              Icon(Icons.help_outline_rounded, size: 10, color: colors.textDisabled),
            ],
          ),
          const SizedBox(height: 10),
          Text("SELECT COLOUR", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: colors.textSecondary, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: controller.availableColors.map((c) => _smallColorDot(c)).toList(),
          ),
          const SizedBox(height: 12),
          Text("SELECT SIZE", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: colors.textSecondary, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: ["S", "M", "L", "XL", "XXL", "XXXL"].map((s) => _smallSizeChip(s)).toList(),
          ),
          const SizedBox(height: 16),
          Text("PREVIEW", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: colors.textSecondary)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Black - S", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textPrimary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(color: colors.accentPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text("Primary", style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: colors.accentPrimary)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.bgTier3.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: _dashedBorder(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 24, color: colors.textDisabled.withOpacity(0.5)),
                  const SizedBox(height: 4),
                  Text("Upload Image", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: colors.textPrimary)),
                  const SizedBox(height: 2),
                  Text("JPG, PNG up to 5MB", style: TextStyle(fontSize: 7, color: colors.textDisabled)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text("ADDITIONAL IMAGES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: colors.textSecondary)),
          const SizedBox(height: 6),
          Row(
            children: [
              ...List.generate(3, (i) => _emptyImageSlot()),
              const Spacer(),
              Icon(Icons.chevron_right_rounded, color: colors.textPrimary, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: colors.accentPrimary.withOpacity(0.05), borderRadius: BorderRadius.circular(6)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, size: 12, color: colors.accentPrimary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    "Used in POS & eCommerce.",
                    style: TextStyle(fontSize: 8, color: colors.textPrimary.withOpacity(0.8), height: 1.2, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallColorDot(String colorName) {
    final isSelected = controller.activeMediaColor == colorName;
    final colorValue = controller.getColorValue(colorName);
    return InkWell(
      onTap: () => controller.setActiveMediaColor(colorName),
      child: Container(
        width: 24, height: 24,
        padding: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: colors.accentPrimary, width: 1.5) : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colorValue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _smallSizeChip(String label) {
    bool isSelected = label == "S"; // Placeholder for active selection
    return Container(
      width: 34, height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? colors.accentPrimary : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isSelected ? colors.accentPrimary : colors.borderSubtle),
      ),
      child: Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: isSelected ? Colors.white : colors.textSecondary)),
    );
  }

  Widget _emptyImageSlot() => Container(
    width: 40, height: 40,
    margin: const EdgeInsets.only(right: 8),
    child: _dashedBorder(
      color: colors.borderSubtle,
      radius: 4,
      child: Center(child: Icon(Icons.add, size: 14, color: colors.textDisabled)),
    ),
  );

  Widget _dashedBorder({required Widget child, Color? color, double radius = 8}) {
    return CustomPaint(
      painter: DashPainter(color: color ?? colors.accentPrimary.withOpacity(0.4), radius: radius),
      child: child,
    );
  }

  Widget _addBtn(String label, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add, size: 12, color: Colors.blueGrey),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ],
      ),
    ),
  );

  Widget _manageBtn(String label, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: controller.isColorManageMode ? colors.statusDanger.withOpacity(0.1) : colors.bgTier3,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: controller.isColorManageMode ? colors.statusDanger : colors.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(controller.isColorManageMode ? Icons.check : Icons.remove_circle_outline, size: 12, color: controller.isColorManageMode ? colors.statusDanger : Colors.blueGrey),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: controller.isColorManageMode ? colors.statusDanger : Colors.blueGrey)),
        ],
      ),
    ),
  );

  void _showAddDialog(BuildContext context, String type, Function(String, Color?) onAdd) {
    final textController = TextEditingController();
    Color? selectedPaletteColor = const Color(0xFF6495ED); // Default starting palette color
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
                            border: Border.all(color: isPicked ? colors.accentPrimary : Colors.grey.shade300, width: isPicked ? 3 : 1),
                            boxShadow: isPicked ? [BoxShadow(color: colors.accentPrimary.withOpacity(0.3), blurRadius: 6)] : null,
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
              child: Text("CANCEL", style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.bold, fontSize: 12))
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  onAdd(textController.text, selectedPaletteColor);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accentPrimary, 
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
