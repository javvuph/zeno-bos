import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_image_widget.dart';
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
                    const Text("PRIMARY IMAGE", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 0.5)),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () => widget.controller.pickPrimaryImage(),
                      child: Container(
                        width: double.infinity,
                        height: 110, 
                        decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)),
                        child: currentP.primaryImageUrl.isEmpty 
                          ? const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo_outlined, size: 24, color: Colors.grey), SizedBox(height: 4), Text("Upload Primary", style: TextStyle(fontSize: 9, color: Colors.grey))]))
                          : ClipRRect(borderRadius: BorderRadius.circular(11), child: ZenoImageWidget(url: currentP.primaryImageUrl, fit: BoxFit.contain)),
                      ),
                    ),
                    const SizedBox(height: 10), 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("PRODUCT GALLERY", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 0.5)),
                        InkWell(
                          onTap: () => widget.controller.addToGallery(),
                          child: const Text("+ Upload More", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildGallerySlots(currentP.galleryUrls, isCompact: true),
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
                            if (widget.controller.isFieldVisible('primaryImageUrl')) ...[
                              const Text("PRIMARY IMAGE", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 0.5)),
                              const SizedBox(height: 6),
                              Container(
                                width: double.infinity,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: colors.bgTier3,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: colors.borderSubtle),
                                ),
                                child: currentP.primaryImageUrl.isEmpty 
                                  ? Center(child: IconButton(icon: const Icon(Icons.add_a_photo_outlined, size: 32, color: Colors.grey), onPressed: () => widget.controller.pickPrimaryImage()))
                                  : Stack(
                                      children: [
                                        ClipRRect(borderRadius: BorderRadius.circular(11), child: ZenoImageWidget(url: currentP.primaryImageUrl, width: double.infinity, height: 160, fit: BoxFit.contain)),
                                        Positioned(top: 4, right: 4, child: IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 16), onPressed: () => widget.controller.pickPrimaryImage(), style: IconButton.styleFrom(backgroundColor: Colors.black45, padding: EdgeInsets.zero, visualDensity: VisualDensity.compact))),
                                      ],
                                    ),
                              ),
                              const SizedBox(height: 12),
                            ],
                            if (widget.controller.isFieldVisible('galleryUrls')) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("GALLERY IMAGES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 0.5)),
                                  InkWell(
                                    onTap: () => widget.controller.addToGallery(),
                                    child: const Text("+ Upload", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              _buildGallerySlots(currentP.galleryUrls, isCompact: false),
                            ],
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

  Widget _buildGallerySlots(List<String> urls, {required bool isCompact}) {
    final double slotSize = isCompact ? 48 : 60;
    final int defaultSlotCount = 3;
    final int totalDisplaySlots = urls.length > defaultSlotCount ? urls.length : defaultSlotCount;

    List<Widget> slots = [];

    for (int i = 0; i < totalDisplaySlots; i++) {
      if (i < urls.length) {
        final url = urls[i];
        slots.add(
          Stack(
            children: [
              Container(
                width: slotSize,
                height: slotSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: ZenoImageWidget(url: url, fit: BoxFit.cover),
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: InkWell(
                  onTap: () => widget.controller.removeGalleryImage(i),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                    child: const Icon(Icons.close, size: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        final slotNum = i + 1;
        slots.add(
          InkWell(
            onTap: () => widget.controller.addToGallery(),
            child: Container(
              width: slotSize,
              height: slotSize,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add_photo_alternate_outlined, size: 16, color: Color(0xFFCBD5E1)),
                  const SizedBox(height: 2),
                  Text("Slot $slotNum", style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
                ],
              ),
            ),
          ),
        );
      }
    }

    // Always add "+" button at end
    slots.add(
      InkWell(
        onTap: () => widget.controller.addToGallery(),
        child: Container(
          width: slotSize,
          height: slotSize,
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2FF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF818CF8)),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_rounded, size: 20, color: Color(0xFF6366F1)),
              Text("Add", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Color(0xFF6366F1))),
            ],
          ),
        ),
      ),
    );

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: slots,
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
    return ZenoCard(
      title: title,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
