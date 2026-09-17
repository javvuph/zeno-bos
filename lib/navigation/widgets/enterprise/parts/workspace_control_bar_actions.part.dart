part of '../workspace_control_bar.dart';

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
        const Text(
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
            color: isActive ? colors.accentPrimary : const Color(0xFF8A92A6),
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
            const _FilterToggle(),
            const SizedBox(width: 8),
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
