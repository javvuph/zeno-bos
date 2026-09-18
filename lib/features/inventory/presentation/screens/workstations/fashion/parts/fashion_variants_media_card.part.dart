part of '../fashion_variants_tab.dart';

extension _FashionVariantsTabMediaState on _FashionVariantsTabState {
  Widget _buildColourMediaLibraryCard() {
    final activeColor = controller.activeMediaColor ?? (controller.selectedColors.isNotEmpty ? controller.selectedColors.first : "Red");
    final activeAssets = controller.getColorMedia(activeColor);
    final previewAssets = activeAssets.take(4).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Image Generation Header
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 16, color: Color(0xFF667EEA)),
                    SizedBox(width: 6),
                    Text(
                      'AI Image Generation',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Powered by ', style: TextStyle(fontSize: 9, color: Colors.grey)),
                    Text('Google', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF4285F4))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Steps Indicator
            Row(
              children: [
                _buildStepPill('1', 'Upload', true),
                Expanded(child: Container(height: 1, color: Colors.grey.shade200)),
                _buildStepPill('2', '4 Angles', false),
                Expanded(child: Container(height: 1, color: Colors.grey.shade200)),
                _buildStepPill('3', 'Review', false),
              ],
            ),
            const SizedBox(height: 14),

            // Source Image Card
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFFAFBFF),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Source Image (Mandatory)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF667EEA).withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xFFF5F7FF),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_upload_outlined, color: Color(0xFF667EEA), size: 20),
                            SizedBox(height: 2),
                            Text('Click to upload', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF667EEA))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F6FF),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: const Color(0xFFD9DFF2)),
                          ),
                          child: const Text(
                            'Upload one photo from any angle. ZENO AI will use it as the source image for the selected colour workflow.',
                            style: TextStyle(fontSize: 9, height: 1.35, color: Color(0xFF64748B)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Colors selector header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Colours (${controller.selectedColors.length} selected)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                const Text('Select All', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF667EEA))),
              ],
            ),
            const SizedBox(height: 8),

            // The media workspace follows the single active colour selected in the left attributes panel.
            _buildActiveColourChip(activeColor),
            const SizedBox(height: 14),

            // AI generation action: one source photo -> angle workflow for the selected colour set.
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF7C3AED)],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.22),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: _aiGenerating
                    ? null
                    : () async {
                        setState(() => _aiGenerating = true);
                        try {
                          await controller.aiGenerateForNewSpaces(context);
                        } finally {
                          if (context.mounted) setState(() => _aiGenerating = false);
                        }
                      },
                icon: _aiGenerating
                    ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.auto_awesome_rounded, size: 15, color: Colors.white),
                label: Text(
                  _aiGenerating ? 'AI IS GENERATING • PLEASE WAIT' : 'AI GENERATE 4 ANGLES • ALL COLOURS',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 0.2),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  disabledBackgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: _aiGenerating
                    ? const Color(0xFF06B6D4).withValues(alpha: 0.08)
                    : const Color(0xFFF3F6FF),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  color: _aiGenerating
                      ? const Color(0xFF06B6D4).withValues(alpha: 0.35)
                      : const Color(0xFFD9DFF2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _aiGenerating ? Icons.sync_rounded : Icons.auto_awesome_rounded,
                    size: 14,
                    color: _aiGenerating ? const Color(0xFF06B6D4) : const Color(0xFF6366F1),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      _aiGenerating
                          ? 'AI processing source image → FRONT • BACK • SIDE • DETAIL'
                          : 'AI workflow: 1 source photo → 4 angles → selected colours',
                      style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFF475569)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Colour Media Library Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Colour Media Library', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                _buildActiveColourChip(activeColor, compact: true),
              ],
            ),
            const SizedBox(height: 10),

            // Active Color Media Preview Card
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFBFF),
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: controller.getColorValue(activeColor)),
                          ),
                          const SizedBox(width: 6),
                          Text('$activeColor (4/4)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('Complete', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.green)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildThumbSlot('Front View', previewAssets.isNotEmpty ? previewAssets[0].url : null),
                      const SizedBox(width: 6),
                      _buildThumbSlot('Back View', previewAssets.length > 1 ? previewAssets[1].url : null),
                      const SizedBox(width: 6),
                      _buildThumbSlot('Side View', previewAssets.length > 2 ? previewAssets[2].url : null),
                      const SizedBox(width: 6),
                      _buildThumbSlot('Detail View', previewAssets.length > 3 ? previewAssets[3].url : null),
                    ],
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await controller.uploadColorMedia(activeColor);
                      setState(() {});
                    },
                    icon: const Icon(Icons.add, size: 12, color: Color(0xFF667EEA)),
                    label: const Text('Add More Images Manually', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF667EEA))),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 32),
                      side: BorderSide(color: const Color(0xFF667EEA).withValues(alpha: 0.3)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveColourChip(String colorName, {bool compact = false}) {
    final value = controller.getColorValue(colorName);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 7 : 8, vertical: compact ? 4 : 5),
      decoration: BoxDecoration(
        color: colors.accentPrimary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: colors.accentPrimary.withValues(alpha: 0.42),
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 13 : 16,
            height: compact ? 13 : 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value,
              border: Border.all(
                color: colorName.toLowerCase() == 'white'
                    ? const Color(0xFFD9DFF2)
                    : Colors.black12,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            colorName,
            style: TextStyle(
              fontSize: compact ? 9 : 10,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
            ),
          ),
          if (!compact) ...[
            const SizedBox(width: 5),
            Icon(Icons.check_circle_rounded, size: 13, color: colors.accentPrimary),
          ],
        ],
      ),
    );
  }

  Widget _buildStepPill(String num, String label, bool active) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? const Color(0xFF667EEA) : Colors.grey.shade200,
          ),
          child: Center(
            child: Text(num, style: TextStyle(fontSize: 9, color: active ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 9, fontWeight: active ? FontWeight.bold : FontWeight.normal, color: active ? const Color(0xFF1E293B) : Colors.grey)),
      ],
    );
  }

  Widget _buildThumbSlot(String label, String? imagePath) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
              image: imagePath != null && imagePath.isNotEmpty
                  ? DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover)
                  : null,
            ),
            child: imagePath == null || imagePath.isEmpty
                ? const Center(child: Icon(Icons.image_outlined, size: 16, color: Colors.grey))
                : null,
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 8, color: Color(0xFF64748B)), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
