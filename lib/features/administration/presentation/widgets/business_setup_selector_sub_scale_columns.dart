import 'package:flutter/material.dart';

class BusinessSetupSubColumn extends StatelessWidget {
  final List<String> items;
  final bool isLocked;
  final bool Function(String) isSubSelected;
  final Function(String) handleSubToggle;

  static const Color _kPurplePrimary = Color(0xFF667EEA);

  const BusinessSetupSubColumn({
    super.key,
    required this.items,
    required this.isLocked,
    required this.isSubSelected,
    required this.handleSubToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x14667EEA), Color(0x0D764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0x33667EEA)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader("SUB-BUSINESS TYPE *"),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = isSubSelected(item);

                return InkWell(
                  onTap: isLocked ? null : () => handleSubToggle(item),
                  borderRadius: BorderRadius.circular(6),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0x1A667EEA) : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isSelected ? _kPurplePrimary : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isSelected,
                          onChanged: isLocked ? null : (_) => handleSubToggle(item),
                          activeColor: _kPurplePrimary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? _kPurplePrimary : const Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x33667EEA))),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kPurplePrimary, Color(0xFF764BA2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: _kPurplePrimary,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessSetupScaleColumn extends StatelessWidget {
  final String selectedScale;
  final bool isLocked;
  final Function(String) onScaleChanged;

  static const Color _kPurplePrimary = Color(0xFF667EEA);

  const BusinessSetupScaleColumn({
    super.key,
    required this.selectedScale,
    required this.isLocked,
    required this.onScaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scaleOptions = [
      {
        "key": "SMALL",
        "title": "⭕ SMALL",
        "subtitle": "1 Store / Village",
      },
      {
        "key": "GROWING",
        "title": "📊 GROWING",
        "subtitle": "2-3 Branches",
      },
      {
        "key": "ENTERPRISE",
        "title": "🏢 ENTERPRISE",
        "subtitle": "Multi-Chain & HQ",
      },
    ];

    return Container(
      height: 380,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x14667EEA), Color(0x0D764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0x33667EEA)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader("BUSINESS SCALE *"),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: scaleOptions.length,
              itemBuilder: (context, index) {
                final option = scaleOptions[index];
                final key = option["key"] as String;
                final title = option["title"] as String;
                final subtitle = option["subtitle"] as String;
                final isSelected = selectedScale.toUpperCase() == key;

                return InkWell(
                  onTap: isLocked ? null : () => onScaleChanged(key),
                  borderRadius: BorderRadius.circular(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0x1A667EEA) : Colors.white,
                      border: Border.all(
                        color: isSelected ? _kPurplePrimary : const Color(0x4D667EEA),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected
                          ? const [
                              BoxShadow(
                                color: Color(0x33667EEA),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              )
                            ]
                          : [],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isSelected ? _kPurplePrimary : const Color(0xFF333333),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF999999),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x33667EEA))),
      ),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kPurplePrimary, Color(0xFF764BA2)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: _kPurplePrimary,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
