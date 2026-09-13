import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/navigation/navigation_controller.dart';
import 'package:zeno/navigation/navigation_models.dart';

class ZenoUniversalSearch extends StatefulWidget {
  const ZenoUniversalSearch({super.key});

  @override
  State<ZenoUniversalSearch> createState() => _ZenoUniversalSearchState();
}

class _ZenoUniversalSearchState extends State<ZenoUniversalSearch> {
  final TextEditingController _controller = TextEditingController();
  List<ZenoSearchResult> _results = [];

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return Material(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          width: 700,
          margin: const EdgeInsets.symmetric(vertical: 100),
          decoration: BoxDecoration(
            color: ZenoTheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ZenoTheme.border),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 40,
                  spreadRadius: 10)
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSearchBar(nav),
              const Divider(height: 1, color: ZenoTheme.border),
              if (_results.isNotEmpty)
                _buildResultsList(nav)
              else if (_controller.text.isEmpty)
                _buildRecentlyViewed(nav)
              else
                _buildEmptyState(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(NavigationController nav) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Icon(Icons.search, size: 24, color: ZenoTheme.accent),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(fontSize: 18),
              decoration: const InputDecoration(
                hintText: "Search invoices, customers, products or modules...",
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (v) {
                setState(() {
                  _results = nav.search(v);
                });
              },
            ),
          ),
          TextButton(
            onPressed: nav.toggleSearch,
            child: const Text("ESC",
                style: TextStyle(color: ZenoTheme.textSecondary, fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(NavigationController nav) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 400),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _results.length,
        itemBuilder: (context, index) {
          final item = _results[index];
          return _SearchResultTile(
            item: item,
            onTap: () {
              nav.openTab(item.route, title: item.title);
              nav.toggleSearch();
            },
          );
        },
      ),
    );
  }

  Widget _buildRecentlyViewed(NavigationController nav) {
    if (nav.recentlyViewed.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Text("Start typing to search...",
            style: TextStyle(color: ZenoTheme.textSecondary)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text("RECENTLY VIEWED",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: ZenoTheme.textSecondary)),
        ),
        ...nav.recentlyViewed.take(5).map((r) => _SearchResultTile(
              item: ZenoSearchResult(
                  title: r.title,
                  subtitle: "Opened recently",
                  icon: r.icon,
                  route: r.route,
                  type: SearchResultType.record),
              onTap: () {
                nav.openTab(r.route, title: r.title);
                nav.toggleSearch();
              },
            )),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 48, color: ZenoTheme.textSecondary),
          SizedBox(height: 16),
          Text("No results found for your query.",
              style: TextStyle(color: ZenoTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: ZenoTheme.background,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      child: const Row(
        children: [
          _KeyGuide(label: "↑↓", desc: "Navigate"),
          SizedBox(width: 16),
          _KeyGuide(label: "ENTER", desc: "Select"),
          SizedBox(width: 16),
          _KeyGuide(label: "ESC", desc: "Close"),
          Spacer(),
          Icon(Icons.auto_awesome, size: 12, color: ZenoTheme.accent),
          SizedBox(width: 8),
          Text("Powered by ZENO AI",
              style: TextStyle(fontSize: 10, color: ZenoTheme.accent)),
        ],
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final ZenoSearchResult item;
  final VoidCallback onTap;

  const _SearchResultTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color:
                (item.color ?? ZenoTheme.textSecondary).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Icon(item.icon,
            size: 18, color: item.color ?? ZenoTheme.textSecondary),
      ),
      title: Text(item.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text(item.subtitle,
          style: const TextStyle(fontSize: 11, color: ZenoTheme.textSecondary)),
      trailing: const Icon(Icons.chevron_right,
          size: 14, color: ZenoTheme.textSecondary),
      onTap: onTap,
    );
  }
}

class _KeyGuide extends StatelessWidget {
  final String label;
  final String desc;
  const _KeyGuide({required this.label, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
              color: ZenoTheme.surface,
              border: Border.all(color: ZenoTheme.border),
              borderRadius: BorderRadius.circular(4)),
          child: Text(label,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 6),
        Text(desc,
            style:
                const TextStyle(fontSize: 9, color: ZenoTheme.textSecondary)),
      ],
    );
  }
}
