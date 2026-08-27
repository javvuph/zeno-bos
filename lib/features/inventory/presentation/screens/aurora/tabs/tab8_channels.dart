import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';

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
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
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
                        child: p.primaryImageUrl.isEmpty 
                          ? Center(child: IconButton(icon: const Icon(Icons.add_a_photo_outlined, size: 32, color: Colors.grey), onPressed: () => widget.controller.pickPrimaryImage()))
                          : Stack(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.circular(11), child: Image.network(p.primaryImageUrl, width: double.infinity, height: 160, fit: BoxFit.contain)),
                                Positioned(top: 4, right: 4, child: IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 16), onPressed: () => widget.controller.pickPrimaryImage(), style: IconButton.styleFrom(backgroundColor: Colors.black45, padding: EdgeInsets.zero, visualDensity: VisualDensity.compact))),
                              ],
                            ),
                      ),
                      const SizedBox(height: 12),
                      const Text("GALLERY IMAGES", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 0.5)),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 64,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...p.galleryUrls.asMap().entries.map((e) => Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 64, height: 64,
                                    decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)),
                                    child: ClipRRect(borderRadius: BorderRadius.circular(7), child: Image.network(e.value, fit: BoxFit.cover)),
                                  ),
                                  Positioned(top: 2, right: 2, child: InkWell(onTap: () => widget.controller.removeGalleryImage(e.key), child: Container(padding: const EdgeInsets.all(1), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, size: 8, color: Colors.white)))),
                                ],
                              ),
                            )),
                            InkWell(
                              onTap: () => widget.controller.addToGallery(),
                              child: Container(
                                width: 64, height: 64,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle, style: BorderStyle.solid)),
                                child: const Center(child: Icon(Icons.add_photo_alternate_outlined, color: Colors.grey, size: 18)),
                              ),
                            ),
                          ],
                        ),
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
                          ZenoTextField(label: "Marketing Title", initialValue: p.marketingTitle, onChanged: (v) => widget.controller.updateField(marketingTitle: v), width: ZenoFieldWidth.full),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(child: ZenoTextField(label: "URL Slug", initialValue: p.urlSlug, onChanged: (v) => widget.controller.updateField(urlSlug: v))),
                              const SizedBox(width: 8),
                              Expanded(child: ZenoTextField(label: "Keywords", initialValue: p.searchKeywords.join(", "), onChanged: (v) => widget.controller.updateField(searchKeywords: v.split(',').map((e)=>e.trim()).toList()))),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ZenoTextField(label: "Meta Description", initialValue: p.metaDescription, onChanged: (v) => widget.controller.updateField(metaDescription: v), width: ZenoFieldWidth.full, maxLines: 2),
                          const SizedBox(height: 6),
                          ZenoTextField(label: "Online Description", initialValue: p.description, onChanged: (v) => widget.controller.updateField(description: v), width: ZenoFieldWidth.full, maxLines: 2),
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
                          _channelToggle("POS STORE", p.isQuickPOSSale, (v) => widget.controller.updateField(isQuickPOSSale: v)),
                          _channelToggle("WEB STORE", p.visibility == "Public", (v) => widget.controller.updateField(visibility: v ? "Public" : "Private")),
                          _channelToggle("MOBILE APP", p.appVisibility, (v) => widget.controller.updateField(appVisibility: v)),
                          _channelToggle("B2B PORTAL", p.b2bVisibility, (v) => widget.controller.updateField(b2bVisibility: v)),
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
  }

  Widget _channelToggle(String l, bool v, ValueChanged<bool> o) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(l, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.grey)),
      Transform.scale(scale: 0.7, child: Switch(value: v, onChanged: o, activeThumbColor: const Color(0xFFC00000))),
    ],
  );
}
