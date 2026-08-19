import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../controllers/ai_controller.dart';

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
        // STICKY HEALTH BAR
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

class _HealthStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ZenoSemanticColors colors;
  const _HealthStat(
      {required this.label,
      required this.value,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: ZenoTypography.micro(colors.textDisabled)),
        const SizedBox(height: 2),
        Text(value,
            style: ZenoTypography.headlineSM(color).copyWith(
                fontWeight: FontWeight.w900,
                fontFamily: ZenoTypography.monoFamily)),
      ],
    );
  }
}

class _ModelEntry extends StatelessWidget {
  final String name;
  final String status;
  final String latency;
  final String type;
  final ZenoSemanticColors colors;
  const _ModelEntry(
      {required this.name,
      required this.status,
      required this.latency,
      required this.type,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(color: colors.borderSubtle)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: colors.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.psychology_outlined,
                size: 20, color: colors.accentPrimary),
          ),
          const SizedBox(width: ZenoSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: ZenoTypography.caption(colors.textPrimary)
                        .copyWith(fontWeight: FontWeight.w900)),
                Text(type,
                    style: ZenoTypography.micro(colors.textDisabled)
                        .copyWith(letterSpacing: 1)),
              ],
            ),
          ),
          ZenoBadge(
              label: status,
              color: status == "ACTIVE"
                  ? colors.statusSuccess
                  : colors.textDisabled),
          const SizedBox(width: 24),
          Text(latency,
              style: ZenoTypography.caption(colors.statusSuccess).copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: ZenoTypography.monoFamily)),
        ],
      ),
    );
  }
}

class _HeaderBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  const _HeaderBtn(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label,
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
    );
  }
}

class _AIProviderCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ZenoSemanticColors colors;
  const _AIProviderCard(
      {required this.title, required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(ZenoRadius.lg),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: colors.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 20, color: colors.accentPrimary),
          ),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
              child: Text(title.toUpperCase(),
                  style: ZenoTypography.caption(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.w900))),
          Icon(Icons.chevron_right, size: 14, color: colors.textDisabled),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ZenoSemanticColors colors;
  const _FilterChip(
      {required this.label, this.isSelected = false, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.accentPrimary.withValues(alpha: 0.1)
            : colors.bgTier3,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isSelected
                ? colors.accentPrimary.withValues(alpha: 0.3)
                : colors.borderSubtle),
      ),
      child: Text(label,
          style: ZenoTypography.micro(
                  isSelected ? colors.accentPrimary : colors.textSecondary)
              .copyWith(fontWeight: FontWeight.bold)),
    );
  }
}
