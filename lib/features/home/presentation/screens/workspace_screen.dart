import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ZenoHeader(
          title: "Personal Workspace",
          subtitle:
              "Quick access to your draft documents, pinned modules, and private notes.",
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      ZenoCard(
                        title: "DRAFT DOCUMENTS (4)",
                        child: Column(
                          children: [
                            _DraftItem(label: "Q3 Sales Forecast.xlsx"),
                            _DraftItem(
                                label: "Vendor Contract - Apple Inc.pdf"),
                            _DraftItem(label: "Marketing Campaign Ideas.docx"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ZenoCard(
                        title: "PERSONAL NOTES",
                        child: const TextField(
                          maxLines: 5,
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                              hintText: "Type your thoughts here...",
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "FAVOURITE SCREENS",
                    child: Column(
                      children: [
                        _FavItem(
                            label: "Inventory Dashboard",
                            icon: Icons.dashboard_outlined),
                        _FavItem(
                            label: "Sales Reports",
                            icon: Icons.analytics_outlined),
                        _FavItem(
                            label: "Staff Directory",
                            icon: Icons.people_outline),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DraftItem extends StatelessWidget {
  final String label;
  const _DraftItem({required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.edit_note, size: 16, color: ZenoTheme.textSecondary),
          const SizedBox(width: 12),
          Text(label,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.chevron_right,
              size: 14, color: ZenoTheme.textSecondary),
        ],
      ),
    );
  }
}

class _FavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const _FavItem({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 16, color: ZenoTheme.accent),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
