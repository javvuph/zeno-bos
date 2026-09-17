part of '../zeno_top_nav_bar.dart';

class _LiveStatusWidget extends StatefulWidget {
  const _LiveStatusWidget();

  @override
  State<_LiveStatusWidget> createState() => _LiveStatusWidgetState();
}

class _LiveStatusWidgetState extends State<_LiveStatusWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Tooltip(
      message: "WebSocket Connected: Real-time sync active",
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: Tween(begin: 0.4, end: 1.0).animate(_pulseController),
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: colors.statusSuccess,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colors.statusSuccess.withValues(alpha: 0.6),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "LIVE DATA",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: Color(0xFFA0A7B8),
              letterSpacing: 0.05 * 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShortcutsButton extends StatefulWidget {
  const _ShortcutsButton();

  @override
  State<_ShortcutsButton> createState() => _ShortcutsButtonState();
}

class _ShortcutsButtonState extends State<_ShortcutsButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: () {
          debugPrint("Opening Shortcuts Modal...");
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered ? colors.bgHover : colors.bgTier3,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.keyboard_outlined,
                  size: 14, color: colors.amberGold),
              const SizedBox(width: 6),
              Text(
                "Shortcuts",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final ZenoMenuCategory category;
  final bool isActive;
  final Function(Offset) onHover;
  final VoidCallback onExit;

  const _NavBarItem({
    required this.category,
    required this.isActive,
    required this.onHover,
    required this.onExit,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  String _getDisplayLabel(String label) {
    if (label == "Procurement") return "PROCURE";
    if (label == "Human Resources") return "HR";
    if (label == "HR & Payroll") return "HR";
    if (label == "Finance & Accounting") return "FINANCE";
    if (label == "Finance & Expenses") return "FINANCE";
    if (label == "Reports & Analytics") return "REPORTS";
    if (label == "AI Centre") return "AI";
    if (label == "Admin") return "ADMIN";
    return label;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    final textColor = widget.isActive
        ? colors.accentPrimary
        : (_isHovered
            ? colors.textPrimary
            : const Color(0xFFBCC2CF));

    final displayLabel = _getDisplayLabel(widget.category.label);
    final bool hasDropdown = widget.category.hasDropdown;

    return MouseRegion(
      onEnter: (event) {
        if (!mounted) return;
        final renderObject = context.findRenderObject();
        if (renderObject is! RenderBox || !renderObject.hasSize) return;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isHovered) {
            setState(() => _isHovered = true);
          }
        });

        if (hasDropdown) {
          final position = renderObject.localToGlobal(Offset.zero);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onHover(position);
          });
        }
      },
      onExit: (_) {
        if (!mounted) return;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _isHovered) {
            setState(() => _isHovered = false);
          }
          if (hasDropdown) {
            widget.onExit();
          }
        });
      },
      child: GestureDetector(
        onTap: () {
          if (widget.category.columns.isNotEmpty &&
              widget.category.columns.first.items.isNotEmpty) {
            final firstItem = widget.category.columns.first.items.first;
            if (firstItem.route != null) {
              NavigationController().navigateTo(firstItem.route!);
            }
          }
        },
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.isActive
                ? colors.accentPrimary.withValues(alpha: 0.08)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color:
                    widget.isActive ? colors.accentPrimary : Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_isHovered && !widget.isActive)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: colors.bgHover,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    displayLabel.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 13,
                        color: Colors.transparent,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.03 * 13),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayLabel.toUpperCase() + (hasDropdown ? " ▾" : ""),
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        letterSpacing: 0.03 * 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
