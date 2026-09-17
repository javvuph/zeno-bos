import 'package:flutter/material.dart';
import 'zeno_image_widget.dart';

/// Unified e-commerce style image uploader: one primary slot + a dynamically
/// growing gallery grid + a trailing "add" slot. Used everywhere a product
/// image field is edited so upload/delete/set-primary behavior stays identical.
class ZenoImageGallery extends StatelessWidget {
  final String primaryUrl;
  final List<String> galleryUrls;
  final VoidCallback onPickPrimary;
  final VoidCallback onAddToGallery;
  final ValueChanged<int> onRemoveGalleryImage;
  final ValueChanged<int>? onSetGalleryAsPrimary;
  final VoidCallback? onDeletePrimary;
  final double slotSize;
  final int minGallerySlots;

  const ZenoImageGallery({
    super.key,
    required this.primaryUrl,
    required this.galleryUrls,
    required this.onPickPrimary,
    required this.onAddToGallery,
    required this.onRemoveGalleryImage,
    this.onSetGalleryAsPrimary,
    this.onDeletePrimary,
    this.slotSize = 92,
    this.minGallerySlots = 2,
  });

  @override
  Widget build(BuildContext context) {
    final int totalGallerySlots = galleryUrls.length >= minGallerySlots ? galleryUrls.length : minGallerySlots;

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _primarySlot(),
        for (int i = 0; i < totalGallerySlots; i++) _gallerySlot(i),
        _addSlot(),
      ],
    );
  }

  Widget _primarySlot() {
    final bool hasImage = primaryUrl.isNotEmpty;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: hasImage ? null : onPickPrimary,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: slotSize,
            height: slotSize,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: ZenoImageWidget(url: primaryUrl, fit: BoxFit.cover, width: slotSize, height: slotSize),
                  )
                : const Center(child: Icon(Icons.add_a_photo_outlined, size: 22, color: Color(0xFF6366F1))),
          ),
        ),
        Positioned(
          top: -6,
          left: 6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(6)),
            child: const Text("Primary", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white)),
          ),
        ),
        if (hasImage)
          Positioned(
            top: 2,
            right: 2,
            child: _slotMenuButton(
              onSetPrimary: null,
              onDelete: onDeletePrimary,
              onReplace: onPickPrimary,
            ),
          ),
      ],
    );
  }

  Widget _gallerySlot(int index) {
    final bool hasImage = index < galleryUrls.length;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: hasImage ? null : onAddToGallery,
          borderRadius: BorderRadius.circular(10),
          child: hasImage
              ? Container(
                  width: slotSize,
                  height: slotSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: ZenoImageWidget(url: galleryUrls[index], fit: BoxFit.cover, width: slotSize, height: slotSize),
                  ),
                )
              : CustomPaint(
                  painter: const _DashedBorderPainter(color: Color(0xFFCBD5E1), radius: 10),
                  child: SizedBox(
                    width: slotSize,
                    height: slotSize,
                    child: Center(
                      child: Text("+ Slot ${index + 2}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                    ),
                  ),
                ),
        ),
        if (hasImage)
          Positioned(
            top: 2,
            right: 2,
            child: _slotMenuButton(
              onSetPrimary: onSetGalleryAsPrimary == null ? null : () => onSetGalleryAsPrimary!(index),
              onDelete: () => onRemoveGalleryImage(index),
            ),
          ),
      ],
    );
  }

  Widget _addSlot() {
    return InkWell(
      onTap: onAddToGallery,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: slotSize,
        height: slotSize,
        decoration: BoxDecoration(
          color: const Color(0xFFEEF2FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF818CF8)),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined, size: 22, color: Color(0xFF6366F1)),
            SizedBox(height: 4),
            Text("+ Add", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF6366F1))),
          ],
        ),
      ),
    );
  }

  Widget _slotMenuButton({VoidCallback? onSetPrimary, VoidCallback? onDelete, VoidCallback? onReplace}) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      tooltip: "Photo options",
      onSelected: (value) {
        if (value == "primary") onSetPrimary?.call();
        if (value == "delete") onDelete?.call();
        if (value == "replace") onReplace?.call();
      },
      itemBuilder: (context) => [
        if (onSetPrimary != null)
          const PopupMenuItem(value: "primary", child: Text("Set as Primary", style: TextStyle(fontSize: 12))),
        if (onReplace != null)
          const PopupMenuItem(value: "replace", child: Text("Replace", style: TextStyle(fontSize: 12))),
        if (onDelete != null)
          const PopupMenuItem(value: "delete", child: Text("Delete", style: TextStyle(fontSize: 12))),
      ],
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
        child: const Icon(Icons.more_vert, size: 12, color: Colors.white),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  const _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius));
    final path = Path()..addRRect(rrect);

    const dashWidth = 4.0;
    const dashGap = 3.0;
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(metric.extractPath(distance, next.clamp(0, metric.length)), paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
