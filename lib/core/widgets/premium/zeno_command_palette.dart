import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/navigation_models.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class ZenoCommandPalette extends StatefulWidget {
  const ZenoCommandPalette({super.key});

  @override
  State<ZenoCommandPalette> createState() => _ZenoCommandPaletteState();
}

class _ZenoCommandPaletteState extends State<ZenoCommandPalette> {
  final TextEditingController _queryController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<ZenoSearchResult> _results = [];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _queryController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    setState(() {
      _results = NavigationController().search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 600,
          constraints: const BoxConstraints(maxHeight: 500),
          decoration: BoxDecoration(
            color: colors.bgTier2,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: colors.accentPrimary.withValues(alpha: 0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 40,
                  spreadRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SEARCH INPUT
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.terminal_rounded,
                        color: colors.accentPrimary, size: 24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _queryController,
                        focusNode: _focusNode,
                        onChanged: _onQueryChanged,
                        style: ZenoTypography.headlineSM(colors.textPrimary),
                        decoration: InputDecoration(
                          hintText: "COMMAND OR NAVIGATION...",
                          hintStyle:
                              ZenoTypography.headlineSM(colors.textDisabled),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    _CommandKBadge(colors: colors),
                  ],
                ),
              ),
              const Divider(height: 1),

              // RESULTS
              if (_results.isNotEmpty)
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final result = _results[index];
                      return _ResultItem(result: result, colors: colors);
                    },
                  ),
                )
              else if (_queryController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text("NO MATCHING COMMANDS FOUND",
                      style: ZenoTypography.caption(colors.textDisabled)),
                )
              else
                _buildRecentSuggestions(colors),

              const Divider(height: 1),
              _PaletteFooter(colors: colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentSuggestions(ZenoSemanticColors colors) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("COMMON ACTIONS",
              style: ZenoTypography.micro(colors.textDisabled)),
          const SizedBox(height: 12),
          _QuickCommand(
              label: "Create New Sale",
              icon: Icons.add_shopping_cart,
              colors: colors,
              route: 'billing/studio'),
          _QuickCommand(
              label: "View Inventory",
              icon: Icons.inventory_2_outlined,
              colors: colors,
              route: 'inventory/products/list'),
          _QuickCommand(
              label: "Customer Ledger",
              icon: Icons.people_outline,
              colors: colors,
              route: 'customers/mgmt/list'),
          _QuickCommand(
              label: "AI System Audit",
              icon: Icons.auto_awesome,
              colors: colors,
              route: 'ai/auto/approvals'),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final ZenoSearchResult result;
  final ZenoSemanticColors colors;
  const _ResultItem({required this.result, required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        NavigationController().navigateTo(result.route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(result.icon,
                size: 20, color: result.color ?? colors.textSecondary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result.title.toUpperCase(),
                      style: ZenoTypography.bodyLG(colors.textPrimary)
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(result.subtitle,
                      style: ZenoTypography.micro(colors.textDisabled)),
                ],
              ),
            ),
            _TypeBadge(type: result.type, colors: colors),
          ],
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final SearchResultType type;
  final ZenoSemanticColors colors;
  const _TypeBadge({required this.type, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: colors.bgTier3, borderRadius: BorderRadius.circular(4)),
      child: Text(type.name.toUpperCase(),
          style: ZenoTypography.micro(colors.textDisabled)),
    );
  }
}

class _QuickCommand extends StatelessWidget {
  final String label;
  final IconData icon;
  final ZenoSemanticColors colors;
  final String route;
  const _QuickCommand(
      {required this.label,
      required this.icon,
      required this.colors,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        NavigationController().navigateTo(route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 16, color: colors.textSecondary),
            const SizedBox(width: 12),
            Text(label, style: ZenoTypography.bodyMD(colors.textPrimary)),
          ],
        ),
      ),
    );
  }
}

class _CommandKBadge extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _CommandKBadge({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Text("ESC", style: ZenoTypography.micro(colors.amberGold)),
    );
  }
}

class _PaletteFooter extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _PaletteFooter({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(12))),
      child: Row(
        children: [
          _Hint(label: "ENTER", action: "to select", colors: colors),
          const SizedBox(width: 16),
          _Hint(label: "↑↓", action: "to navigate", colors: colors),
          const Spacer(),
          Text("ZENO NEURAL SEARCH v1.0",
              style: ZenoTypography.micro(colors.textDisabled)),
        ],
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  final String label;
  final String action;
  final ZenoSemanticColors colors;
  const _Hint(
      {required this.label, required this.action, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
              color: colors.bgTier3, borderRadius: BorderRadius.circular(2)),
          child: Text(label, style: ZenoTypography.micro(colors.textPrimary)),
        ),
        const SizedBox(width: 6),
        Text(action, style: ZenoTypography.micro(colors.textDisabled)),
      ],
    );
  }
}
