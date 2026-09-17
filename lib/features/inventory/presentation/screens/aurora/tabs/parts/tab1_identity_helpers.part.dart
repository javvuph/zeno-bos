part of '../tab1_identity.dart';

extension _Tab1IdentityHelpersState on _Tab1IdentityState {
  Widget _buildImageGallery(ZenoSemanticColors colors) {
    final p = controller.product;
    return ZenoImageGallery(
      primaryUrl: p.primaryImageUrl,
      galleryUrls: p.galleryUrls,
      onPickPrimary: controller.pickPrimaryImage,
      onDeletePrimary: controller.deletePrimaryImage,
      onAddToGallery: controller.addToGallery,
      onRemoveGalleryImage: controller.removeGalleryImage,
      onSetGalleryAsPrimary: controller.setGalleryImageAsPrimary,
    );
  }

  void _autoWriteAIDescription(BuildContext context) {
    if (controller.product.title.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a Product Name first!')),
      );
      return;
    }

    final category = controller.product.category.isNotEmpty ? controller.product.category : "Apparel";
    final name = controller.product.title;

    final generated = "Premium $category — $name. Crafted for maximum comfort, durability, and daily elegance. Perfect for casual and modern wear.";
    setState(() {
      controller.updateField(description: generated);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✨ AI generated online shop description!')),
    );
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

  List<String> _withCurrent(List<String> options, String current) {
    if (current.isEmpty || options.contains(current)) return options;
    return [...options, current];
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
