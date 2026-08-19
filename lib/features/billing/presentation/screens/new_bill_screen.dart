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
                  activeColor: colors.accentPrimary,
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
            // TOP UNIVERSAL COMMAND VESSEL
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: colors.bgTier2,
                border: Border(bottom: BorderSide(color: colors.borderSubtle)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: colors.bgTier1,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: colors.accentPrimary.withValues(alpha: 0.3),
                            width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: colors.accentPrimary.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search_rounded,
                              color: colors.accentPrimary, size: 20),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintText:
                                    "COMMAND VESSEL: SCAN BARCODE, TYPE SKU, OR USE /SLASH COMMANDS...",
                                hintStyle:
                                    TextStyle(fontSize: 12, letterSpacing: 0.5),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: colors.bgTier3,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text("CTRL + L",
                                style: TextStyle(
                                    fontSize: 9, fontWeight: FontWeight.w900)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ZONE A: SMART CART (65%)
                  Expanded(
                    flex: 65,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("SMART CART",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900,
                                      color: colors.textPrimary,
                                      letterSpacing: 1)),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: colors.accentPrimary
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text("4 ITEMS",
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w900,
                                        color: colors.accentPrimary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // CART HEADER
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: colors.bgTier3,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8)),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text("PRODUCT DETAILS",
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900))),
                                Expanded(
                                    flex: 2,
                                    child: Text("QTY",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900))),
                                Expanded(
                                    flex: 2,
                                    child: Text("UNIT PRICE",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900))),
                                Expanded(
                                    flex: 2,
                                    child: Text("TOTAL",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 9,
                                            fontWeight: FontWeight.w900))),
                                SizedBox(width: 40),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: colors.borderSubtle),
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(8)),
                              ),
                              child: ListView.separated(
                                itemCount: 4,
                                separatorBuilder: (_, __) => Divider(
                                    height: 1, color: colors.borderSubtle),
                                itemBuilder: (context, index) =>
                                    const _PosCartItem(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ZONE B: UTILITY & SUMMARY (35%)
                  Container(
                    width: 420,
                    decoration: BoxDecoration(
                      color: colors.bgTier2,
                      border:
                          Border(left: BorderSide(color: colors.borderSubtle)),
                    ),
                    child: Column(
                      children: [
                        // 1. CUSTOMER HUB (HORIZONTAL TOP)
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
                                  initialValue: "JOHN DOE",
                                  onChanged: (v) {},
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: ZenoTextField(
                                  hint: "PHONE...",
                                  label: null,
                                  initialValue: "+91 98765 43210",
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

                        // 2. FINANCIAL SUMMARY
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
                                // GRAND TOTAL ORB
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

                        // 3. PAYMENT MATRIX (BOTTOM)
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

class _PosCartItem extends StatelessWidget {
  const _PosCartItem();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // PRODUCT INFO
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: colors.bgTier3,
                      borderRadius: BorderRadius.circular(6)),
                  child: Icon(Icons.inventory_2_outlined,
                      size: 18, color: colors.textDisabled),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("PREMIUM COTTON SHIRT",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 12)),
                      Text("SKU: SHRT-002-BL • BLUE / LARGE",
                          style: TextStyle(
                              fontSize: 9, color: colors.textDisabled)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // QUANTITY
          Expanded(
            flex: 2,
            child: Center(child: _QuantitySpinner(colors: colors)),
          ),
          // UNIT PRICE
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("₹850.00",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.textSecondary)),
                Text("TAX: 18%",
                    style: TextStyle(fontSize: 8, color: colors.textDisabled)),
              ],
            ),
          ),
          // TOTAL (HIGHLIGHTED)
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: colors.accentPrimary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text("₹850.00",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      color: colors.accentPrimary,
                      fontFamily: ZenoTypography.monoFamily)),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
              icon: const Icon(Icons.delete_outline_rounded,
                  size: 18, color: Colors.red),
              onPressed: () {}),
        ],
      ),
    );
  }
}

class _QuantitySpinner extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _QuantitySpinner({required this.colors});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: const Icon(Icons.remove, size: 12),
              onPressed: () {},
              visualDensity: VisualDensity.compact),
          const Text("1",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
          IconButton(
              icon: const Icon(Icons.add, size: 12),
              onPressed: () {},
              visualDensity: VisualDensity.compact),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  const _SummaryRow({required this.label, required this.value, this.color});
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: colors.textSecondary.withValues(alpha: 0.7))),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: color ?? colors.textPrimary,
                  fontFamily: ZenoTypography.monoFamily)),
        ],
      ),
    );
  }
}

class _PayButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hotkey;
  final ZenoSemanticColors colors;
  const _PayButton(
      {required this.icon,
      required this.label,
      required this.hotkey,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: colors.bgTier1,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: colors.accentPrimary),
            const SizedBox(height: 6),
            Text(label,
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w900)),
            const SizedBox(height: 2),
            Text(hotkey,
                style: TextStyle(fontSize: 8, color: colors.textDisabled)),
          ],
        ),
      ),
    );
  }
}
