import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

import '../../domain/models/customer.dart' as domain;
import '../../domain/models/customer_tier.dart';
import '../controllers/customer_controller.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'customer_form_screen.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  late final CustomerController controller;
  String _searchQuery = "";
  bool _showDeleted = false;

  @override
  void initState() {
    super.initState();
    controller = sl<CustomerController>();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  void _addCustomer() {
    showDialog(
      context: context,
      builder: (context) => const CustomerFormScreen(),
    );
  }

  void _editCustomer(domain.Customer customer) {
    showDialog(
      context: context,
      builder: (context) => CustomerFormScreen(customer: customer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    final filteredItems =
        (_showDeleted ? controller.deletedCustomers : controller.customers)
            .where((c) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return c.name.toLowerCase().contains(q) ||
          c.email.toLowerCase().contains(q) ||
          c.phone.contains(q);
    }).toList();

    return Column(
      children: [
        ZenoHeader(
          title: "Customer Directory".toUpperCase(),
          subtitle:
              "MANAGE INDIVIDUAL PROFILES, CONTACT DETAILS, AND STRATEGIC SEGMENTATION.",
          onSearch: (v) => setState(() => _searchQuery = v),
          actions: [
            _ActionBtn(label: "EXPORT DIRECTORY", colors: colors),
            const SizedBox(width: ZenoSpacing.sm),
            _ActionBtn(
              label: "ADD CUSTOMER",
              colors: colors,
              isPrimary: true,
              onPressed: _addCustomer,
            ),
          ],
        ),
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
              child: ZenoTable<domain.Customer>(
                items: filteredItems,
                columns: [
                  ZenoTableColumn(
                    label: "Customer Identity",
                    width: 250,
                    builder: (c) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                            radius: 14,
                            backgroundColor: colors.bgTier3,
                            child: Icon(Icons.person_outline,
                                size: 16, color: colors.textPrimary)),
                        const SizedBox(width: ZenoSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(c.name.toUpperCase(),
                                  style:
                                      ZenoTypography.bodyMD(colors.textPrimary)
                                          .copyWith(
                                              fontWeight: FontWeight.w900),
                                  overflow: TextOverflow.ellipsis),
                              Text(c.id,
                                  style:
                                      ZenoTypography.micro(colors.textSecondary)
                                          .copyWith(
                                              fontFamily:
                                                  ZenoTypography.monoFamily),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Traceable Contact",
                    width: 220,
                    builder: (c) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(c.email.toLowerCase(),
                            style: ZenoTypography.caption(colors.textPrimary),
                            overflow: TextOverflow.ellipsis),
                        Text(c.phone,
                            style: ZenoTypography.micro(colors.textSecondary),
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Enterprise Tier",
                    width: 140,
                    builder: (c) => ZenoBadge(
                      label: c.tier.name.toUpperCase(),
                      color: c.tier == CustomerTier.vip
                          ? const Color(0xFFFFD700)
                          : (c.tier == CustomerTier.gold
                              ? const Color(0xFF00D2FF)
                              : colors.textDisabled),
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Total Spent",
                    width: 140,
                    isNumeric: true,
                    builder: (c) => Text(
                        "\$${c.loyalty.totalSpent.toStringAsFixed(0)}",
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(fontWeight: FontWeight.w900)),
                  ),
                  ZenoTableColumn(
                    label: "Operations",
                    width: 200,
                    builder: (c) => Row(
                      children: [
                        if (!_showDeleted) ...[
                          _IconAction(
                            icon: Icons.account_balance_wallet_outlined,
                            color: colors.accentPrimary,
                            onPressed: () => NavigationController().navigateTo(
                                'customers/mgmt/ledger',
                                params: {'customerId': c.id}),
                          ),
                          const SizedBox(width: 8),
                          _IconAction(
                            icon: Icons.star_outline,
                            color: const Color(0xFFFFD700),
                            onPressed: () => NavigationController()
                                .navigateTo('customers/loyalty/points'),
                          ),
                          const SizedBox(width: 8),
                          _IconAction(
                            icon: Icons.edit_outlined,
                            color: colors.textSecondary,
                            onPressed: () => _editCustomer(c),
                          ),
                          const SizedBox(width: 8),
                          _IconAction(
                            icon: Icons.delete_outline,
                            color: colors.statusDanger,
                            onPressed: () => controller.deleteCustomer(c.id),
                          ),
                        ] else ...[
                          _IconAction(
                            icon: Icons.restore_outlined,
                            color: colors.statusSuccess,
                            onPressed: () => controller.restoreCustomer(c.id),
                          ),
                        ],
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
            label: "ALL PROFILES",
            count: controller.customers.length,
            isSelected: !_showDeleted,
            colors: colors,
            onTap: () => setState(() => _showDeleted = false),
          ),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(
            label: "TRASH / DELETED",
            count: controller.deletedCustomers.length,
            isSelected: _showDeleted,
            colors: colors,
            onTap: () => setState(() => _showDeleted = true),
          ),
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
}

class _FilterTab extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final ZenoSemanticColors colors;
  final VoidCallback? onTap;
  const _FilterTab(
      {required this.label,
      required this.count,
      this.isSelected = false,
      required this.colors,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  final bool isPrimary;
  final VoidCallback? onPressed;
  const _ActionBtn(
      {required this.label,
      required this.colors,
      this.isPrimary = false,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.lg, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
      child: Text(label,
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  const _IconAction({required this.icon, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
