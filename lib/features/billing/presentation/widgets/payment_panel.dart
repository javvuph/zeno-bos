import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/presentation/dialogs/payment_dialog.dart';

class PaymentPanel extends StatefulWidget {
  const PaymentPanel({super.key});

  @override
  State<PaymentPanel> createState() => _PaymentPanelState();
}

class _PaymentPanelState extends State<PaymentPanel> {
  bool _isExpanded = true;

  void _initiatePayment(BuildContext context) {
    final controller = context.read<BillingStudioController>();
    if (controller.state.activeBill.items.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => PaymentDialog(
        bill: controller.state.activeBill,
        onPaymentConfirmed: (payment) {
          controller.add(PaymentInitiated(payment));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoCard(
      title: "PAYMENT",
      trailing: IconButton(
        onPressed: () => setState(() => _isExpanded = !_isExpanded),
        icon: AnimatedRotation(
          turns: _isExpanded ? 0 : 0.5,
          duration: ZenoDuration.std,
          child: Icon(Icons.keyboard_arrow_up,
              color: colors.textSecondary, size: 18),
        ),
      ),
      padding: EdgeInsets.zero,
      child: AnimatedCrossFade(
        firstChild: const SizedBox(width: double.infinity),
        secondChild: Padding(
          padding: const EdgeInsets.all(ZenoSpacing.md),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _PaymentButton(
                      label: 'CASH',
                      hint: 'F10',
                      icon: Icons.payments_outlined,
                      color: colors.statusSuccess,
                      colors: colors,
                      onTap: () => _initiatePayment(context),
                    ),
                  ),
                  const SizedBox(width: ZenoSpacing.sm),
                  Expanded(
                    child: _PaymentButton(
                      label: 'CARD',
                      hint: 'F11',
                      icon: Icons.credit_card_outlined,
                      color: colors.accentPrimary,
                      colors: colors,
                      onTap: () => _initiatePayment(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ZenoSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: _PaymentButton(
                      label: 'UPI / QR',
                      hint: 'F12',
                      icon: Icons.qr_code_2_outlined,
                      color: colors.accentPurple,
                      colors: colors,
                      onTap: () => _initiatePayment(context),
                    ),
                  ),
                  const SizedBox(width: ZenoSpacing.sm),
                  Expanded(
                    child: _PaymentButton(
                      label: 'CREDIT',
                      hint: 'Alt+C',
                      icon: Icons.account_balance_wallet_outlined,
                      color: colors.statusWarning,
                      colors: colors,
                      onTap: () => {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ZenoSpacing.lg),
              _buildCheckoutButton(colors),
            ],
          ),
        ),
        crossFadeState:
            _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: ZenoDuration.std,
      ),
    );
  }

  Widget _buildCheckoutButton(ZenoSemanticColors colors) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        boxShadow: [
          BoxShadow(
            color: colors.accentPrimary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _initiatePayment(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.accentPrimary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZenoRadius.md)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "COMPLETE CHECKOUT",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                  fontSize: 13),
            ),
            const SizedBox(width: ZenoSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'ENTER',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(duration: 3000.ms, color: Colors.white.withValues(alpha: 0.2));
  }
}

class _PaymentButton extends StatefulWidget {
  final String label;
  final String hint;
  final IconData icon;
  final Color color;
  final ZenoSemanticColors colors;
  final VoidCallback onTap;

  const _PaymentButton({
    required this.label,
    required this.hint,
    required this.icon,
    required this.color,
    required this.colors,
    required this.onTap,
  });

  @override
  State<_PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<_PaymentButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: ZenoDuration.fast,
        height: 70,
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.color.withValues(alpha: 0.1)
              : widget.colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(
            color: _isHovered ? widget.color : widget.colors.borderSubtle,
            width: _isHovered ? 1.5 : 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(ZenoRadius.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon,
                    color:
                        _isHovered ? widget.color : widget.colors.textSecondary,
                    size: 24),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  style: TextStyle(
                    color: _isHovered
                        ? widget.colors.textPrimary
                        : widget.colors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  widget.hint,
                  style: ZenoTypography.micro(widget.colors.textDisabled),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
