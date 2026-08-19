import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/features/purchase/domain/models/purchase_order.dart' as domain;
import 'package:zeno/features/purchase/presentation/controllers/purchase_controller.dart';
import 'package:zeno/features/purchase/domain/repositories/i_purchase_repository.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/features/purchase/presentation/screens/purchase_order_form_screen.dart';
import 'widgets/purchase/po_widgets.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});
  @override
  State<PurchaseOrderListScreen> createState() => _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  final controller = PurchaseController(sl<IPurchaseRepository>());
  @override
  void initState() { super.initState(); controller.addListener(_onUpdate); }
  void _onUpdate() => setState(() {});
  @override
  void dispose() { controller.removeListener(_onUpdate); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(children: [
      ZenoHeader(title: "Purchase Ledger".toUpperCase(), subtitle: "MONITOR PROCUREMENT CONTRACTS, APPROVAL STATES, AND FULFILLMENT LOGISTICS.", actions: [
        POActionBtn(label: "EXPORT LEDGER", icon: Icons.download_outlined, colors: colors, onPressed: () {}),
        const SizedBox(width: ZenoSpacing.sm),
        POActionBtn(label: "CREATE PO", icon: Icons.add, isPrimary: true, colors: colors, onPressed: () => NavigationController().openTab('suppliers/procurement/orders/new')),
      ]),
      _buildStickySummary(colors),
      Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(ZenoSpacing.lg, 0, ZenoSpacing.lg, ZenoSpacing.lg), child: _buildTableContainer(colors))),
    ]);
  }

  Widget _buildTableContainer(ZenoSemanticColors colors) {
    return Container(
      decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(ZenoRadius.lg), border: Border.all(color: colors.borderSubtle), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 20, offset: const Offset(0, 10))]),
      clipBehavior: Clip.antiAlias,
      child: ZenoTable<domain.PurchaseOrder>(
        items: controller.purchaseOrders,
        columns: [
          _idCol(colors), _supplierCol(colors), _valueCol(colors), _statusCol(colors), _dateCol(colors), _opsCol(colors),
        ],
      ),
    );
  }

  ZenoTableColumn<domain.PurchaseOrder> _idCol(ZenoSemanticColors colors) => ZenoTableColumn(label: "Order Identity", builder: (p) => Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(p.id.toUpperCase(), style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(fontWeight: FontWeight.w900, letterSpacing: 0.5)), Text(p.currency, style: ZenoTypography.micro(colors.textSecondary).copyWith(fontFamily: ZenoTypography.monoFamily))]));
  ZenoTableColumn<domain.PurchaseOrder> _supplierCol(ZenoSemanticColors colors) => ZenoTableColumn(label: "Target Supplier", builder: (p) => Row(children: [Icon(Icons.factory_outlined, size: 14, color: colors.textDisabled), const SizedBox(width: ZenoSpacing.sm), Text(p.supplierId.toUpperCase(), style: ZenoTypography.caption(colors.textPrimary).copyWith(fontWeight: FontWeight.bold))]));
  ZenoTableColumn<domain.PurchaseOrder> _valueCol(ZenoSemanticColors colors) => ZenoTableColumn(label: "Financial Value", width: 140, isNumeric: true, builder: (p) => Text("\$${p.totalAmount.toStringAsFixed(2)}", style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(fontWeight: FontWeight.w900)));
  ZenoTableColumn<domain.PurchaseOrder> _statusCol(ZenoSemanticColors colors) => ZenoTableColumn(label: "Lifecycle State", width: 160, builder: (p) => ZenoBadge(label: p.status.name.toUpperCase().replaceAll('_', ' '), color: p.status == domain.POStatus.received ? colors.statusSuccess : (p.status == domain.POStatus.pendingApproval ? colors.statusWarning : colors.accentPrimary)));
  ZenoTableColumn<domain.PurchaseOrder> _dateCol(ZenoSemanticColors colors) => ZenoTableColumn(label: "Expected Date", width: 150, builder: (p) => Text(p.expectedDeliveryDate.toString().substring(0, 10), style: ZenoTypography.caption(colors.textSecondary)));
  ZenoTableColumn<domain.PurchaseOrder> _opsCol(ZenoSemanticColors colors) => ZenoTableColumn(label: "Operations", width: 300, builder: (p) => Row(children: [
    if (p.status == domain.POStatus.draft || p.status == domain.POStatus.pendingApproval) IconButton(icon: const Icon(Icons.edit_outlined, color: Colors.blue), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseOrderFormScreen(existingPO: p))), tooltip: "Edit PO"),
    if (p.status == domain.POStatus.pendingApproval) IconButton(icon: const Icon(Icons.check_circle_outline, color: Colors.green), onPressed: () => controller.approvePO(p.id), tooltip: "Approve"),
    if (p.status == domain.POStatus.approved || p.status == domain.POStatus.ordered || p.status == domain.POStatus.partiallyReceived) IconButton(icon: const Icon(Icons.input_outlined, color: Colors.blue), onPressed: () => NavigationController().openTab('suppliers/procurement/grn/new', params: {'po': p}), tooltip: "Receive Goods"),
    IconButton(icon: const Icon(Icons.cancel_outlined, color: Colors.red), onPressed: () => controller.cancelPO(p.id), tooltip: "Cancel PO"),
    const SizedBox(width: 8), IconBtn(icon: Icons.visibility_outlined, color: colors.textSecondary),
  ]));

  Widget _buildStickySummary(ZenoSemanticColors colors) {
    final items = controller.purchaseOrders;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(color: colors.bgTier1, border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(children: [
        SummaryItem(label: "TOTAL OBLIGATION", value: "\$${items.fold(0.0, (sum, p) => sum + p.totalAmount).toStringAsFixed(0)}", colors: colors),
        _vDivider(colors),
        SummaryItem(label: "PENDING APPROVAL", value: items.where((p) => p.status == domain.POStatus.pendingApproval).length.toString(), colors: colors, color: colors.statusWarning),
        _vDivider(colors),
        SummaryItem(label: "ACTIVE CONTRACTS", value: items.length.toString(), colors: colors),
        const Spacer(),
        POFilterChip(label: "OPEN POs", count: items.length, isSelected: true, colors: colors),
        const SizedBox(width: ZenoSpacing.sm),
        POFilterChip(label: "URGENT", count: 2, isWarning: true, colors: colors),
      ]),
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(height: 24, width: 1, color: colors.borderSubtle, margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg));
}
