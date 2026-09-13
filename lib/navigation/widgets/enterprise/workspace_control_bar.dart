import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/controllers/personalized_dashboard_cubit.dart';
import 'package:zeno/features/home/presentation/widgets/dashboard/widget_library_dialog.dart';

class WorkspaceControlBar extends StatelessWidget {
  const WorkspaceControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      height: 48, // Spec: Fixed 48px
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.bgTier4, // Deep Matte Base (#0D0F17)
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT COLUMN: WORKSPACE TITLE
          const _WorkspaceTitle(),

          // CENTER COLUMN: GLOBAL DATE FILTER ENGINE
          const _GlobalDateEngine(),

          // RIGHT COLUMN: ACTIONS
          _ActionCluster(),
        ],
      ),
    );
  }
}

class _WorkspaceTitle extends StatelessWidget {
  const _WorkspaceTitle();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "EXECUTIVE COMMAND CENTER",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            color: colors.textPrimary,
          ),
        ),
        Text(
          "Real-Time Enterprise Intelligence & Workspaces",
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            color: Color(0xFF8A92A6),
          ),
        ),
      ],
    );
  }
}

class _GlobalDateEngine extends StatefulWidget {
  const _GlobalDateEngine();

  @override
  State<_GlobalDateEngine> createState() => _GlobalDateEngineState();
}

class _GlobalDateEngineState extends State<_GlobalDateEngine> {
  String _activePreset = "Month";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Row(
      children: [
        // Preset Pills
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: colors.bgTier1,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPresetPill("Today", colors),
              _buildPresetPill("Week", colors),
              _buildPresetPill("Month", colors),
              _buildPresetPill("QTD", colors),
              _buildPresetPill("YTD", colors),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Custom Date Range (FROM / TO)
        _ExplicitDateSelector(
            label: "FROM", date: "Jul 01, 2026", colors: colors),
        const SizedBox(width: 4),
        _ExplicitDateSelector(
            label: "TO", date: "Jul 28, 2026", colors: colors),
      ],
    );
  }

  Widget _buildPresetPill(String label, ZenoSemanticColors colors) {
    final isActive = _activePreset == label;
    return GestureDetector(
      onTap: () => setState(() => _activePreset = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive
              ? colors.accentPrimary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isActive
                ? colors.accentPrimary.withValues(alpha: 0.3)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: isActive ? colors.accentPrimary : Color(0xFF8A92A6),
          ),
        ),
      ),
    );
  }
}

class _ExplicitDateSelector extends StatelessWidget {
  final String label;
  final String date;
  final ZenoSemanticColors colors;

  const _ExplicitDateSelector({
    required this.label,
    required this.date,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today_rounded,
              size: 12, color: colors.textSecondary),
          const SizedBox(width: 6),
          Text(
            "$label:",
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: colors.textSecondary,
                fontFamily: 'Inter'),
          ),
          const SizedBox(width: 6),
          Text(
            date,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
                fontFamily: 'Inter'),
          ),
          const SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down_rounded,
              size: 14, color: colors.textSecondary),
        ],
      ),
    );
  }
}

class _ActionCluster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Row(
          children: [
            // FILTER BUTTON
            const _FilterToggle(),
            const SizedBox(width: 8),

            // ADD WIDGET BUTTON
            SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await showDialog<String>(
                    context: context,
                    builder: (context) => const WidgetLibraryDialog(),
                  );
                  if (result != null && context.mounted) {
                    context.read<DashboardCubit>().addWidget(result);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: colors.bgTier1,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: const Text(
                  "+ ADD WIDGET",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter'),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // EDIT LAYOUT BUTTON
            SizedBox(
              height: 32,
              child: OutlinedButton(
                onPressed: () =>
                    context.read<DashboardCubit>().toggleEditMode(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: state.isEditMode
                      ? colors.accentPrimary.withValues(alpha: 0.1)
                      : colors.bgTier3,
                  foregroundColor: state.isEditMode
                      ? colors.accentPrimary
                      : colors.textPrimary,
                  side: BorderSide(
                      color: state.isEditMode
                          ? colors.accentPrimary
                          : colors.borderSubtle),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
                child: Text(
                  state.isEditMode ? "FINISH" : "EDIT LAYOUT",
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter'),
                ),
              ),
            ),
            if (state.isEditMode) ...[
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.refresh_rounded,
                    size: 18, color: Colors.red),
                tooltip: "Reset to Default",
                onPressed: () => _confirmReset(context),
              ),
            ],
          ],
        );
      },
    );
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Reset Dashboard?"),
        content: const Text(
            "This will revert all customizations to the system default layout."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL")),
          ElevatedButton(
            onPressed: () {
              context.read<DashboardCubit>().resetToDefault();
              Navigator.pop(context);
            },
            child: const Text("RESET NOW"),
          ),
        ],
      ),
    );
  }
}

class _FilterToggle extends StatefulWidget {
  const _FilterToggle();

  @override
  State<_FilterToggle> createState() => _FilterToggleState();
}

class _FilterToggleState extends State<_FilterToggle> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleMenu() {
    if (_isOpen) {
      _closeMenu();
    } else {
      _openMenu();
    }
  }

  void _openMenu() {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    _overlayEntry = _createOverlayEntry(colors);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  OverlayEntry _createOverlayEntry(ZenoSemanticColors colors) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 520,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 40),
          child: Material(
            color: Colors.transparent,
            child: _FilterPanel(onClose: _closeMenu, colors: colors),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleMenu,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: _isOpen
                ? colors.accentPrimary.withValues(alpha: 0.08)
                : colors.bgTier3,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: _isOpen ? colors.accentPrimary : colors.borderSubtle),
          ),
          child: Row(
            children: [
              Icon(Icons.menu_rounded,
                  size: 14,
                  color: _isOpen ? colors.accentPrimary : colors.textPrimary),
              const SizedBox(width: 8),
              Text(
                "FILTERS",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: _isOpen ? colors.accentPrimary : colors.textPrimary,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(width: 6),
              Icon(
                _isOpen
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 14,
                color: _isOpen ? colors.accentPrimary : colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterPanel extends StatelessWidget {
  final VoidCallback onClose;
  final ZenoSemanticColors colors;

  const _FilterPanel({required this.onClose, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.bgTier2, // #131722
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 40,
              offset: const Offset(0, 16)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // GRID LAYOUT (3 COLUMNS)
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildFilterGroup("BRANCH / LOCATION", "All Branches"),
                    _buildFilterGroup("DEPARTMENT", "Executive & Ops"),
                    _buildFilterGroup("SALES CHANNEL", "Online & Direct Sales"),
                    _buildFilterGroup("CURRENCY", "USD (\$) - Default"),
                    _buildFilterGroup("SORT ORDER", "Highest Revenue"),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFF1B1E2B)),
                const SizedBox(height: 12),

                // FOOTER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "🔄 Reset Defaults",
                        style: TextStyle(
                            color: Color(0xFFFF4D4D),
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: onClose,
                          child: const Text("Cancel",
                              style: TextStyle(
                                  color: Color(0xFF8A92A6), fontSize: 11)),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: onClose,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.accentPrimary,
                            foregroundColor: Colors.black,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            minimumSize: Size.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Text("⚡ APPLY FILTERS",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterGroup(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8A92A6),
                letterSpacing: 0.2)),
        const SizedBox(height: 4),
        Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: colors.bgTier1,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value,
                  style: const TextStyle(fontSize: 11, color: Colors.white)),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 14, color: Color(0xFF8A92A6)),
            ],
          ),
        ),
      ],
    );
  }
}
