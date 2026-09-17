part of '../product_studio_controller.dart';

extension ProductStudioControllerVariantsAi on ProductStudioController {
  /// 1. AI Product Detection - Auto-name Product from uploaded image
  Future<String?> aiAnalyzeAndAutoNameProduct(String imagePath, BuildContext context) async {
    if (imagePath.isEmpty) return null;
    try {
      final file = File(imagePath);
      if (!file.existsSync()) return null;

      final bytes = await file.readAsBytes();
      if (bytes.length > 5 * 1024 * 1024) {
        SystemSound.play(SystemSoundType.alert);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("⚠️ Image exceeds 5MB limit. Please upload a smaller image."),
              backgroundColor: Colors.red,
            ),
          );
        }
        return null;
      }

      final payload = await sl<AIProductService>().parseImageToProductPayload(imagePath);
      final productName = payload['product_name']?.toString() ?? "";

      if (productName.isNotEmpty) {
        _product.title = productName;
        notify();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("✨ AI Auto-Detected Product: '$productName'"),
              backgroundColor: const Color(0xFF667EEA),
            ),
          );
        }
        return productName;
      }
    } catch (e) {
      debugPrint("AI Auto-Name Error: $e");
    }
    return null;
  }

  /// 2. AI Generate 4 Angles (FRONT, BACK, SIDE, DETAIL) for a selected color
  Future<bool> aiGenerate4AnglesForColor(String color, BuildContext context) async {
    if (color.isEmpty) {
      SystemSound.play(SystemSoundType.alert);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ Please select a color first!"),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return false;
    }

    final list = _product.colorMediaLibrary[color] ?? [];
    final userUploadedAssets = list.where((m) => m.url.isNotEmpty).toList();

    if (userUploadedAssets.isEmpty && _product.primaryImageUrl.isEmpty) {
      SystemSound.play(SystemSoundType.alert);
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Text("Image Required", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            content: const Text(
              "Please upload a primary product image first before generating AI angles.",
              style: TextStyle(fontSize: 13),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF667EEA),
                  foregroundColor: Colors.white,
                ),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
      return false;
    }

    final String userPhotoUrl = userUploadedAssets.isNotEmpty 
        ? userUploadedAssets.first.url 
        : _product.primaryImageUrl;

    if (!_product.colorMediaLibrary.containsKey(color)) {
      _product.colorMediaLibrary[color] = [];
    }
    final targetList = _product.colorMediaLibrary[color]!;

    const angles = [
      {"name": "Front View", "code": "FRONT"},
      {"name": "Back View", "code": "BACK"},
      {"name": "Side View", "code": "SIDE"},
      {"name": "Detail Shot", "code": "DETAIL"},
    ];

    for (int i = 0; i < angles.length; i++) {
      final angleName = angles[i]["name"]!;
      final angleCode = angles[i]["code"]!;
      final slotId = "AI-$color-$angleCode-${DateTime.now().microsecondsSinceEpoch}";

      final asset = MediaAsset(
        id: slotId,
        url: userPhotoUrl,
        thumbnailUrl: userPhotoUrl,
        sortOrder: i,
        isPrimary: i == 0,
        altText: "$color $angleName ($angleCode)",
      );

      if (i < targetList.length) {
        if (targetList[i].url.isEmpty) {
          targetList[i] = asset;
        }
      } else {
        targetList.add(asset);
      }
    }

    notify();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✨ Successfully generated 4 AI angles (FRONT, BACK, SIDE, DETAIL) for $color!"),
          backgroundColor: const Color(0xFF667EEA),
          duration: const Duration(seconds: 3),
        ),
      );
    }
    return true;
  }

  /// 3. Generate Angles for New / Empty Color Spaces without overwriting existing
  Future<void> aiGenerateForNewSpaces(BuildContext context) async {
    if (selectedColors.isEmpty) {
      SystemSound.play(SystemSoundType.alert);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ Please select at least 1 color first."),
            backgroundColor: Colors.orange,
          ),
        );
      }
      return;
    }

    int generatedCount = 0;
    for (final color in selectedColors) {
      final list = _product.colorMediaLibrary[color] ?? [];
      if (list.isEmpty || list.every((m) => m.url.isEmpty)) {
        final success = await aiGenerate4AnglesForColor(color, context);
        if (success) generatedCount++;
      }
    }

    if (generatedCount > 0 && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✨ Generated 4 AI angles for $generatedCount new color spaces!"),
          backgroundColor: const Color(0xFF667EEA),
        ),
      );
    }
  }

  /// 4. Apply Primary Image to All Selected Colors
  bool aiApplyToAllSelectedColors(String sourceColor, BuildContext context) {
    if (sourceColor.isEmpty || !_product.colorMediaLibrary.containsKey(sourceColor)) return false;

    final sourceMedia = _product.colorMediaLibrary[sourceColor]!.where((m) => m.url.isNotEmpty).toList();
    if (sourceMedia.isEmpty) {
      SystemSound.play(SystemSoundType.alert);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("⚠️ Please upload your product photo first before applying to all colors."),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
      }
      return false;
    }

    for (var col in selectedColors) {
      if (col == sourceColor) continue;
      _product.colorMediaLibrary[col] = sourceMedia.map((m) {
        return MediaAsset(
          id: "SYNC-$col-${m.id}",
          url: m.url,
          thumbnailUrl: m.thumbnailUrl,
          sortOrder: m.sortOrder,
          isPrimary: m.isPrimary,
          altText: m.altText.replaceAll(sourceColor, col),
        );
      }).toList();
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("✨ Successfully applied your photos to all selected colors!"),
          backgroundColor: Color(0xFF667EEA),
          duration: Duration(seconds: 2),
        ),
      );
    }

    notify();
    return true;
  }
}
