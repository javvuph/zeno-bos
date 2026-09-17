part of '../product_studio_screen.dart';

extension _ProductStudioScreenHeaderState on _ProductStudioScreenState {
  Widget _buildSubHeader(ZenoSemanticColors colors) {
    final activeSubCategories = controller.enabledProductTypes;
    final currentSubCategory = controller.activeProfile.isNotEmpty
        ? controller.activeProfile
        : (activeSubCategories.isNotEmpty ? activeSubCategories.first : "Clothing");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4F9),
        border: const Border(bottom: BorderSide(color: Color(0xFFD1E0F0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                "Product Studio",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black, letterSpacing: -0.3),
              ),
              const SizedBox(width: 24),
              _tagCompact("0%"),
              const SizedBox(width: 8),
              _tagCompact(controller.activeBusiness.toUpperCase()),
              const SizedBox(width: 8),
              _buildSubCategorySelector(activeSubCategories, currentSubCategory),
              const SizedBox(width: 8),
              _tagCompact(controller.product.businessScale.toString().split('.').last.toUpperCase(), isSuccess: true),
            ],
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _segmentedModeSelector(),
              const SizedBox(width: 12),
              _utilityButton(Icons.upload_file_rounded, "Import", () => controller.setCreationMode(ProductCreationMode.import)),
              const SizedBox(width: 12),
              _iconTool(Icons.refresh_rounded, () {}),
              const SizedBox(width: 12),
              _iconTool(Icons.fullscreen_rounded, controller.toggleFullscreen),
              const SizedBox(width: 12),
              _advancedToggle(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategorySelector(List<String> activeSubCategories, String currentSubCategory) {
    if (activeSubCategories.length <= 1) {
      return _tagCompact(currentSubCategory.toUpperCase());
    }

    String selectedValue = activeSubCategories.firstWhere(
      (s) => s.toLowerCase() == currentSubCategory.toLowerCase(),
      orElse: () => activeSubCategories.first,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFDCEAF9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFB8D4F0), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF0059B3), size: 16),
          style: const TextStyle(
            color: Color(0xFF0059B3),
            fontWeight: FontWeight.w600,
            fontSize: 12,
            letterSpacing: 0.3,
          ),
          items: activeSubCategories.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF0059B3),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.3,
                ),
              ),
            );
          }).toList(),
          onChanged: (newType) {
            if (newType != null) {
              controller.setProfile(controller.activeBusiness, newType);
            }
          },
        ),
      ),
    );
  }

  Widget _tagCompact(String label, {bool isSuccess = false}) {
    final bgColor = isSuccess ? const Color(0xFFCFF7D3) : const Color(0xFFDCEAF9);
    final borderColor = isSuccess ? const Color(0xFFA3EEB0) : const Color(0xFFB8D4F0);
    final textColor = isSuccess ? const Color(0xFF118A36) : const Color(0xFF0059B3);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor, letterSpacing: 0.3, textBaseline: TextBaseline.alphabetic)),
    );
  }

  Widget _buildProgressBar(double pct) {
    return const SizedBox.shrink(); // Progress bar not in new design
  }

  Widget _segmentedModeSelector() {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4F9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD1E0F0), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _modeSegment("MANUAL", Icons.notes_rounded, controller.currentMode == ProductCreationMode.manual, () => controller.setCreationMode(ProductCreationMode.manual)),
          _modeSegment("SCAN", Icons.qr_code_scanner_rounded, controller.currentMode == ProductCreationMode.scan, () => controller.setCreationMode(ProductCreationMode.scan)),
          _modeSegment("BULK", Icons.layers_rounded, controller.currentMode == ProductCreationMode.bulkScan, () => controller.setCreationMode(ProductCreationMode.bulkScan)),
        ],
      ),
    );
  }

  Widget _modeSegment(String label, IconData icon, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive ? [const BoxShadow(color: Color(0x0D000000), blurRadius: 3, offset: Offset(0, 1))] : null,
          border: Border.all(color: isActive ? const Color(0xFF0073E6) : Colors.transparent, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isActive ? const Color(0xFF0073E6) : const Color(0xFF5F748D)),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isActive ? const Color(0xFF0073E6) : const Color(0xFF5F748D), letterSpacing: 0.3)),
          ],
        ),
      ),
    );
  }

  Widget _utilityButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFD1E0F0), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF0073E6)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1A2A3A), letterSpacing: 0.3)),
          ],
        ),
      ),
    );
  }

  Widget _iconTool(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(icon == Icons.refresh_rounded ? 50 : 8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(icon == Icons.refresh_rounded ? 50 : 8),
          border: Border.all(color: const Color(0xFFD1E0F0), width: 1),
        ),
        child: Icon(icon, size: 16, color: icon == Icons.refresh_rounded ? const Color(0xFF1A2A3A) : const Color(0xFF0073E6)),
      ),
    );
  }

  Widget _advancedToggle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: controller.isAdvancedMode,
            onChanged: (v) => controller.toggleViewMode(),
            activeTrackColor: const Color(0xFF0073E6),
            inactiveTrackColor: const Color(0xFFE2E8F0),
            inactiveThumbColor: Colors.white,
            trackOutlineColor: WidgetStateProperty.resolveWith((states) => const Color(0xFFCBD5E1)),
          ),
        ),
        Text("ADVANCED", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1A2A3A), letterSpacing: 0.3)),
      ],
    );
  }
}
