import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../../purchase/domain/repositories/i_purchase_repository.dart';
import '../../../purchase/domain/models/grn.dart';

class GoodsReceivedListScreen extends StatefulWidget {
  const GoodsReceivedListScreen({super.key});

  @override
  State<GoodsReceivedListScreen> createState() =>
      _GoodsReceivedListScreenState();
}

class _GoodsReceivedListScreenState extends State<GoodsReceivedListScreen> {
  List<GRN> _grns = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadGRNs();
  }

  Future<void> _loadGRNs() async {
    setState(() => _isLoading = true);
    try {
      final repo = sl<IPurchaseRepository>();
      final results = await repo.getGRNs();
      setState(() => _grns = results);
    } catch (e) {
      debugPrint("Error loading GRNs: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Column(
      children: [
        ZenoHeader(
          title: "Inward Goods Registry".toUpperCase(),
          subtitle: "TRACK ALL COMPLETED AND PENDING SHIPMENT RECEIPTS.",
          actions: [
            ElevatedButton.icon(
              onPressed: _loadGRNs,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text("REFRESH"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: Colors.black),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Container(
              decoration: BoxDecoration(
                color: colors.bgTier2,
                borderRadius: BorderRadius.circular(ZenoRadius.lg),
                border: Border.all(color: colors.borderSubtle),
              ),
              clipBehavior: Clip.antiAlias,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ZenoTable<GRN>(
                      items: _grns,
                      columns: [
                        ZenoTableColumn(
                            label: "GRN #",
                            width: 150,
                            builder: (g) => Text(g.id,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        ZenoTableColumn(
                            label: "PO Ref",
                            width: 120,
                            builder: (g) => Text(g.poId)),
                        ZenoTableColumn(
                            label: "Supplier",
                            builder: (g) => Text(g.supplierId.toUpperCase(),
                                style: const TextStyle(fontSize: 11))),
                        ZenoTableColumn(
                            label: "Date",
                            width: 120,
                            builder: (g) => Text(
                                g.receivedDate.toString().substring(0, 10))),
                        ZenoTableColumn(
                            label: "Status",
                            width: 120,
                            builder: (g) => ZenoBadge(
                                  label: g.status.name.toUpperCase(),
                                  color: _getStatusColor(g.status, colors),
                                )),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(GRNStatus status, ZenoSemanticColors colors) {
    if (status == GRNStatus.completed) return colors.statusSuccess;
    if (status == GRNStatus.partial) return colors.statusWarning;
    if (status == GRNStatus.rejected) return colors.statusDanger;
    return colors.accentPrimary;
  }
}
