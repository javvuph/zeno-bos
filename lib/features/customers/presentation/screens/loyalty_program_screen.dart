import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/customer_controller.dart';

class LoyaltyProgramScreen extends StatefulWidget {
  const LoyaltyProgramScreen({super.key});

  @override
  State<LoyaltyProgramScreen> createState() => _LoyaltyProgramScreenState();
}

class _LoyaltyProgramScreenState extends State<LoyaltyProgramScreen> {
  final controller = CustomerController(sl<ICustomerRepository>());

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
          title: "Loyalty & Strategic Rewards".toUpperCase(),
          subtitle:
              "CONFIGURE REWARD TIERS, AUTOMATED POINT SYSTEMS, AND VIP MEMBERSHIP PROGRAMS.",
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
                    title: "ACTIVE ENTERPRISE TIERS",
                    child: Column(
                      children: [
                        const _TierCard(
                            name: "VIP PLATINUM",
                            points: "50,000+ LTV",
                            color: Color(0xFFFFD700),
                            multiplier: "3.0X"),
                        const _TierCard(
                            name: "GOLD EXECUTIVE",
                            points: "10,000 - 49,999 LTV",
                            color: Color(0xFF00D2FF),
                            multiplier: "2.0X"),
                        const _TierCard(
                            name: "SILVER PREFERRED",
                            points: "2,500 - 9,999 LTV",
                            color: Color(0xFF9D50BB),
                            multiplier: "1.5X"),
                        const _TierCard(
                            name: "STANDARD MEMBER",
                            points: "< 2,500 LTV",
                            color: Colors.grey,
                            multiplier: "1.0X"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: ZenoSpacing.lg),
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "LOYALTY OPERATIONS",
                    child: Column(
                      children: [
                        _ActionRow(
                            label: "Issue Strategic Coupon",
                            icon: Icons.local_offer_outlined,
                            colors: colors),
                        _ActionRow(
                            label: "Manual Points Adjustment",
                            icon: Icons.star_outline,
                            colors: colors),
                        _ActionRow(
                            label: "Override Member Tier",
                            icon: Icons.military_tech_outlined,
                            colors: colors),
                        _ActionRow(
                            label: "Export Loyalty Audit",
                            icon: Icons.description_outlined,
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

class _TierCard extends StatelessWidget {
  final String name;
  final String points;
  final Color color;
  final String multiplier;

  const _TierCard(
      {required this.name,
      required this.points,
      required this.color,
      required this.multiplier});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
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
            child: Icon(Icons.workspace_premium, color: color, size: 20),
          ),
          const SizedBox(width: ZenoSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: ZenoTypography.bodyLG(color)
                        .copyWith(fontWeight: FontWeight.w900)),
                Text(points.toUpperCase(),
                    style: ZenoTypography.micro(colors.textDisabled)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: colors.bgTier1,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: colors.borderSubtle)),
            child: Text(multiplier,
                style: ZenoTypography.micro(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
          ),
          const SizedBox(width: ZenoSpacing.md),
          Icon(Icons.arrow_forward_ios_rounded,
              size: 12, color: colors.textDisabled),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final ZenoSemanticColors colors;

  const _ActionRow(
      {required this.label, required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
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
            Icon(icon, size: 18, color: colors.accentPrimary),
            const SizedBox(width: ZenoSpacing.md),
            Text(label.toUpperCase(),
                style: ZenoTypography.caption(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            Icon(Icons.add_circle_outline,
                size: 16, color: colors.textDisabled),
          ],
        ),
      ),
    );
  }
}
