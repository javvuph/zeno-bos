import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import '../../controllers/product_studio_controller.dart';

class AdvancedSection extends StatelessWidget {
  final ProductStudioController controller;
  final ZenoSemanticColors colors;
  const AdvancedSection({super.key, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoCard(
          title: "System Information",
          titleColor: Colors.blue,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Additional system-level configurations will appear here in future phases.",
                  style: TextStyle(fontSize: 11, color: colors.textDisabled)),
            ],
          ),
        ),
      ],
    );
  }
}
