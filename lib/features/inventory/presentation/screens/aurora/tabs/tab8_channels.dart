import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_image_gallery.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/product_studio_controller.dart';
import 'package:zeno/core/layouts/zeno_responsive_layout.dart';

class Tab8Channels extends StatefulWidget {
  final ProductStudioController controller;
  const Tab8Channels({super.key, required this.controller});

  @override
  State<Tab8Channels> createState() => _Tab8ChannelsState();
}

class _Tab8ChannelsState extends State<Tab8Channels> {
  @override
  Widget build(BuildContext context) {
    final p = widget.controller.product;
    final bType = p.businessType.toUpperCase();
    final scale = p.businessScale;
    final profile = widget.controller.activeProfile;
    final isClothingSmall = profile.toLowerCase() == "clothing" && bType == "FASHION" && scale == BusinessScale.small;
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final currentP = widget.controller.product;
        return ZenoResponsiveLayout(
          child: isClothingSmall 
            ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: _compactSection("PRODUCT IMAGES", colors, [
                    ZenoImageGallery(
                      primaryUrl: currentP.primaryImageUrl,
                      galleryUrls: currentP.galleryUrls,
                      onPickPrimary: widget.controller.pickPrimaryImage,
                      onDeletePrimary: widget.controller.deletePrimaryImage,
                      onAddToGallery: widget.controller.addToGallery,
                      onRemoveGalleryImage: widget.controller.removeGalleryImage,
                      onSetGalleryAsPrimary: widget.controller.setGalleryImageAsPrimary,
                      slotSize: 60,
                    ),
                  ]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      _compactSection("ONLINE PRODUCT INFORMATION", colors, [
                        ZenoTextField(label: "Marketing Title", initialValue: currentP.marketingTitle, onChanged: (v) => widget.controller.updateField(marketingTitle: v)),
                        const SizedBox(height: 8), 
                        ZenoTextField(label: "Online Description", initialValue: currentP.description, onChanged: (v) => widget.controller.updateField(description: v), maxLines: 2),
                      ]),
                      const SizedBox(height: 8), 
                      _compactSection("SEO", colors, [
                        Row(
                          children: [
                            Expanded(child: ZenoTextField(label: "URL Slug", initialValue: currentP.urlSlug, onChanged: (v) => widget.controller.updateField(urlSlug: v))),
                            const SizedBox(width: 8),
                            Expanded(child: ZenoTextField(label: "Search Keywords", initialValue: currentP.searchKeywords.join(", "), onChanged: (v) => widget.controller.updateField(searchKeywords: v.split(',').map((e)=>e.trim()).toList()))),
                          ],
                        ),
                        const SizedBox(height: 8), 
                        ZenoTextField(label: "Meta Description", initialValue: currentP.metaDescription, onChanged: (v) => widget.controller.updateField(metaDescription: v), maxLines: 2),
                      ]),
                    ],
                  ),
                ),
              ],
            )
            : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Column: Media Studio
                    Expanded(
                      flex: 4,
                      child: ZenoCard(
                        title: "Media Studio",
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.controller.isFieldVisible('primaryImageUrl') || widget.controller.isFieldVisible('galleryUrls'))
                              ZenoImageGallery(
                                primaryUrl: currentP.primaryImageUrl,
                                galleryUrls: currentP.galleryUrls,
                                onPickPrimary: widget.controller.pickPrimaryImage,
                                onDeletePrimary: widget.controller.deletePrimaryImage,
                                onAddToGallery: widget.controller.addToGallery,
                                onRemoveGalleryImage: widget.controller.removeGalleryImage,
                                onSetGalleryAsPrimary: widget.controller.setGalleryImageAsPrimary,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Right Column: Online & Visibility
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          ZenoCard(
                            title: "Online Presentation",
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: Column(
                              children: [
                                if (widget.controller.isFieldVisible('marketingTitle'))
                                  ZenoTextField(label: "Marketing Title", initialValue: currentP.marketingTitle, onChanged: (v) => widget.controller.updateField(marketingTitle: v), width: ZenoFieldWidth.full),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    if (widget.controller.isFieldVisible('urlSlug'))
                                      Expanded(child: ZenoTextField(label: "URL Slug", initialValue: currentP.urlSlug, onChanged: (v) => widget.controller.updateField(urlSlug: v))),
                                    if (widget.controller.isFieldVisible('urlSlug') && widget.controller.isFieldVisible('searchKeywords'))
                                      const SizedBox(width: 8),
                                    if (widget.controller.isFieldVisible('searchKeywords'))
                                      Expanded(child: ZenoTextField(label: "Keywords", initialValue: currentP.searchKeywords.join(", "), onChanged: (v) => widget.controller.updateField(searchKeywords: v.split(',').map((e)=>e.trim()).toList()))),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                if (widget.controller.isFieldVisible('metaDescription'))
                                  ZenoTextField(label: "Meta Description", initialValue: currentP.metaDescription, onChanged: (v) => widget.controller.updateField(metaDescription: v), width: ZenoFieldWidth.full, maxLines: 2),
                                const SizedBox(height: 6),
                                if (widget.controller.isFieldVisible('description'))
                                  ZenoTextField(label: "Online Description", initialValue: currentP.description, onChanged: (v) => widget.controller.updateField(description: v), width: ZenoFieldWidth.full, maxLines: 2),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ZenoCard(
                            title: "Channel Visibility",
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            child: Wrap(
                              spacing: 16,
                              runSpacing: 6,
                              children: [
                                if (widget.controller.isFieldVisible('isQuickPOSSale'))
                                  _channelToggle("POS STORE", currentP.isQuickPOSSale, (v) => widget.controller.updateField(isQuickPOSSale: v)),
                                if (widget.controller.isFieldVisible('visibility'))
                                  _channelToggle("WEB STORE", currentP.visibility == "Public", (v) => widget.controller.updateField(visibility: v ? "Public" : "Private")),
                                if (widget.controller.isFieldVisible('appVisibility'))
                                  _channelToggle("MOBILE APP", currentP.appVisibility, (v) => widget.controller.updateField(appVisibility: v)),
                                if (widget.controller.isFieldVisible('b2bVisibility'))
                                  _channelToggle("B2B PORTAL", currentP.b2bVisibility, (v) => widget.controller.updateField(b2bVisibility: v)),
                              ],
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
      },
    );
  }

  Widget _channelToggle(String l, bool v, ValueChanged<bool> o) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)),
      Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: const Color(0xFFC00000))),
    ],
  );

  Widget _compactSection(String title, ZenoSemanticColors colors, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x14667EEA), Color(0x0D764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0x33667EEA)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF667EEA),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}
