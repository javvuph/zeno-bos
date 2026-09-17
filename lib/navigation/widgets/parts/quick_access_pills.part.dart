part of '../quick_access_workspace.dart';

class _TactileActionPill extends StatefulWidget {
  final String label;
  final String? hotkey;
  final IconData icon;
  final Color iconColor;
  final bool isAI;
  final VoidCallback onTap;

  const _TactileActionPill({
    required this.label,
    this.hotkey,
    required this.icon,
    required this.iconColor,
    this.isAI = false,
    required this.onTap,
  });

  @override
  State<_TactileActionPill> createState() => _TactileActionPillState();
}

class _TactileActionPillState extends State<_TactileActionPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.iconColor.withValues(alpha: 0.2)
                : widget.iconColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widget.iconColor.withValues(alpha: _isHovered ? 0.6 : 0.3),
              width: _isHovered ? 1.2 : 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                        color: widget.iconColor.withValues(alpha: 0.2),
                        blurRadius: 4,
                        spreadRadius: 0),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isAI)
                ShaderMask(
                  shaderCallback: (bounds) =>
                      ZenoTheme.aiVioletGradient.createShader(bounds),
                  child: Icon(widget.icon, size: 14, color: Colors.white),
                )
              else
                Icon(widget.icon, size: 14, color: widget.iconColor),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              if (widget.hotkey != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: colors.bgTier1.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: colors.borderSubtle.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    widget.hotkey!,
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      color: colors.accentPrimary,
                    ),
                  ),
                ),
              ],
              if (widget.isAI) ...[
                const SizedBox(width: 6),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      ZenoTheme.aiVioletGradient.createShader(bounds),
                  child: const Text(
                    "AI",
                    style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _VerticalDivider({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 16, color: colors.borderSubtle);
  }
}

class _ManageButton extends StatefulWidget {
  final VoidCallback onTap;
  const _ManageButton({required this.onTap});

  @override
  State<_ManageButton> createState() => _ManageButtonState();
}

class _ManageButtonState extends State<_ManageButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: _isHovered ? colors.bgHover : colors.bgTier2,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: colors.borderSubtle),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "MANAGE",
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: _isHovered
                      ? colors.textPrimary
                      : Colors.white.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.settings_outlined,
                  size: 14,
                  color:
                      _isHovered ? colors.accentPrimary : colors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
