import 'package:flutter/material.dart';

class BusinessSetupMainColumn extends StatelessWidget {
  final List<String> items;
  final String selectedMain;
  final bool isLocked;
  final ValueChanged<String> onSearchChanged;
  final Function(String) onMainChanged;
  final Function(String) getCategoryIcon;
  final bool Function(String) isComingSoon;
  final Function(BuildContext) showComingSoonToast;

  static const Color _kPurplePrimary = Color(0xFF667EEA);

  const BusinessSetupMainColumn({
    super.key,
    required this.items,
    required this.selectedMain,
    required this.isLocked,
    required this.onSearchChanged,
    required this.onMainChanged,
    required this.getCategoryIcon,
    required this.isComingSoon,
    required this.showComingSoonToast,
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
          _buildHeader("MAIN BUSINESS *"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0x4D667EEA)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 14, color: Color(0xFF666666)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      onChanged: onSearchChanged,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF333333)),
                      decoration: const InputDecoration(
                        hintText: "Search Category...",
                        hintStyle: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = selectedMain.toUpperCase() == item.toUpperCase();
                final comingSoon = isComingSoon(item);

                return InkWell(
                  onTap: isLocked
                      ? null
                      : (comingSoon
                          ? () => showComingSoonToast(context)
                          : () => onMainChanged(item)),
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
                        Radio<bool>(
                          value: true,
                          groupValue: isSelected ? true : null,
                          onChanged: isLocked || comingSoon
                              ? null
                              : (_) => onMainChanged(item),
                          activeColor: _kPurplePrimary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        const SizedBox(width: 6),
                        Text(getCategoryIcon(item), style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: comingSoon
                                  ? const Color(0xFF999999)
                                  : (isSelected ? _kPurplePrimary : const Color(0xFF333333)),
                            ),
                          ),
                        ),
                        if (comingSoon) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0x1A999999),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Coming Soon',
                              style: TextStyle(
                                fontSize: 9,
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
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
