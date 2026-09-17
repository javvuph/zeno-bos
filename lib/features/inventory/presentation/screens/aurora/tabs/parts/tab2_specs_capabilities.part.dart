part of '../tab2_specs.dart';

extension _Tab2SpecsCapabilitiesState on _Tab2SpecsState {
  Widget _capabilityCompactTile(String label, bool value, ValueChanged<bool> onChanged) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: value ? const Color(0x1A667EEA) : Colors.transparent,
          border: Border.all(color: value ? const Color(0xFF667EEA) : const Color(0x33667EEA)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: Checkbox(
                value: value,
                onChanged: (v) => onChanged(v ?? false),
                activeColor: const Color(0xFF667EEA),
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: value ? const Color(0xFF667EEA) : const Color(0xFF666666))),
          ],
        ),
      ),
    );
  }

  bool _hasAnyCapability(ProductStudioData p) => p.capWeighed || p.capPluCode || p.capBulk || p.capRepack || p.capTare || p.capCatchWeight || p.capVariant || p.capDeposit || p.capColdChain || p.capAgeRestriction;

  List<String> _withCurrent(List<String> options, String current) {
    if (current.isEmpty || options.contains(current)) return options;
    return [...options, current];
  }

  Widget _compactSection(String title, ZenoSemanticColors colors, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF667EEA),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  void _showQuickAddDialog(BuildContext context, String type, Function(String) onAdd) {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Add Custom $type", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: textController,
          style: const TextStyle(fontSize: 13),
          decoration: InputDecoration(
            labelText: "$type Name",
            hintText: "Enter $type name",
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11)),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                onAdd(textController.text.trim());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667EEA),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("ADD", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
