import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/stock_level.dart' as domain;
import '../../domain/repositories/i_inventory_repository.dart';
import '../controllers/inventory_controller.dart';
import 'widgets/stock/stock_widgets.dart';

class CurrentStockScreen extends StatefulWidget {
  const CurrentStockScreen({super.key});

  @override
  State<CurrentStockScreen> createState() => _CurrentStockScreenState();
}

class _CurrentStockScreenState extends State<CurrentStockScreen> {
  final controller = InventoryController(sl<IInventoryRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    controller.refreshAll();
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
    final items = controller.allStockLevels;

    return Column(
      children: [
        ZenoHeader(
          title: "Real-time Stock Visibility".toUpperCase(),
          subtitle: "MONITOR PHYSICAL, AVAILABLE, AND RESERVED INVENTORY ACROSS GLOBAL NODES.",
          onSearch: (v) {},
          actions: const [
            StockActionButton(label: "Export Inventory", icon: Icons.download_outlined),
            SizedBox(width: ZenoSpacing.sm),
            StockActionButton(label: "Adjust Stock", icon: Icons.tune_outlined, isPrimary: true),
          ],
        ),
        _buildStickySummary(colors),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(ZenoSpacing.lg, 0, ZenoSpacing.lg, ZenoSpacing.lg),
            child: Container(
              decoration: BoxDecoration(
                color: colors.bgTier2,
                borderRadius: BorderRadius.circular(ZenoRadius.lg),
                border: Border.all(color: colors.borderSubtle),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              clipBehavior: Clip.antiAlias,
              child: ZenoTable<domain.StockLevel>(
                items: items,
                columns: [
                  _productIdColumn(colors),
                  _locationColumn(colors),
                  _stockColumn("Physical", (s) => s.physical, colors),
                  _stockColumn("Available", (s) => s.available, colors, isHighlight: true),
                  _stockColumn("Reserved", (s) => s.reserved, colors, isWarning: true),
                  _statusColumn(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  ZenoTableColumn<domain.StockLevel> _productIdColumn(ZenoSemanticColors colors) {
    return ZenoTableColumn(
      label: "Product ID",
      builder: (s) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(s.productId.toUpperCase(), style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          Text(s.variantId.toUpperCase(), style: ZenoTypography.micro(colors.textSecondary).copyWith(fontFamily: ZenoTypography.monoFamily)),
        ],
      ),
    );
  }

  ZenoTableColumn<domain.StockLevel> _locationColumn(ZenoSemanticColors colors) {
    return ZenoTableColumn(
      label: "Location",
      width: 200,
      builder: (s) => Row(
        children: [
          Icon(Icons.warehouse_outlined, size: 14, color: colors.textDisabled),
          const SizedBox(width: ZenoSpacing.sm),
          Text(s.warehouseId.toUpperCase(), style: ZenoTypography.caption(colors.textPrimary)),
        ],
      ),
    );
  }

  ZenoTableColumn<domain.StockLevel> _stockColumn(String label, double Function(domain.StockLevel) value, ZenoSemanticColors colors, {bool isHighlight = false, bool isWarning = false}) {
    return ZenoTableColumn(
      label: label,
      width: 120,
      isNumeric: true,
      builder: (s) {
        final val = value(s);
        Color textCol = colors.textPrimary;
        if (isHighlight) textCol = colors.statusSuccess;
        if (isWarning && val > 0) textCol = colors.statusWarning;
        if (isWarning && val == 0) textCol = colors.textDisabled;

        return Text(val.toStringAsFixed(0), style: ZenoTypography.bodyMD(textCol).copyWith(fontWeight: isHighlight ? FontWeight.w900 : FontWeight.bold));
      },
    );
  }

  ZenoTableColumn<domain.StockLevel> _statusColumn() {
    return ZenoTableColumn(
      label: "Status",
      width: 140,
      builder: (s) => ZenoBadge(
        label: s.available < 100 ? "LOW STOCK" : "OPTIMAL",
        color: s.available < 100 ? Theme.of(context).extension<ZenoSemanticColors>()!.statusWarning : Theme.of(context).extension<ZenoSemanticColors>()!.statusSuccess,
      ),
    );
  }

  Widget _buildStickySummary(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(color: colors.bgTier1, border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          StockSummaryItem(label: "TOTAL PHYSICAL", value: controller.totalPhysicalStock.toStringAsFixed(0), colors: colors),
          _vDivider(colors),
          StockSummaryItem(label: "TOTAL RESERVED", value: controller.totalReservedStock.toStringAsFixed(0), colors: colors, color: colors.statusWarning),
          _vDivider(colors),
          StockSummaryItem(label: "NODES TRACKED", value: controller.warehouses.length.toString(), colors: colors),
          const Spacer(),
          StockFilterChip(label: "ALL LOCATIONS", colors: colors),
          const SizedBox(width: ZenoSpacing.sm),
          StockFilterChip(label: "LOW STOCK ONLY", colors: colors, isWarning: true),
        ],
      ),
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(height: 24, width: 1, color: colors.borderSubtle, margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg));
}
