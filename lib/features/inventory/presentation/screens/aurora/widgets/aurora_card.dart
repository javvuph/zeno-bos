import 'package:flutter/material.dart';

class AuroraCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color accentColor;
  final Widget child;
  final Widget? trailing;

  static const Color kPurplePrimary = Color(0xFF667EEA);
  static const Color kPurpleSecondary = Color(0xFF764BA2);

  const AuroraCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.accentColor = kPurplePrimary,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x14667EEA), Color(0x0D764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x33667EEA)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A667EEA),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: 18,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [kPurplePrimary, kPurpleSecondary],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: accentColor),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: kPurplePrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF666666),
                          ),
                        ),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0x33667EEA)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }
}
