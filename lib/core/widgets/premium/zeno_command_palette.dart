import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/navigation_models.dart';
import 'package:zeno/navigation/navigation_controller.dart';

part 'parts/zeno_command_palette_results.part.dart';

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
