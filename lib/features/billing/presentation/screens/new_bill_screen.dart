import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/billing_studio_controller.dart';
import '../controllers/billing_state.dart';
import '../controllers/billing_event.dart';
import '../widgets/variant_selection_dialog.dart';

part 'parts/new_bill_summary_pay.part.dart';
part 'parts/new_bill_cart_zone.part.dart';

class NewBillScreen extends StatelessWidget {
  const NewBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoWorkspace(
      header: ZenoHeader(
        title: "Retail Terminal".toUpperCase(),
        subtitle: "TRANS-ACC: TERMINAL #104 • MODE: RETAIL",
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("BILL LOCK",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
              Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: false,
                  onChanged: (v) {},
                  activeThumbColor: colors.accentPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          ZenoButton(
              label: "Undo",
              icon: Icons.undo_rounded,
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm,
              onPressed: () {}),
          ZenoButton(
              label: "Hold",
              icon: Icons.pause_circle_outline,
              variant: ZenoButtonVariant.secondary,
              size: ZenoButtonSize.sm,
              onPressed: () {}),
          ZenoButton(
              label: "Cancel",
              icon: Icons.close,
              variant: ZenoButtonVariant.danger,
              size: ZenoButtonSize.sm,
              onPressed: () {}),
        ],
      ),
      body: BlocListener<BillingStudioController, BillingState>(
        listenWhen: (prev, curr) =>
            curr.needsVariantSelection && !prev.needsVariantSelection,
        listener: (context, state) {
          showDialog(
            context: context,
            builder: (dContext) => VariantSelectionDialog(
              variants: state.availableVariants!,
              onSelected: (v) => context
                  .read<BillingStudioController>()
                  .add(VariantSelected(state.pendingVariantProductId!, v)),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 65,
                    child: _buildSmartCartZone(colors),
                  ),

                  Container(
                    width: 420,
                    decoration: BoxDecoration(
                      color: colors.bgTier2,
                      border:
                          Border(left: BorderSide(color: colors.borderSubtle)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                            color: colors.bgTier3.withValues(alpha: 0.3),
                            border: Border(
                                bottom: BorderSide(color: colors.borderSubtle)),
                          ),
                          child: Row(
                            children: [
                              ZenoButton(
                                  label: "",
                                  icon: Icons.arrow_back_rounded,
                                  variant: ZenoButtonVariant.ghost,
                                  size: ZenoButtonSize.sm,
                                  onPressed: () {}),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 3,
                                child: ZenoTextField(
                                  hint: "CUSTOMER NAME...",
                                  label: null,
                                  initialValue: "",
                                  onChanged: (v) {},
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: ZenoTextField(
                                  hint: "PHONE...",
                                  label: null,
                                  initialValue: "",
                                  onChanged: (v) {},
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color:
                                          Colors.amber.withValues(alpha: 0.5)),
                                ),
                                child: const Text("GOLD TIER",
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.amber)),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const _SummaryRow(
                                    label: "SUBTOTAL", value: "₹1,245.00"),
                                const _SummaryRow(
                                    label: "TAXABLE AMOUNT", value: "₹1,055.08"),
                                const _SummaryRow(
                                    label: "TOTAL TAX (GST)", value: "₹189.92"),
                                const _SummaryRow(
                                    label: "DISCOUNT APPLIED",
                                    value: "-₹50.00",
                                    color: Colors.green),
                                const Spacer(),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: colors.bgTier1,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: colors.accentPrimary
                                            .withValues(alpha: 0.4),
                                        width: 2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.accentPrimary
                                            .withValues(alpha: 0.1),
                                        blurRadius: 20,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text("GRAND TOTAL DUE",
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: colors.textDisabled,
                                              letterSpacing: 2)),
                                      const SizedBox(height: 8),
                                      Text("₹1,419.10",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 48,
                                              color: colors.accentPrimary,
                                              letterSpacing: -1,
                                              fontFamily: ZenoTypography
                                                  .monoFamily)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colors.bgTier3.withValues(alpha: 0.5),
                            border: Border(
                                top: BorderSide(color: colors.borderSubtle)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: _PayButton(
                                          icon: Icons.payments_rounded,
                                          label: "CASH",
                                          hotkey: "F10",
                                          colors: colors)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: _PayButton(
                                          icon: Icons.credit_card_rounded,
                                          label: "CARD",
                                          hotkey: "F11",
                                          colors: colors)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                      child: _PayButton(
                                          icon: Icons.qr_code_2_rounded,
                                          label: "UPI / QR",
                                          hotkey: "F12",
                                          colors: colors)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: _PayButton(
                                          icon:
                                              Icons.account_balance_wallet_rounded,
                                          label: "CREDIT",
                                          hotkey: "ALT+C",
                                          colors: colors)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ZenoButton(
                                label: "COMPLETE CHECKOUT",
                                icon: Icons.bolt_rounded,
                                isFullWidth: true,
                                size: ZenoButtonSize.lg,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
