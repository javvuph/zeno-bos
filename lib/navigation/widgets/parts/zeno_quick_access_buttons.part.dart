part of '../zeno_quick_access_toolbar.dart';

class _ToolbarButton extends StatelessWidget {
  final String label;
  final String? hotkey;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _ToolbarButton({
    required this.label,
    this.hotkey,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: iconColor),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E293B),
                ),
              ),
              if (hotkey != null) ...[
                const SizedBox(width: 6),
                _KbdBadge(text: hotkey!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleTextBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SimpleTextBtn({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF64748B),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
    );
  }
}

class _AIAssistantButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AIAssistantButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.08)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome, size: 13, color: Color(0xFF6366F1)),
              SizedBox(width: 7),
              Text(
                "AI Assistant",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
              ),
              SizedBox(width: 8),
              _KbdBadge(text: "Ctrl+Space"),
            ],
          ),
        ),
      ),
    );
  }
}

class _KbdBadge extends StatelessWidget {
  final String text;
  const _KbdBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }
}

class _ToolbarIconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _ToolbarIconBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
      ),
    );
  }
}

class _CompactBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CompactBadge({required this.label, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Icon(icon, size: 13, color: color),
        ),
      ),
    );
  }
}
