import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';

import '../../domain/models/supplier.dart' as domain;
import '../controllers/supplier_controller.dart';
import '../../domain/repositories/i_supplier_repository.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'supplier_form_screen.dart';

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  final controller = SupplierController(sl<ISupplierRepository>());
  String _searchQuery = "";
  bool _showDeleted = false;

  @override
  void initState() {
    super.initState();
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

  void _addSupplier() {
    showDialog(
      context: context,
      builder: (context) => const SupplierFormScreen(),
    );
  }

  void _editSupplier(domain.Supplier supplier) {
    showDialog(
      context: context,
      builder: (context) => SupplierFormScreen(supplier: supplier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems =
        (_showDeleted ? controller.deletedSuppliers : controller.suppliers)
            .where((s) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return s.name.toLowerCase().contains(q) ||
          s.email.toLowerCase().contains(q) ||
          s.category.toLowerCase().contains(q);
    }).toList();

    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "Supplier Directory".toUpperCase(),
          subtitle:
              "MANAGE VENDOR RELATIONS, CONTACT DATA, AND ACTIVE ACCOUNTS.",
          onSearch: (v) => setState(() => _searchQuery = v),
          actions: [
            _ActionBtn(label: "EXPORT DIRECTORY", colors: colors),
            const SizedBox(width: ZenoSpacing.sm),
            _ActionBtn(
              label: "NEW SUPPLIER",
              colors: colors,
              isPrimary: true,
              onPressed: _addSupplier,
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
              child: ZenoTable<domain.Supplier>(
                items: filteredItems,
                columns: [
                  ZenoTableColumn(
                    label: "Supplier Identity",
                    builder: (s) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(s.name.toUpperCase(),
                            style: ZenoTypography.bodyMD(colors.textPrimary)
                                .copyWith(fontWeight: FontWeight.w900)),
                        Text(s.id,
                            style: ZenoTypography.micro(colors.textSecondary)
                                .copyWith(
                                    fontFamily: ZenoTypography.monoFamily)),
                      ],
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Industry Category",
                    width: 180,
                    builder: (s) => Text(s.category.toUpperCase(),
                        style: ZenoTypography.caption(colors.textSecondary)),
                  ),
                  ZenoTableColumn(
                    label: "Contact Point",
                    builder: (s) => Text(s.email.toLowerCase(),
                        style: ZenoTypography.caption(colors.accentPrimary)
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                  ZenoTableColumn(
                    label: "Outstanding",
                    width: 140,
                    isNumeric: true,
                    builder: (s) => Text("\$0.00",
                        style: ZenoTypography.bodyMD(colors.textPrimary)
                            .copyWith(fontWeight: FontWeight.w900)),
                  ),
                  ZenoTableColumn(
                    label: "Status",
                    width: 150,
                    builder: (s) => ZenoBadge(
                      label: s.isPreferred ? "PREFERRED" : "ACTIVE",
                      color: s.isPreferred
                          ? const Color(0xFFFFD700)
                          : const Color(0xFF38ef7d),
                    ),
                  ),
                  ZenoTableColumn(
                    label: "Actions",
                    width: 150,
                    builder: (s) => Row(
                      children: [
                        if (!_showDeleted) ...[
                          _IconAction(
                              icon: Icons.menu_book_outlined,
                              color: colors.textSecondary),
                          const SizedBox(width: 8),
                          _IconAction(
                            icon: Icons.edit_outlined,
                            color: colors.textSecondary,
                            onPressed: () => _editSupplier(s),
                          ),
                          const SizedBox(width: 8),
                          _IconAction(
                            icon: Icons.delete_outline,
                            color: colors.statusDanger,
                            onPressed: () => controller.deleteSupplier(s.id),
                          ),
                        ] else ...[
                          _IconAction(
                            icon: Icons.restore_outlined,
                            color: colors.statusSuccess,
                            onPressed: () => controller.restoreSupplier(s.id),
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
            label: "ALL VENDORS",
            count: controller.suppliers.length,
            isSelected: !_showDeleted,
            colors: colors,
            onTap: () => setState(() => _showDeleted = false),
          ),
          const SizedBox(width: ZenoSpacing.lg),
          _FilterTab(
            label: "TRASH / DELETED",
            count: controller.deletedSuppliers.length,
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
