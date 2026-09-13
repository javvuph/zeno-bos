import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';

class ProductSearchPanel extends StatefulWidget {
  const ProductSearchPanel({super.key});

  @override
  State<ProductSearchPanel> createState() => _ProductSearchPanelState();
}

class _ProductSearchPanelState extends State<ProductSearchPanel> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onAdd() {
    if (_searchController.text.isNotEmpty) {
      context.read<BillingStudioController>().add(
            AddItemRequested(_searchController.text),
          );
      _searchController.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoCard(
      title: "PRODUCT ENTRY",
      padding: const EdgeInsets.all(ZenoSpacing.md),
      child: Column(
        children: [
          AnimatedContainer(
            duration: ZenoDuration.fast,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ZenoRadius.md),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                          color: colors.accentPrimary.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 2)
                    ]
                  : [],
            ),
            child: ZenoTextField(
              controller: _searchController,
              focusNode: _focusNode,
              label: "SCAN OR SEARCH",
              hint: "Enter barcode or name...",
              prefix: Icon(Icons.qr_code_scanner,
                  color:
                      _isFocused ? colors.accentPrimary : colors.textDisabled,
                  size: 20),
              onSubmitted: (_) => _onAdd(),
            ),
          ),
          const SizedBox(height: ZenoSpacing.md),
          _buildQuickActionGrid(colors),
          const SizedBox(height: ZenoSpacing.sm),
          _buildShortcutHint(colors),
        ],
      ),
    );
  }

  Widget _buildQuickActionGrid(ZenoSemanticColors colors) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: ZenoSpacing.sm,
      crossAxisSpacing: ZenoSpacing.sm,
      childAspectRatio: 3,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _QuickActionTile(
          label: 'MANUAL ENTRY',
          icon: Icons.keyboard_alt_outlined,
          colors: colors,
          tooltip: 'Manual Product Entry (Ctrl+M)',
        ),
        _QuickActionTile(
          label: 'PRICE CHECK',
          icon: Icons.sell_outlined,
          colors: colors,
          tooltip: 'Quick Price Lookup (Ctrl+P)',
        ),
      ],
    );
  }

  Widget _buildShortcutHint(ZenoSemanticColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info_outline, size: 10, color: colors.textDisabled),
        const SizedBox(width: 4),
        Text(
          'Press ENTER to add item instantly',
          style: ZenoTypography.micro(colors.textDisabled),
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatefulWidget {
  final String label;
  final IconData icon;
  final ZenoSemanticColors colors;
  final String? tooltip;

  const _QuickActionTile({
    required this.label,
    required this.icon,
    required this.colors,
    this.tooltip,
  });

  @override
  State<_QuickActionTile> createState() => _QuickActionTileState();
}

class _QuickActionTileState extends State<_QuickActionTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip ?? '',
      waitDuration: const Duration(milliseconds: 500),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: ZenoDuration.fast,
          decoration: BoxDecoration(
            color: _isHovered ? widget.colors.bgHover : widget.colors.bgTier3,
            borderRadius: BorderRadius.circular(ZenoRadius.sm),
            border: Border.all(
              color: _isHovered
                  ? widget.colors.accentPrimary.withValues(alpha: 0.5)
                  : widget.colors.borderSubtle,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(ZenoRadius.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon,
                      size: 14,
                      color: _isHovered
                          ? widget.colors.accentPrimary
                          : widget.colors.textSecondary),
                  const SizedBox(width: ZenoSpacing.sm),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: _isHovered
                          ? widget.colors.textPrimary
                          : widget.colors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
