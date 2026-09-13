import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class PersonalWorkspaceScreen extends StatelessWidget {
  const PersonalWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();

    return ListenableBuilder(
      listenable: nav,
      builder: (context, _) {
        final favourites = nav.favourites;
        final recent = nav.recentlyViewed;

        return Container(
          color: ZenoTheme.background,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "PERSONAL WORKSPACE",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2),
                ),
                const Text(
                  "Your customized space for efficient navigation.",
                  style: TextStyle(color: ZenoTheme.textSecondary),
                ),
                const SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          CommandCenterWidget(
                            title: "Favourite Screens",
                            accentColor: Colors.amber,
                            child: favourites.isEmpty
                                ? const _EmptyState(
                                    msg:
                                        "No favourites yet. Pin a tab to see it here.")
                                : Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: favourites
                                        .map((f) => _ShortcutCard(
                                              label: f.title,
                                              icon: f.icon,
                                              color: ZenoTheme.neonCyan,
                                              route: f.route,
                                            ))
                                        .toList(),
                                  ),
                          ),
                          const SizedBox(height: 24),
                          CommandCenterWidget(
                            title: "Pinned Modules",
                            accentColor: ZenoTheme.neonCyan,
                            child: Column(
                              children: const [
                                _PinnedRow(
                                    name: "Warehouse Management",
                                    module: "Inventory",
                                    route: 'inventory/warehouses/list'),
                                _PinnedRow(
                                    name: "Supplier Procurement",
                                    module: "Suppliers",
                                    route: 'suppliers/procurement/dashboard'),
                                _PinnedRow(
                                    name: "Financial Audits",
                                    module: "Finance",
                                    route: 'finance/dashboard'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        children: [
                          CommandCenterWidget(
                            title: "Recently Opened",
                            accentColor: ZenoTheme.neonGreen,
                            child: recent.isEmpty
                                ? const _EmptyState(
                                    msg:
                                        "Your navigation history will appear here.")
                                : Column(
                                    children: recent
                                        .take(5)
                                        .map((r) => _RecentItem(
                                              title: r.title,
                                              time:
                                                  "${DateTime.now().difference(r.viewedAt).inMinutes}m ago",
                                              route: r.route,
                                            ))
                                        .toList(),
                                  ),
                          ),
                          const SizedBox(height: 24),
                          CommandCenterWidget(
                            title: "Personal Notes",
                            accentColor: Colors.orange,
                            trailing: IconButton(
                                icon: const Icon(Icons.add, size: 16),
                                onPressed: () {}),
                            child: Column(
                              children: const [
                                _NoteItem(
                                    text:
                                        "Review supplier contracts by Friday."),
                                _NoteItem(
                                    text: "Prepare for board meeting (Aug 1)."),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String msg;
  const _EmptyState({required this.msg});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 11,
                color: ZenoTheme.textSecondary,
                fontStyle: FontStyle.italic)),
      ),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final String? route;

  const _ShortcutCard(
      {required this.label,
      required this.icon,
      required this.color,
      this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: route != null
          ? () => NavigationController().navigateTo(route!)
          : null,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ZenoTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ZenoTheme.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(label,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _PinnedRow extends StatelessWidget {
  final String name;
  final String module;
  final String? route;

  const _PinnedRow({required this.name, required this.module, this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: route != null
          ? () => NavigationController().navigateTo(route!)
          : null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            Text(module,
                style: const TextStyle(
                    fontSize: 11, color: ZenoTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _RecentItem extends StatelessWidget {
  final String title;
  final String time;
  final String? route;

  const _RecentItem({required this.title, required this.time, this.route});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: route != null
          ? () => NavigationController().navigateTo(route!)
          : null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 13)),
            Text(time,
                style: const TextStyle(
                    fontSize: 11, color: ZenoTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _NoteItem extends StatelessWidget {
  final String text;

  const _NoteItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 4, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 13, color: ZenoTheme.textSecondary))),
        ],
      ),
    );
  }
}
