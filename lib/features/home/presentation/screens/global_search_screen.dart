import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _results = [];

  void _onSearch(String query) {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }
    // Accessing the search method from NavigationController (as it has mock search logic)
    final results = NavigationController().search(query);
    setState(() => _results = results);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      color: colors.bgTier1,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "UNIVERSAL INTELLIGENT SEARCH",
            style: ZenoTypography.headlineMD(colors.textPrimary)
                .copyWith(letterSpacing: 1.2),
          ),
          const SizedBox(height: 8),
          Text(
            "Search across modules, records, commands and AI insights.",
            style: ZenoTypography.bodyMD(colors.textSecondary),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: colors.bgTier3,
              borderRadius: BorderRadius.circular(ZenoRadius.md),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              style: ZenoTypography.bodyLG(colors.textPrimary),
              decoration: InputDecoration(
                hintText: "TYPE YOUR SEARCH QUERY...",
                hintStyle: ZenoTypography.caption(colors.textDisabled),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: colors.accentPrimary),
              ),
              onChanged: _onSearch,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _results.isEmpty
                ? _buildEmptyState(colors)
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final result = _results[index];
                      return _SearchResultTile(result: result, colors: colors);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ZenoSemanticColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_outlined, size: 64, color: colors.textDisabled),
          const SizedBox(height: 16),
          Text("NO RESULTS FOUND",
              style: ZenoTypography.caption(colors.textDisabled)),
        ],
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final dynamic result;
  final ZenoSemanticColors colors;

  const _SearchResultTile({required this.result, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ZenoCard(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: () => NavigationController().navigateTo(result.route),
          child: Row(
            children: [
              Icon(result.icon, color: result.color ?? colors.accentPrimary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(result.title,
                        style: ZenoTypography.bodyLG(colors.textPrimary)
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(result.subtitle,
                        style: ZenoTypography.caption(colors.textSecondary)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.textDisabled),
            ],
          ),
        ),
      ),
    );
  }
}
