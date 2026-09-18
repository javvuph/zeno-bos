import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class BusinessSetupTheme {
  static const Color primaryPurple = ZenoTheme.indigo500;
  static const Color secondaryPurple = ZenoTheme.violet500;
  static const Color accentCyan = ZenoTheme.cyan500;
  static const Color textDark = ZenoTheme.auroraLightText;
  static const Color textGray = ZenoTheme.auroraLightSecondaryText;
  static const Color textMuted = Color(0xFF98A3B8);

  static const LinearGradient bgGradient = LinearGradient(
    colors: [primaryPurple, secondaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient formGradient = LinearGradient(
    colors: [Color(0x14667EEA), Color(0x0D764BA2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentBarGradient = LinearGradient(
    colors: [primaryPurple, secondaryPurple],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static BoxDecoration formSectionDecoration() {
    return BoxDecoration(
      gradient: formGradient,
      border: Border.all(color: ZenoTheme.auroraLightBorder),
      borderRadius: BorderRadius.circular(ZenoRadius.md),
    );
  }

  static BoxDecoration glassPanelDecoration() {
    return BoxDecoration(
      color: ZenoTheme.auroraLightSurface.withValues(alpha: 0.95),
      borderRadius: BorderRadius.circular(ZenoRadius.lg),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      boxShadow: ZenoElevation.soft,
    );
  }

  static Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              gradient: accentBarGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: primaryPurple,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  static Widget formLabel(String label, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: textGray,
              letterSpacing: 0.5,
            ),
          ),
          if (isRequired)
            const Text(
              " *",
              style: TextStyle(
                color: ZenoTheme.ruby500,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
