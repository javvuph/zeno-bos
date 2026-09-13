import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

import '../../domain/models/account.dart' as domain;
import '../../domain/models/account_type.dart';
import '../controllers/finance_controller.dart';
import '../../domain/repositories/i_finance_repository.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'account_form_screen.dart';

class ChartOfAccountsScreen extends StatefulWidget {
  const ChartOfAccountsScreen({super.key});

  @override
  State<ChartOfAccountsScreen> createState() => _ChartOfAccountsScreenState();
}

class _ChartOfAccountsScreenState extends State<ChartOfAccountsScreen> {
  final controller = FinanceController(sl<IFinanceRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    controller.loadChartOfAccounts();
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
    final items = controller.accounts;

    return Column(
      children: [
        ZenoHeader(
          title: "Chart of Accounts".toUpperCase(),
          subtitle:
              "DEFINE AND MANAGE THE FUNDAMENTAL FINANCIAL STRUCTURE OF THE ENTERPRISE.",
          onSearch: (v) {},
          actions: [
            _COAButton(
                label: "Import Template",
                icon: Icons.upload_file_outlined,
                colors: colors,
                onPressed: () {}),
            const SizedBox(width: ZenoSpacing.sm),
            _COAButton(
              label: "New Account",
              icon: Icons.add,
              isPrimary: true,
              colors: colors,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountFormScreen())),
            ),
          ],
        ),
        // STICKY FILTER BAR
        _buildStickyFilters(colors),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                ZenoSpacing.lg, 0, ZenoSpacing.lg, ZenoSpacing.lg),
            child: Container(
              decoration: BoxDecoration(
                color: colors.bgTier2,
                borderRadius: BorderRadius.circular(ZenoRadius.lg),
                border: Border.all(color: colors.borderSubtle),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10)),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: ZenoTable<domain.Account>(
                items: items,
                columns: [
                  ZenoTableColumn(
                    label: "Account Code",
                    width: 140,
                    builder: (a) => Text(a.code,
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(
                                fontWeight: FontWeight.w900,
                                fontFamily: ZenoTypography.monoFamily,
                                letterSpacing: 1)),
                  ),
                  ZenoTableColumn(
                    label: "Account Identity",
                    builder: (a) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(a.name.toUpperCase(),
                            style: ZenoTypography.bodyMD(colors.textPrimary)
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text(a.currency,
                            style: ZenoTypography.micro(colors.textDisabled)),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Fiscal Category",
                    width: 160,
                    builder: (a) => ZenoBadge(
                      label: a.category.name.toUpperCase(),
                      color: _getTypeColor(a.category.name),
                    ),
                  ),
                  ZenoTableColumn(
                    label: "GL Balance",
                    width: 160,
                    isNumeric: true,
                    builder: (a) => Text(
                        "\$${a.currentBalance.toStringAsFixed(2)}",
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(fontWeight: FontWeight.w900)),
                  ),
                  ZenoTableColumn(
                    label: "Status",
                    width: 120,
                    builder: (a) => Row(
                      children: [
                        Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: a.isActive
                                    ? colors.statusSuccess
                                    : colors.textDisabled)),
                        const SizedBox(width: 8),
                        Text(a.isActive ? "ACTIVE" : "INACTIVE",
                            style: ZenoTypography.micro(a.isActive
                                    ? colors.statusSuccess
                                    : colors.textDisabled)
                                .copyWith(fontWeight: FontWeight.w900)),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Actions",
                    width: 80,
                    builder: (a) => IconButton(
                      icon: Icon(Icons.edit_outlined,
                          color: colors.textSecondary, size: 16),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AccountFormScreen(existingAccount: a))),
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

  Widget _buildStickyFilters(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _FilterTab(
              label: "ALL ACCOUNTS",
              count: controller.accounts.length,
              isSelected: true,
              colors: colors),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(
              label: "ASSETS",
              count: controller.accounts
                  .where((a) => a.category == AccountCategory.asset)
                  .length,
              colors: colors),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(
              label: "LIABILITIES",
              count: controller.accounts
                  .where((a) => a.category == AccountCategory.liability)
                  .length,
              colors: colors),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: colors.bgTier3, borderRadius: BorderRadius.circular(6)),
            child: Row(
              children: [
                Icon(Icons.filter_list_rounded,
                    size: 14, color: colors.textSecondary),
                const SizedBox(width: 8),
                Text("ADVANCED FILTERS",
                    style: ZenoTypography.micro(colors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    if (type == "Asset") return const Color(0xFF00D2FF);
    if (type == "Liability") return const Color(0xFFFF9800);
    if (type == "Equity") return const Color(0xFF9D50BB);
    if (type == "Income") return const Color(0xFF38ef7d);
    return const Color(0xFFee0979);
  }
}

class _FilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final ZenoSemanticColors colors;
  const _FilterTab(
      {required this.label,
      required this.count,
      this.isSelected = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,
            style: ZenoTypography.micro(
                    isSelected ? colors.accentPrimary : colors.textDisabled)
                .copyWith(
                    fontWeight:
                        isSelected ? FontWeight.w900 : FontWeight.w600)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
              color: isSelected
                  ? colors.accentPrimary.withValues(alpha: 0.1)
                  : colors.bgTier3,
              borderRadius: BorderRadius.circular(4)),
          child: Text(count.toString(),
              style: ZenoTypography.micro(
                  isSelected ? colors.accentPrimary : colors.textSecondary)),
        ),
      ],
    );
  }
}

class _COAButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _COAButton(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.lg, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
        side: isPrimary ? null : BorderSide(color: colors.borderSubtle),
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconAction({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6)),
      child: Icon(icon, size: 16, color: color),
    );
  }
}
