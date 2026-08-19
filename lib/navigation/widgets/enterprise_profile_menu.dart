import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/app/zeno_theme_controller.dart';

class ZenoEnterpriseProfileMenu extends StatelessWidget {
  const ZenoEnterpriseProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ZenoThemeController();

    return Material(
      color: Colors.transparent,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: ZenoTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ZenoTheme.border),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.5), blurRadius: 30)
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildUserHeader(),
            const Divider(height: 1, color: ZenoTheme.border),
            _buildActionItem(Icons.person_outline, "My Profile",
                "Manage your personal settings"),
            _buildActionItem(Icons.security_outlined, "Security & Privacy",
                "Passwords, 2FA and sessions"),
            _buildActionItem(
                Icons.language_outlined, "Language", "English (UK)",
                trailing: const Icon(Icons.chevron_right, size: 14)),
            const Divider(height: 1, color: ZenoTheme.border),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.dark_mode_outlined,
                      size: 18, color: ZenoTheme.textSecondary),
                  const SizedBox(width: 16),
                  const Text("Appearance", style: TextStyle(fontSize: 12)),
                  const Spacer(),
                  Switch(
                    value: theme.themeMode == ZenoThemeMode.dark ||
                        theme.themeMode == ZenoThemeMode.highContrast,
                    onChanged: (v) => theme.setThemeMode(
                        v ? ZenoThemeMode.dark : ZenoThemeMode.light),
                    activeThumbColor: ZenoTheme.accent,
                  ),
                ],
              ),
            ),
            _buildActionItem(Icons.help_outline, "Help & Support",
                "Knowledge base and support tickets"),
            const Divider(height: 1, color: ZenoTheme.border),
            _buildActionItem(Icons.logout, "Sign Out", null,
                isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: ZenoTheme.accent.withValues(alpha: 0.2),
            child: const Text("AR",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ZenoTheme.accent)),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Alex Rivera",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text("alex.rivera@zenoglobal.com",
                  style:
                      TextStyle(fontSize: 10, color: ZenoTheme.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, String? sub,
      {bool isDestructive = false, Widget? trailing}) {
    return ListTile(
      leading: Icon(icon,
          size: 18,
          color: isDestructive ? Colors.redAccent : ZenoTheme.textSecondary),
      title: Text(label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDestructive ? Colors.redAccent : ZenoTheme.textPrimary)),
      subtitle: sub != null
          ? Text(sub,
              style:
                  const TextStyle(fontSize: 9, color: ZenoTheme.textSecondary))
          : null,
      trailing: trailing,
      onTap: () {},
    );
  }
}
