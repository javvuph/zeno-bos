import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../controllers/product_studio_controller.dart';
import '../aurora_field_renderer.dart';
import '../widgets/aurora_card.dart';
import '../../workstations/media_pillar.dart';

class Tab5MediaChannels extends StatelessWidget {
  final ProductStudioController controller;
  const Tab5MediaChannels({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final channelFields = controller.getTab5Fields();
    final semanticColors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          AuroraCard(
            title: "Digital Assets",
            subtitle: "Product photography and gallery",
            icon: Icons.image_outlined,
            child: MediaPillar(controller: controller, colors: semanticColors),
          ),
          AuroraCard(
            title: "Channels & Metadata",
            subtitle: "Omnichannel visibility and SEO",
            icon: Icons.language_outlined,
            accentColor: Colors.deepPurple,
            child: AuroraFieldRenderer(controller: controller, fieldIds: channelFields),
          ),
        ],
      ),
    );
  }
}
