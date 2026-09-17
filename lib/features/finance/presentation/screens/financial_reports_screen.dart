import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/finance_controller.dart';
import '../../domain/models/trial_balance.dart';

class FinancialReportsScreen extends StatefulWidget {
  final String type;
  const FinancialReportsScreen({super.key, required this.type});

  @override
  State<FinancialReportsScreen> createState() => _FinancialReportsScreenState();
}

class _FinancialReportsScreenState extends State<FinancialReportsScreen> {
  final controller = FinanceController(sl<IFinanceRepository>());

  @override
  void initState() {
    super.initState();
    controller.generateFinancialReports();
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
    String title = "Financial Report";

    if (widget.type == 'trial_balance') {
      return _buildTrialBalanceReport(colors);
    }

    return Column(
      children: [
        ZenoHeader(
          title: title.toUpperCase(),
          subtitle:
              "Enterprise financial analysis generated from real-time ledger data.",
        ),
        const Expanded(
            child: Center(
                child: Text(
                    "Report type not fully adapted to new model architecture."))),
      ],
    );
  }

  Widget _buildTrialBalanceReport(ZenoSemanticColors colors) {
    final tb = controller.trialBalance;
    final items = tb?.lines ?? [];

    return Column(
      children: [
        const ZenoHeader(
          title: "TRIAL BALANCE",
          subtitle:
              "Enterprise-grade financial integrity validation across all ledger accounts.",
        ),
        Expanded(
          child: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(ZenoSpacing.lg),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.bgTier2,
                      borderRadius: BorderRadius.circular(ZenoRadius.lg),
                      border: Border.all(color: colors.borderSubtle),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ZenoTable<TrialBalanceLine>(
                      items: items,
                      columns: [
                        ZenoTableColumn(
                            label: "Account",
                            builder: (l) => Text(l.account.name)),
                        ZenoTableColumn(
                            label: "Code",
                            builder: (l) => Text(l.account.code,
                                style:
                                    const TextStyle(fontFamily: 'monospace'))),
                        ZenoTableColumn(
                            label: "Debit",
                            isNumeric: true,
                            builder: (l) => Text(
                                "₹${l.debit.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        ZenoTableColumn(
                            label: "Credit",
                            isNumeric: true,
                            builder: (l) => Text(
                                "₹${l.credit.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
