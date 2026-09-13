import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/finance_controller.dart';

class TaxManagementScreen extends StatefulWidget {
  const TaxManagementScreen({super.key});

  @override
  State<TaxManagementScreen> createState() => _TaxManagementScreenState();
}

class _TaxManagementScreenState extends State<TaxManagementScreen> {
  final controller = FinanceController(sl<IFinanceRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
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
          title: "Tax & Compliance Hub".toUpperCase(),
          subtitle:
              "MANAGE GLOBAL GST/VAT FILINGS, FISCAL TAX RATES, AND REGULATORY DOCUMENTATION.",
          actions: [
            _COAButton(
                label: "Export Reports",
                icon: Icons.download_outlined,
                colors: colors),
            const SizedBox(width: ZenoSpacing.sm),
            _COAButton(
                label: "New Tax Profile",
                icon: Icons.add,
                isPrimary: true,
                colors: colors),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "ACTIVE TAX PROFILES",
                    child: Column(
                      children: [
                        _TaxRateItem(
                            label: "Standard GST",
                            rate: "18%",
                            color: Color(0xFF38ef7d),
                            colors: colors),
                        _TaxRateItem(
                            label: "Reduced VAT",
                            rate: "5%",
                            color: Color(0xFF00D2FF),
                            colors: colors),
                        _TaxRateItem(
                            label: "Luxury Surcharge",
                            rate: "28%",
                            color: Color(0xFFee0979),
                            colors: colors),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: ZenoSpacing.lg),
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "FILING CALENDAR",
                    child: Column(
                      children: [
                        _DeadlineItem(
                            label: "Q2 GST Return",
                            date: "JULY 31, 2026",
                            urgency: "URGENT",
                            colors: colors),
                        _DeadlineItem(
                            label: "Annual Fiscal Audit",
                            date: "SEPT 30, 2026",
                            urgency: "SCHEDULED",
                            colors: colors),
                        const SizedBox(height: ZenoSpacing.lg),
                        _ActionBtn(
                            label: "VIEW FULL COMPLIANCE CALENDAR",
                            colors: colors),
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
}

class _TaxRateItem extends StatelessWidget {
  final String label;
  final String rate;
  final Color color;
  final ZenoSemanticColors colors;
  const _TaxRateItem(
      {required this.label,
      required this.rate,
      required this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: ZenoDuration.fast,
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier3.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(ZenoRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(Icons.percent, color: color, size: 20),
          ),
          const SizedBox(width: ZenoSpacing.lg),
          Expanded(
              child: Text(label.toUpperCase(),
                  style: ZenoTypography.bodyMD(colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.w900))),
          Text(rate,
              style: ZenoTypography.headlineMD(color)
                  .copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        ],
      ),
    );
  }
}

class _DeadlineItem extends StatelessWidget {
  final String label;
  final String date;
  final String urgency;
  final ZenoSemanticColors colors;
  const _DeadlineItem(
      {required this.label,
      required this.date,
      required this.urgency,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    final bool isUrgent = urgency == "URGENT";
    return Padding(
      padding: const EdgeInsets.only(bottom: ZenoSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(ZenoSpacing.md),
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                size: 16,
                color: isUrgent ? colors.statusDanger : colors.textDisabled),
            const SizedBox(width: ZenoSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label.toUpperCase(),
                      style: ZenoTypography.caption(colors.textPrimary)
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(date, style: ZenoTypography.micro(colors.textDisabled)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isUrgent
                    ? colors.statusDanger.withValues(alpha: 0.1)
                    : colors.bgTier3,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(urgency,
                  style: ZenoTypography.micro(
                          isUrgent ? colors.statusDanger : colors.textSecondary)
                      .copyWith(fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}

class _COAButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  const _COAButton(
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
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.lg, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
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
