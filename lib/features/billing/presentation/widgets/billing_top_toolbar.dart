import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/presentation/widgets/zeno_command_vessel.dart';

class BillingTopToolbar extends StatelessWidget {
  const BillingTopToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        return Container(
          height: 64, // Slimmer header
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
          ),
          child: Row(
            children: [
              // 1. BRAND
              _buildBrand(),
              const VerticalDivider(
                  width: 24,
                  indent: 20,
                  endIndent: 20,
                  color: Color(0xFFE2E8F0)),
              _buildTerminalInfo(),

              const Spacer(),

              // 2. COMMAND VESSEL
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZenoCommandVessel(),
                  SizedBox(height: 2),
                  _VesselTags(),
                ],
              ),

              const Spacer(),

              // 3. ACTIONS
              _ToolbarBtn(
                  icon: Icons.undo_rounded,
                  label: "Undo",
                  enabled: state.canUndo),
              _ToolbarBtn(
                  icon: Icons.redo_rounded,
                  label: "Redo",
                  enabled: state.canRedo),
              const SizedBox(width: 8),
              _buildLockToggle(context, state.activeBill.isLocked),

              const VerticalDivider(
                  width: 24,
                  indent: 20,
                  endIndent: 20,
                  color: Color(0xFFE2E8F0)),

              const Icon(Icons.notifications_none_rounded,
                  size: 20, color: Color(0xFF64748B)),
              const SizedBox(width: 12),
              _buildUserProfile(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBrand() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.bolt, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 10),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ZENO BOS",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B),
                    letterSpacing: -0.5)),
            Text("Billing Studio",
                style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildTerminalInfo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TagPill(label: "POS", color: const Color(0xFF6366F1), isSolid: true),
        const SizedBox(width: 6),
        _TagPill(
            label: "Retail Mode",
            color: const Color(0xFF10B981),
            hasDropdown: true),
        const SizedBox(width: 12),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Terminal #104",
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E293B))),
            Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 5),
                SizedBox(width: 4),
                Text("Online",
                    style: TextStyle(
                        fontSize: 8,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLockToggle(BuildContext context, bool isLocked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(isLocked ? Icons.lock_rounded : Icons.lock_open_rounded,
            size: 14, color: const Color(0xFF64748B)),
        const SizedBox(width: 6),
        const Text("Bill Lock",
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B))),
        const SizedBox(width: 4),
        SizedBox(
          height: 20,
          width: 36,
          child: Switch.adaptive(
            value: isLocked,
            onChanged: (v) => context
                .read<BillingStudioController>()
                .add(LockBillRequested(v)),
            activeColor: const Color(0xFF6366F1),
          ),
        ),
      ],
    );
  }

  Widget _buildUserProfile() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
            radius: 12,
            backgroundColor: const Color(0xFFF1F5F9),
            child: const Icon(Icons.person, size: 14, color: Colors.grey)),
        const SizedBox(width: 8),
        const Text("Arjun",
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1E293B))),
        const Icon(Icons.keyboard_arrow_down_rounded,
            size: 14, color: Color(0xFF64748B)),
      ],
    );
  }
}

class _TagPill extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSolid;
  final bool hasDropdown;
  const _TagPill(
      {required this.label,
      required this.color,
      this.isSolid = false,
      this.hasDropdown = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isSolid ? color : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(
                  color: isSolid ? Colors.white : color,
                  fontSize: 9,
                  fontWeight: FontWeight.w900)),
          if (hasDropdown) ...[
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded, size: 12, color: color),
          ],
        ],
      ),
    );
  }
}

class _VesselTags extends StatelessWidget {
  const _VesselTags();
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _Link(label: "+/customer name"),
        _Link(label: "/order id"),
        _Link(label: "/discount"),
        _Link(label: "/hold"),
        _Link(label: "/clear"),
        _Link(label: "/help"),
      ],
    );
  }
}

class _Link extends StatelessWidget {
  final String label;
  const _Link({required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(label,
          style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3B82F6))),
    );
  }
}

class _ToolbarBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  const _ToolbarBtn(
      {required this.icon, required this.label, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          Icon(icon,
              size: 18,
              color:
                  enabled ? const Color(0xFF1E293B) : const Color(0xFFCBD5E1)),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: enabled
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFCBD5E1))),
        ],
      ),
    );
  }
}
