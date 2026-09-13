import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

import '../../domain/models/stock_transaction.dart' as domain;
import '../controllers/inventory_controller.dart';
import '../../domain/repositories/i_inventory_repository.dart';
import 'package:zeno/core/di/service_locator.dart';

class StockHistoryScreen extends StatefulWidget {
  const StockHistoryScreen({super.key});

  @override
  State<StockHistoryScreen> createState() => _StockHistoryScreenState();
}

class _StockHistoryScreenState extends State<StockHistoryScreen> {
  final controller = InventoryController(sl<IInventoryRepository>());

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
    final items = controller.recentTransactions;

    return Column(
      children: [
        ZenoHeader(
          title: "Audit Trail & Movement".toUpperCase(),
          subtitle:
              "END-TO-END TRACEABILITY OF ALL GLOBAL INVENTORY TRANSACTIONS.",
          actions: [
            IconButton(
                icon: const Icon(Icons.filter_list_rounded), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () => controller.refreshAll()),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg),
            child: Container(
              decoration: BoxDecoration(
                color: colors.bgTier2,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(ZenoRadius.lg)),
                border: Border.all(color: colors.borderSubtle),
              ),
              clipBehavior: Clip.antiAlias,
              child: ZenoTable<domain.StockTransaction>(
                items: items,
                columns: [
                  ZenoTableColumn(
                    label: "Timestamp",
                    width: 180,
                    builder: (m) => Text(
                        m.timestamp.toString().substring(0, 16),
                        style: ZenoTypography.caption(colors.textSecondary)),
                  ),
                  ZenoTableColumn(
                    label: "Entity ID",
                    width: 150,
                    builder: (m) => Text(m.stockItemId.toUpperCase(),
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(
                                fontFamily: ZenoTypography.monoFamily,
                                fontWeight: FontWeight.bold)),
                  ),
                  ZenoTableColumn(
                    label: "Operation",
                    width: 140,
                    builder: (m) => ZenoBadge(
                      label: m.type.name.toUpperCase().replaceAll('_', ' '),
                      color: m.quantityDelta > 0
                          ? colors.statusSuccess
                          : colors.statusDanger,
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Quantity",
                    width: 120,
                    isNumeric: true,
                    builder: (m) => Text(
                      (m.quantityDelta > 0
                          ? "+${m.quantityDelta.toInt()}"
                          : m.quantityDelta.toInt().toString()),
                      style: ZenoTypography.bodyMD(m.quantityDelta > 0
                              ? colors.statusSuccess
                              : colors.statusDanger)
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Trace Reference",
                    builder: (m) => Text(m.referenceId ?? "MANUAL",
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(fontWeight: FontWeight.w500)),
                  ),
                  ZenoTableColumn(
                    label: "Origin User",
                    width: 140,
                    builder: (m) => Row(
                      children: [
                        CircleAvatar(
                            radius: 8,
                            backgroundColor: colors.bgTier3,
                            child: Icon(Icons.person,
                                size: 10, color: colors.textSecondary)),
                        const SizedBox(width: 8),
                        Text(m.userId.toUpperCase(),
                            style: ZenoTypography.caption(colors.textPrimary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
