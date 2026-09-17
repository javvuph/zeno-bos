import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_image_widget.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class MediaPillar extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const MediaPillar({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _header("PRIMARY PRODUCT ASSET"), const SizedBox(height: 16),
        _mainAssetCard(), const SizedBox(height: 32),
        _header("PRODUCT GALLERY"), const SizedBox(height: 16),
        _galleryGrid(),
      ]),
    );
  }

  Widget _header(String t) => Text(t, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textDisabled, letterSpacing: 1));

  Widget _mainAssetCard() {
    final img = controller.product.primaryImageUrl;
    return Container(
      width: double.infinity, height: 240,
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(16), border: Border.all(color: colors.borderSubtle)),
      child: Stack(children: [
        if (img.isNotEmpty) ClipRRect(borderRadius: BorderRadius.circular(15), child: ZenoImageWidget(url: img, width: double.infinity, height: 240, fit: BoxFit.cover))
        else Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.add_a_photo_outlined, size: 48, color: colors.textDisabled), const SizedBox(height: 12), Text("NO PRIMARY IMAGE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textDisabled))])),
        Positioned(bottom: 16, right: 16, child: ZenoButton(label: img.isNotEmpty ? "REPLACE" : "UPLOAD", icon: Icons.upload_rounded, onPressed: controller.pickPrimaryImage)),
      ]),
    );
  }

  Widget _galleryGrid() {
    final urls = controller.product.galleryUrls;
    const int defaultSlotCount = 3;
    final int totalDisplaySlots = urls.length > defaultSlotCount ? urls.length : defaultSlotCount;

    List<Widget> items = [];

    for (int i = 0; i < totalDisplaySlots; i++) {
      if (i < urls.length) {
        items.add(_galleryItem(i, urls[i]));
      } else {
        items.add(_emptySlotItem(i + 1));
      }
    }

    items.add(_addGalleryItem());

    return Wrap(spacing: 12, runSpacing: 12, children: items);
  }

  Widget _galleryItem(int i, String url) {
    return Container(
      width: 100, height: 100,
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)),
      child: Stack(children: [
        ClipRRect(borderRadius: BorderRadius.circular(11), child: ZenoImageWidget(url: url, fit: BoxFit.cover, width: 100, height: 100)),
        Positioned(top: 4, right: 4, child: InkWell(onTap: () => controller.removeGalleryImage(i), child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, size: 14, color: Colors.white)))),
      ]),
    );
  }

  Widget _emptySlotItem(int slotNum) {
    return InkWell(
      onTap: controller.addToGallery,
      child: Container(
        width: 100, height: 100,
        decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined, color: colors.textDisabled, size: 24),
            const SizedBox(height: 4),
            Text("Slot $slotNum", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: colors.textDisabled)),
          ],
        ),
      ),
    );
  }

  Widget _addGalleryItem() {
    return InkWell(
      onTap: controller.addToGallery,
      child: Container(
        width: 100, height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFFEEF2FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF818CF8)),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_rounded, color: Color(0xFF6366F1), size: 28),
            SizedBox(height: 4),
            Text("Add More", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
          ],
        ),
      ),
    );
  }
}
