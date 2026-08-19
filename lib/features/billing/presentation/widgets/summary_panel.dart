import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';

class SummaryPanel extends StatelessWidget {
  const SummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        final bill = state.activeBill;

        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: ZenoSpacing.xl, vertical: ZenoSpacing.lg),
          decoration: BoxDecoration(
            color: colors.bgTier2,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDetailColumn(bill, colors),
              const Spacer(),
              const VerticalDivider(width: 64, indent: 8, endIndent: 8),
              _buildGrandTotal(bill.grandTotal, colors),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailColumn(dynamic bill, ZenoSemanticColors colors) {
    return Row(
      children: [
        _SummaryItem(label: 'SUBTOTAL', value: bill.subtotal, colors: colors),
        const SizedBox(width: ZenoSpacing.xl),
        _SummaryItem(label: 'TOTAL TAX', value: bill.totalTax, colors: colors),
        const SizedBox(width: ZenoSpacing.xl),
        _SummaryItem(
          label: 'DISCOUNT',
          value: bill.totalDiscount,
          colors: colors,
          isNegative: true,
          valueColor: colors.statusSuccess,
        ),
      ],
    );
  }

  Widget _buildGrandTotal(double total, ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: colors.accentPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: colors.accentPrimary.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
              color: colors.accentPrimary.withValues(alpha: 0.1),
              blurRadius: 20),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'GRAND TOTAL',
            style: ZenoTypography.caption(colors.accentPrimary)
                .copyWith(letterSpacing: 2.0, fontWeight: FontWeight.w900),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: total),
            duration: ZenoDuration.std,
            builder: (context, value, child) {
              return Text(
                '\$${value.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: colors.textPrimary,
                  fontFamily: 'Inter',
                  letterSpacing: -1.5,
                ),
              ).animate(target: value > 0 ? 1 : 0).shimmer(
                  duration: 500.ms,
                  color: colors.accentPrimary.withValues(alpha: 0.2));
            },
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95));
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final double value;
  final ZenoSemanticColors colors;
  final bool isNegative;
  final Color? valueColor;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.colors,
    this.isNegative = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: ZenoTypography.micro(colors.textDisabled)
              .copyWith(letterSpacing: 1.0),
        ),
        const SizedBox(height: 2),
        Text(
          '${isNegative ? '-' : ''}\$${value.toStringAsFixed(2)}',
          style: ZenoTypography.headlineMD(valueColor ?? colors.textPrimary)
              .copyWith(fontFamily: 'monospace'),
        ),
      ],
    );
  }
}
