part of '../fashion_variants_tab.dart';

extension _FashionVariantsTabDialogsState on _FashionVariantsTabState {
  void _showAddDialog(BuildContext context, String type, Function(String, Color?) onAdd) {
    final textController = TextEditingController();
    Color? selectedPaletteColor = const Color(0xFF6495ED);
    final List<Color> palette = [
      Colors.black, const Color(0xFF000080), Colors.white, Colors.red, Colors.blue, Colors.green,
      Colors.yellow, Colors.orange, Colors.purple, Colors.pink, Colors.brown, Colors.grey,
      Colors.teal, Colors.cyan, Colors.lime, Colors.indigo, Colors.amber, Colors.deepOrange,
      const Color(0xFF6495ED), const Color(0xFFFF69B4), const Color(0xFF8B4513), const Color(0xFF556B2F)
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text("Add Custom $type", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: textController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  labelText: "$type Name",
                  hintText: "e.g. Sky Blue",
                  isDense: true,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                autofocus: true,
              ),
              if (type == "Colour") ...[
                const SizedBox(height: 24),
                const Text("SELECT COLOR PALETTE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueGrey, letterSpacing: 0.5)),
                const SizedBox(height: 12),
                SizedBox(
                  width: 320,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: palette.map((c) {
                      bool isPicked = selectedPaletteColor?.toARGB32() == c.toARGB32();
                      return InkWell(
                        onTap: () => setState(() => selectedPaletteColor = c),
                        child: Container(
                          width: 32, height: 32,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(color: isPicked ? const Color(0xFF3B66F5) : Colors.grey.shade300, width: isPicked ? 3 : 1),
                            boxShadow: isPicked ? [BoxShadow(color: const Color(0xFF3B66F5).withValues(alpha: 0.3), blurRadius: 6)] : null,
                          ),
                          child: isPicked ? const Icon(Icons.check, size: 16, color: Colors.white) : (c == Colors.white ? Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300))) : null),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("CANCEL", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 12))
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  onAdd(textController.text, selectedPaletteColor);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B66F5), 
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text("ADD COLOUR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
