part of '../top_command_bar.dart';

class _AppLauncherGrid extends StatelessWidget {
  const _AppLauncherGrid();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(Icons.grid_view_rounded,
            size: 20, color: colors.accentPrimary),
      ),
    );
  }
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () => NavigationController().navigateTo('dashboard'),
      child: Text(
        "ZENO BOS",
        style: TextStyle(
          color: colors.textPrimary,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          letterSpacing: -0.02 * 16,
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Container(
      width: 1,
      height: 20,
      color: colors.borderSubtle,
    );
  }
}

class _BranchSelector extends StatelessWidget {
  const _BranchSelector();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_rounded,
                size: 14, color: colors.statusSuccess),
            const SizedBox(width: 8),
            Text(
              "Main HQ",
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded,
                size: 14, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }
}

class _OmniSearchVessel extends StatefulWidget {
  final FocusNode focusNode;
  const _OmniSearchVessel({required this.focusNode});

  @override
  State<_OmniSearchVessel> createState() => _OmniSearchVesselState();
}

class _OmniSearchVesselState extends State<_OmniSearchVessel> {
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      setState(() => _isFocused = widget.focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Flexible(
      flex: 10,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 540),
        height: 32,
        decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isFocused ? colors.accentPrimary : colors.borderSubtle,
          ),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                      color: colors.accentPrimary.withValues(alpha: 0.2),
                      blurRadius: 4),
                ]
              : null,
        ),
        child: Row(
          children: [
            const SizedBox(width: 4),
            _HistoryButton(
                icon: Icons.arrow_back_ios_new_rounded,
                tooltip: "In-App Back (Alt + Left)",
                onTap: () => debugPrint("History Back")),
            _HistoryButton(
                icon: Icons.arrow_forward_ios_rounded,
                tooltip: "In-App Forward (Alt + Right)",
                onTap: () => debugPrint("History Forward")),
            const SizedBox(width: 4),
            Container(
              width: 1,
              height: 16,
              color: colors.borderSubtle,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Icon(Icons.search_rounded, size: 16, color: colors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                focusNode: widget.focusNode,
                style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 13,
                    fontFamily: 'Inter'),
                decoration: InputDecoration(
                  hintText: "Search commands, products, customers... (Ctrl+K)",
                  hintStyle:
                      TextStyle(color: colors.textSecondary, fontSize: 13),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: colors.bgTier1,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: colors.borderSubtle),
              ),
              child: Text(
                "⌘K",
                style: TextStyle(
                  color: colors.amberGold,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _HistoryButton(
      {required this.icon, required this.tooltip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          child: Icon(icon, size: 12, color: const Color(0xFF8A92A6)),
        ),
      ),
    );
  }
}
