import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_administration_repository.dart';
import '../controllers/administration_controller.dart';
import 'user_form_screen.dart';
import '../../domain/models/user_security.dart';

class AccessControlScreen extends StatefulWidget {
  const AccessControlScreen({super.key});

  @override
  State<AccessControlScreen> createState() => _AccessControlScreenState();
}

class _AccessControlScreenState extends State<AccessControlScreen> {
  final controller = AdministrationController(sl<IAdministrationRepository>());
  bool _showUsers = true;

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    _loadData();
  }

  Future<void> _loadData() async {
    await controller.refreshDashboard();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Column(
      children: [
        ZenoHeader(
          title: "Access & Security".toUpperCase(),
          subtitle:
              "MANAGE USER ACCOUNTS, RBAC PERMISSIONS, AND SYSTEM SECURITY POLICIES.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                if (_showUsers) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserFormScreen()));
                }
              },
              icon: Icon(
                  _showUsers ? Icons.person_add_alt_1 : Icons.add_moderator),
              label: Text(_showUsers ? "INVITE USER" : "CREATE ROLE"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: Colors.black),
            ),
          ],
        ),
        _buildStickyToggle(colors),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : (_showUsers
                    ? _buildUserGrid(colors)
                    : _buildRoleGrid(colors)),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyToggle(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _ToggleTab(
              label: "USER DIRECTORY",
              isActive: _showUsers,
              colors: colors,
              onTap: () => setState(() => _showUsers = true)),
          const SizedBox(width: ZenoSpacing.lg),
          _ToggleTab(
              label: "RBAC ROLES",
              isActive: !_showUsers,
              colors: colors,
              onTap: () => setState(() => _showUsers = false)),
          const Spacer(),
          _SecurityStatus(colors: colors),
        ],
      ),
    );
  }

  Widget _buildUserGrid(ZenoSemanticColors colors) {
    final users = controller.users;

    return ZenoTable<User>(
      items: users,
      columns: [
        ZenoTableColumn(
          label: "User Identity",
          builder: (u) => Row(
            children: [
              CircleAvatar(
                  radius: 12,
                  backgroundColor: colors.bgTier3,
                  child: Text(u.displayName.isNotEmpty ? u.displayName[0] : 'U',
                      style: const TextStyle(fontSize: 10))),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u.displayName.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12)),
                  Text(u.email,
                      style:
                          TextStyle(color: colors.textSecondary, fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
        ZenoTableColumn(
          label: "Assigned Roles",
          builder: (u) => Wrap(
            spacing: 4,
            children: u.roleIds
                .map((r) => ZenoBadge(
                    label: r.toUpperCase(), color: colors.accentPrimary))
                .toList(),
          ),
        ),
        ZenoTableColumn(
          label: "Account State",
          width: 150,
          builder: (u) => ZenoBadge(
              label: u.status.name.toUpperCase(), color: colors.statusSuccess),
        ),
        ZenoTableColumn(
          label: "Actions",
          width: 100,
          builder: (u) => Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.shield_outlined, size: 16),
                  onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 16),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserFormScreen(existingUser: u))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleGrid(ZenoSemanticColors colors) {
    final roles = controller.roles;

    return ZenoTable<UserRole>(
      items: roles,
      columns: [
        ZenoTableColumn(
          label: "Role Name",
          builder: (r) => Text(r.name.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        ZenoTableColumn(
          label: "Description",
          builder: (r) => Text(r.description,
              style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        ),
        ZenoTableColumn(
          label: "Type",
          width: 150,
          builder: (r) => r.isSystemRole
              ? const ZenoBadge(label: "SYSTEM", color: Colors.blue)
              : const ZenoBadge(label: "CUSTOM", color: Colors.grey),
        ),
        ZenoTableColumn(
          label: "Permissions",
          width: 120,
          isNumeric: true,
          builder: (r) => Text("${r.permissionMatrix.length} ACTIVE",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _ToggleTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final ZenoSemanticColors colors;
  final VoidCallback onTap;
  const _ToggleTab(
      {required this.label,
      required this.isActive,
      required this.colors,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: ZenoTypography.micro(
                      isActive ? colors.accentPrimary : colors.textDisabled)
                  .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1)),
          const SizedBox(height: 4),
          if (isActive)
            Container(width: 40, height: 2, color: colors.accentPrimary),
        ],
      ),
    );
  }
}

class _SecurityStatus extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _SecurityStatus({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: colors.statusSuccess.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(100),
          border:
              Border.all(color: colors.statusSuccess.withValues(alpha: 0.2))),
      child: Row(
        children: [
          Icon(Icons.verified_user, size: 12, color: colors.statusSuccess),
          const SizedBox(width: 8),
          Text("SHIELD PROTOCOL ACTIVE",
              style: ZenoTypography.micro(colors.statusSuccess)
                  .copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
