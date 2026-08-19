import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

class Coupon {
  final String code;
  final String discount;
  final String type;
  final String status;

  Coupon(
      {required this.code,
      required this.discount,
      required this.type,
      required this.status});
}

class CouponListScreen extends StatelessWidget {
  const CouponListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final List<Coupon> _items = [
      Coupon(
          code: "WELCOME10",
          discount: "10%",
          type: "One-time",
          status: "ACTIVE"),
      Coupon(
          code: "VIP50",
          discount: "\$50.00",
          type: "Member Only",
          status: "ACTIVE"),
      Coupon(
          code: "EXPIRED20",
          discount: "20%",
          type: "Seasonal",
          status: "EXPIRED"),
    ];

    return Column(
      children: [
        ZenoHeader(
          title: "Coupons & Vouchers".toUpperCase(),
          subtitle:
              "GENERATE DISCOUNT CODES, MANAGE GIFT CARDS, AND TRACK REDEMPTION ANALYTICS.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.confirmation_number_outlined),
              label: const Text("GENERATE COUPONS"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: Colors.black),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<Coupon>(
              items: _items,
              columns: [
                ZenoTableColumn(
                  label: "Coupon Code",
                  builder: (c) => Text(c.code,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          letterSpacing: 1)),
                ),
                ZenoTableColumn(
                  label: "Discount Value",
                  width: 150,
                  builder: (c) => Text(c.discount,
                      style: TextStyle(
                          color: colors.statusSuccess,
                          fontWeight: FontWeight.w900)),
                ),
                ZenoTableColumn(
                  label: "Type",
                  width: 150,
                  builder: (c) => Text(c.type),
                ),
                ZenoTableColumn(
                  label: "Status",
                  width: 150,
                  builder: (c) => ZenoBadge(
                      label: c.status,
                      color: c.status == "ACTIVE"
                          ? colors.statusSuccess
                          : colors.statusDanger),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
