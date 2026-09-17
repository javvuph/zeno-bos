import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../../../domain/models/product_studio_enums.dart';
import '../../../controllers/product_studio_controller.dart';
import '../../../controllers/registries/fashion_config.dart';
import '../variant_matrix.dart';

part 'parts/fashion_variants_media_card.part.dart';
part 'parts/fashion_variants_attr_card.part.dart';
part 'parts/fashion_variants_dialogs.part.dart';

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
        Expanded(
          flex: 3,
          child: _buildColourMediaLibraryCard(),
        ),
      ],
    );
  }
}
