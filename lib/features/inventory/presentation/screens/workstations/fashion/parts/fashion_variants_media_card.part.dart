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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Men\'s Hooded Jacket', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                            const SizedBox(height: 2),
                            const Text('Type: Jacket | Gender: Men\nStyle: Hooded, Casual', style: TextStyle(fontSize: 9, color: Color(0xFF64748B))),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('✓ Auto-filled from image', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.green)),
                            ),
                          ],
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

            // Color Swatches Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.availableColors.map((cName) {
                  final isCurrent = cName == activeColor;
                  final colorVal = controller.getColorValue(cName);
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: InkWell(
                      onTap: () => setState(() => controller.setActiveMediaColor(cName)),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isCurrent ? const Color(0xFF667EEA) : Colors.grey.shade300,
                            width: isCurrent ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorVal,
                                border: Border.all(color: cName.toLowerCase() == 'white' ? Colors.grey.shade300 : Colors.black12),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(cName, style: TextStyle(fontSize: 8, fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 14),

            // Generate 4 Angles Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF667EEA).withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await controller.aiGenerate4AnglesForColor(activeColor, context);
                  if (context.mounted) setState(() {});
                },
                icon: const Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                label: const Text('Generate 4 Angles for All Colours', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Colour Media Library Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Colour Media Library', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                Row(
                  children: [
                    _buildTabChip('All', false),
                    const SizedBox(width: 4),
                    _buildTabChip('$activeColor (4)', true),
                  ],
                ),
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

            // Secondary Action: Apply to all colors
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  controller.aiApplyToAllSelectedColors(activeColor, context);
                  setState(() {});
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F7FF),
                  side: BorderSide(color: const Color(0xFF667EEA).withValues(alpha: 0.3)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                child: Text('Apply $activeColor Photo to All Selected Colours', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF667EEA))),
              ),
            ),
          ],
        ),
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

  Widget _buildTabChip(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF667EEA) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: active ? Colors.white : Colors.grey.shade700)),
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
