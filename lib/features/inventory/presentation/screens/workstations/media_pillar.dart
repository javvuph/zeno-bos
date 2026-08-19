import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

class MediaPillar extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const MediaPillar({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _header("PRIMARY PRODUCT ASSET"), const SizedBox(height: 16),
      _mainAssetCard(), const SizedBox(height: 32),
      _header("PRODUCT GALLERY"), const SizedBox(height: 16),
      _galleryGrid(),
    ]);
  }

  Widget _header(String t) => Text(t, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textDisabled, letterSpacing: 1));

  Widget _mainAssetCard() {
    final img = controller.product.primaryImageUrl;
    return Container(
      width: double.infinity, height: 240,
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(16), border: Border.all(color: colors.borderSubtle)),
      child: Stack(children: [
        if (img != null) ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(img, width: double.infinity, height: 240, fit: BoxFit.cover))
        else Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.add_a_photo_outlined, size: 48, color: colors.textDisabled), const SizedBox(height: 12), Text("NO PRIMARY IMAGE", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: colors.textDisabled))])),
        Positioned(bottom: 16, right: 16, child: ZenoButton(label: img != null ? "REPLACE" : "UPLOAD", icon: Icons.upload_rounded, onPressed: controller.pickPrimaryImage)),
      ]),
    );
  }

  Widget _galleryGrid() {
    final urls = controller.product.galleryUrls;
    return Wrap(spacing: 12, runSpacing: 12, children: [
      ...urls.asMap().entries.map((e) => _galleryItem(e.key, e.value)),
      if (urls.length < 10) _addGalleryItem(),
    ]);
  }

  Widget _galleryItem(int i, String url) {
    return Container(
      width: 100, height: 100,
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)),
      child: Stack(children: [
        ClipRRect(borderRadius: BorderRadius.circular(11), child: Image.network(url, fit: BoxFit.cover, width: 100, height: 100)),
        Positioned(top: 4, right: 4, child: InkWell(onTap: () => controller.removeGalleryImage(i), child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, size: 14, color: Colors.white)))),
      ]),
    );
  }

  Widget _addGalleryItem() {
    return InkWell(onTap: controller.addToGallery, child: Container(width: 100, height: 100, decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle, style: BorderStyle.solid)), child: Center(child: Icon(Icons.add_rounded, color: colors.textDisabled, size: 24))));
  }
}
