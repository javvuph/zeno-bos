import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../controllers/ai_controller.dart';

part 'parts/ai_models_widgets.part.dart';

class AIModelsScreen extends StatefulWidget {
  const AIModelsScreen({super.key});

  @override
  State<AIModelsScreen> createState() => _AIModelsScreenState();
}

class _AIModelsScreenState extends State<AIModelsScreen> {
  final controller = AIController(sl<IAIRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    controller.loadModels();
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "Neural Model Registry".toUpperCase(),
          subtitle:
              "TECHNICAL CONTROL PANEL FOR LLM ORCHESTRATION, PROVIDER SELECTION, AND NEURAL PERFORMANCE AUDITING.",
          actions: [
            _HeaderBtn(
                label: "SYNC PROVIDERS", icon: Icons.sync, colors: colors),
            const SizedBox(width: ZenoSpacing.sm),
            _HeaderBtn(
                label: "DEPLOY NEW MODEL",
                icon: Icons.rocket_launch_outlined,
                isPrimary: true,
                colors: colors),
          ],
        ),
        _buildStickyHealth(colors),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Column(
              children: [
                ZenoCard(
                  title: "ACTIVE NEURAL MODELS",
                  trailing: Text("${controller.models.length} DEPLOYED"),
                  child: Column(
                    children: [
                      ...controller.models.map((m) => _ModelEntry(
                            name: m.name.toUpperCase(),
                            status: m.isEnabled ? "ACTIVE" : "STANDBY",
                            latency: "240MS",
                            type: m.type.name.toUpperCase(),
                            colors: colors,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: ZenoSpacing.xl),
                _buildProviderGrid(colors),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyHealth(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _HealthStat(
              label: "GATEWAY UPTIME",
              value: "99.99%",
              color: colors.statusSuccess,
              colors: colors),
          _vDivider(colors),
          _HealthStat(
              label: "TOKEN THROUGHPUT",
              value: "1.2M",
              color: colors.accentPrimary,
              colors: colors),
          _vDivider(colors),
          _HealthStat(
              label: "P95 LATENCY",
              value: "850MS",
              color: colors.statusWarning,
              colors: colors),
          const Spacer(),
          _FilterChip(label: "ALL REGIONS", colors: colors, isSelected: true),
        ],
      ),
    );
  }

  Widget _buildProviderGrid(ZenoSemanticColors colors) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: ZenoSpacing.lg,
      mainAxisSpacing: ZenoSpacing.lg,
      childAspectRatio: 2.5,
      children: [
        _AIProviderCard(
            title: "OpenAI Cluster", icon: Icons.bolt, colors: colors),
        _AIProviderCard(
            title: "Google Vertex", icon: Icons.cloud_outlined, colors: colors),
        _AIProviderCard(
            title: "Anthropic Node",
            icon: Icons.security_outlined,
            colors: colors),
      ],
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 24,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.xl));
}
