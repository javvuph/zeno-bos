import 'package:flutter/material.dart';

class BusinessSetupTheme {
  static const Color primaryPurple = Color(0xFF667EEA);
  static const Color secondaryPurple = Color(0xFF764BA2);
  static const Color accentCyan = Color(0xFF00D4FF);
  static const Color textDark = Color(0xFF333333);
  static const Color textGray = Color(0xFF666666);
  static const Color textMuted = Color(0xFF999999);

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
      border: Border.all(color: const Color(0x33667EEA)),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static BoxDecoration glassPanelDecoration() {
    return BoxDecoration(
      color: const Color(0xF2FFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x5E1F2687),
          blurRadius: 32,
          offset: Offset(0, 8),
        ),
      ],
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
                color: Colors.red,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
