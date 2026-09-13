import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class OrderFulfillmentScreen extends StatelessWidget {
  final String stage; // Picking, Packing, Dispatch

  const OrderFulfillmentScreen({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "${stage.toUpperCase()} COMMAND CENTER",
          subtitle:
              "HIGH-VELOCITY WAREHOUSE OPERATIONS AND LOGISTICS SYNCHRONIZATION.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_scanner),
              label: Text("SCAN TO $stage".toUpperCase()),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accentPrimary,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ZenoRadius.md)),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "OPERATION QUEUE",
                    trailing: Text("8 ACTIVE"),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) =>
                          _QueueItem(id: "ORD-${5500 + index}", colors: colors),
                    ),
                  ),
                ),
                const SizedBox(width: ZenoSpacing.lg),
                Expanded(
                  flex: 2,
                  child: ZenoCard(
                    title: "CURRENT ASSIGNMENT",
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: colors.bgTier3.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(ZenoRadius.lg),
                        border:
                            Border.all(color: colors.borderSubtle, width: 2),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                  color: colors.bgTier4,
                                  shape: BoxShape.circle),
                              child: Icon(_getStageIcon(),
                                  size: 48, color: colors.textDisabled),
                            ),
                            const SizedBox(height: 24),
                            Text(
                                "NO ACTIVE ${stage.toUpperCase()} TASK ASSIGNED.",
                                style:
                                    ZenoTypography.bodyLG(colors.textSecondary)
                                        .copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text("READY FOR NEXT LOGISTICS UNIT.",
                                style:
                                    ZenoTypography.micro(colors.textDisabled)),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: 240,
                              child: _HeaderButton(
                                  label: "BEGIN NEXT TASK",
                                  icon: Icons.play_arrow_rounded,
                                  isPrimary: true),
                            ),
                          ],
                        ),
                      ),
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

  IconData _getStageIcon() {
    if (stage == "Picking") return Icons.shopping_basket_outlined;
    if (stage == "Packing") return Icons.inventory_2_outlined;
    return Icons.local_shipping_outlined;
  }
}

class _QueueItem extends StatelessWidget {
  final String id;
  final ZenoSemanticColors colors;
  const _QueueItem({required this.id, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, size: 14, color: Color(0xFFFF9800)),
          const SizedBox(width: ZenoSpacing.md),
          Text(id,
              style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: ZenoTypography.monoFamily)),
          const Spacer(),
          Text("12M AGO", style: ZenoTypography.micro(colors.textDisabled)),
          const SizedBox(width: ZenoSpacing.sm),
          Icon(Icons.chevron_right, size: 14, color: colors.textDisabled),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;

  const _HeaderButton(
      {required this.label, required this.icon, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.bold)),
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
