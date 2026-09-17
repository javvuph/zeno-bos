import 'package:flutter/material.dart';

class StoreSetupModalFooter extends StatelessWidget {
  final int activeTab;
  final int totalSteps;
  final bool isSyncing;
  final VoidCallback onPrevious;
  final VoidCallback onNextOrSave;
  final VoidCallback onCancel;

  static const Color _kPurplePrimary = Color(0xFF667EEA);
  static const Color _kPurpleSecondary = Color(0xFF764BA2);

  const StoreSetupModalFooter({
    super.key,
    required this.activeTab,
    required this.totalSteps,
    required this.isSyncing,
    required this.onPrevious,
    required this.onNextOrSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0x33667EEA))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (activeTab > 0) ...[
            ElevatedButton(
              onPressed: onPrevious,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0x1A667EEA),
                foregroundColor: _kPurplePrimary,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                elevation: 0,
              ),
              child: const Text(
                "← PREVIOUS",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
            const SizedBox(width: 12),
          ] else ...[
            ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0x1A667EEA),
                foregroundColor: _kPurplePrimary,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                elevation: 0,
              ),
              child: const Text(
                "CANCEL",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kPurplePrimary, _kPurpleSecondary],
              ),
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x66667EEA),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: isSyncing ? null : onNextOrSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: isSyncing
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text(
                      "SAVE & SYNC CONFIGURATION",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
