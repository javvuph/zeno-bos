import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../../domain/models/ai_automation.dart';
import '../controllers/ai_controller.dart';

class AutomationHubScreen extends StatefulWidget {
  const AutomationHubScreen({super.key});

  @override
  State<AutomationHubScreen> createState() => _AutomationHubScreenState();
}

class _AutomationHubScreenState extends State<AutomationHubScreen> {
  final controller = AIController(sl<IAIRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    controller.loadAutomations();
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
          title: "AI Rules & Automation".toUpperCase(),
          subtitle:
              "CONFIGURE AUTONOMOUS TRIGGERS, SMART WORKFLOWS, AND CROSS-MODULE PROCESS ORCHESTRATION.",
          actions: [
            _HeaderBtn(
                label: "NEW AUTOMATION",
                icon: Icons.add,
                isPrimary: true,
                colors: colors),
          ],
        ),
        // STICKY SUMMARY
        _buildStickySummary(colors),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "ACTIVE WORKFLOWS",
                    trailing: Text("${controller.automations.length} RUNNING"),
                    child: controller.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              ...controller.automations
                                  .map((a) => _WorkflowItem(
                                        label: a.name,
                                        status: a.status.name.toUpperCase(),
                                        color: _getStatusColor(a.status),
                                        colors: colors,
                                      )),
                              const SizedBox(height: ZenoSpacing.lg),
                              _ActionBtn(
                                  label: "VIEW AUTOMATION LOGS",
                                  colors: colors),
                            ],
                          ),
                  ),
                ),
                const SizedBox(width: ZenoSpacing.lg),
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "NEURAL PERFORMANCE",
                    child: Column(
                      children: [
                        _TriggerStat(
                            label: "SUCCESS RATE",
                            value: "99.2%",
                            color: const Color(0xFF38ef7d),
                            colors: colors),
                        _TriggerStat(
                            label: "ERRORS RESOLVED",
                            value: "850",
                            color: const Color(0xFF00F0FF),
                            colors: colors),
                        const SizedBox(height: ZenoSpacing.xl),
                        _buildHealthBar(colors),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(AutomationStatus status) {
    switch (status) {
      case AutomationStatus.active:
        return const Color(0xFF00FF88);
      case AutomationStatus.paused:
        return const Color(0xFFFF9800);
      case AutomationStatus.failed:
        return const Color(0xFFee0979);
      case AutomationStatus.draft:
        return const Color(0xFF9E9E9E);
      case AutomationStatus.completed:
        return Colors.blue;
    }
  }

  Widget _buildStickySummary(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _SummaryItem(label: "TOTAL TRIGGERS", value: "1,242", colors: colors),
          _vDivider(colors),
          _SummaryItem(
              label: "ACTIVE RULES",
              value:
                  "${controller.automations.where((a) => a.status == AutomationStatus.active).length}",
              colors: colors,
              color: colors.accentPrimary),
          _vDivider(colors),
          _SummaryItem(
              label: "PENDING ACTIONS",
              value: "3",
              colors: colors,
              color: colors.statusWarning),
          const Spacer(),
          _FilterChip(label: "ALL MODULES", isSelected: true, colors: colors),
        ],
      ),
    );
  }

  Widget _buildHealthBar(ZenoSemanticColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ROBOTIC PROCESS HEALTH",
            style: ZenoTypography.micro(colors.textDisabled)
                .copyWith(letterSpacing: 1)),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: 0.94,
            minHeight: 8,
            backgroundColor: colors.bgTier3,
            valueColor: AlwaysStoppedAnimation<Color>(colors.statusSuccess),
          ),
        ),
      ],
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 24,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg));
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final ZenoSemanticColors colors;
  final Color? color;
  const _SummaryItem(
      {required this.label,
      required this.value,
      required this.colors,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: ZenoTypography.micro(colors.textDisabled)),
        const SizedBox(height: 4),
        Text(value,
            style: ZenoTypography.headlineMD(color ?? colors.textPrimary)
                .copyWith(fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class _WorkflowItem extends StatelessWidget {
  final String label;
  final String status;
  final Color color;
  final ZenoSemanticColors colors;
  const _WorkflowItem(
      {required this.label,
      required this.status,
      required this.color,
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
          Icon(Icons.bolt, size: 14, color: color),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label,
                  style: ZenoTypography.caption(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.bold))),
          Text(status,
              style: ZenoTypography.micro(color)
                  .copyWith(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}

class _TriggerStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final ZenoSemanticColors colors;
  const _TriggerStat(
      {required this.label,
      required this.value,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ZenoSpacing.lg),
      child: Row(
        children: [
          Text(label,
              style: ZenoTypography.micro(colors.textDisabled)
                  .copyWith(letterSpacing: 1)),
          const Spacer(),
          Text(value,
              style: ZenoTypography.headlineSM(color).copyWith(
                  fontWeight: FontWeight.w900,
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
      label: Text(label.toUpperCase(),
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

class _ActionBtn extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  const _ActionBtn({required this.label, required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colors.borderSubtle),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZenoRadius.md)),
        ),
        child: Text(label,
            style: ZenoTypography.caption(colors.accentPrimary)
                .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1)),
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
