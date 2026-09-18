part of '../product_studio_screen.dart';

extension _ProductStudioScreenHeaderState on _ProductStudioScreenState {
  Widget _buildSubHeader(ZenoSemanticColors colors) {
    final activeSubCategories = controller.enabledProductTypes;
    final currentSubCategory = controller.activeProfile.isNotEmpty
        ? controller.activeProfile
        : (activeSubCategories.isNotEmpty ? activeSubCategories.first : "Clothing");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(bottom: BorderSide(color: colors.borderSubtle, width: 1)),
      ),
      child: Row(
        children: [
          // Section 1: Title & Category Info
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [colors.accentPurple, colors.accentPrimary]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              Text(
                "Product Studio",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: colors.textPrimary, letterSpacing: -0.3),
              ),
              const SizedBox(width: 16),
              _tagSmall("0%"),
              const SizedBox(width: 6),
              _tagSmall(controller.activeBusiness.toUpperCase()),
              const SizedBox(width: 6),
              _buildSubCategorySelectorSmall(activeSubCategories, currentSubCategory),
              const SizedBox(width: 6),
              _tagSmall(controller.product.businessScale.toString().split('.').last.toUpperCase(), isSuccess: true),
            ],
          ),

          const Spacer(),

          // Section 2: Manual, Bulk & Import
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: colors.bgSurface.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.borderSubtle, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _modeSegmentSmall("SCAN", Icons.qr_code_scanner_rounded, controller.currentMode == ProductCreationMode.bulkScan, () => controller.setCreationMode(ProductCreationMode.bulkScan)),
                const SizedBox(width: 8),
                _utilityButtonSmall(Icons.upload_file_rounded, "IMPORT", () => controller.setCreationMode(ProductCreationMode.bulkScan)),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Section 3: Tools
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.borderSubtle, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _iconToolSmall(Icons.refresh_rounded, () {}),
                const SizedBox(width: 4),
                _iconToolSmall(Icons.fullscreen_rounded, controller.toggleFullscreen),
                const SizedBox(width: 8),
                _advancedToggleSmall(),
              ],
            ),
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
        color: colors.accentPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.accentPrimary.withValues(alpha: 0.20), width: 1),
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
    final bgColor = isSuccess ? colors.statusSuccess.withValues(alpha: 0.10) : colors.accentPrimary.withValues(alpha: 0.08);
    final borderColor = isSuccess ? colors.statusSuccess.withValues(alpha: 0.22) : colors.accentPrimary.withValues(alpha: 0.20);
    final textColor = isSuccess ? colors.statusSuccess : colors.accentPrimary;
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
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.borderSubtle, width: 1),
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
          border: Border.all(color: isActive ? colors.accentPrimary : Colors.transparent, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: isActive ? colors.accentPrimary : colors.textSecondary),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isActive ? colors.accentPrimary : colors.textSecondary, letterSpacing: 0.3)),
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
          border: Border.all(color: colors.borderSubtle, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: colors.accentPrimary),
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
          border: Border.all(color: colors.borderSubtle, width: 1),
        ),
        child: Icon(icon, size: 16, color: icon == Icons.refresh_rounded ? colors.textPrimary : colors.accentPrimary),
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
            activeTrackColor: colors.accentPrimary,
            inactiveTrackColor: colors.bgTier3,
            inactiveThumbColor: Colors.white,
            trackOutlineColor: WidgetStateProperty.resolveWith((states) => colors.borderSubtle),
          ),
        ),
        Text("ADVANCED", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1A2A3A), letterSpacing: 0.3)),
      ],
    );
  }

  Widget _tagSmall(String label, {bool isSuccess = false}) {
    final bgColor = isSuccess ? colors.statusSuccess.withValues(alpha: 0.10) : colors.accentPrimary.withValues(alpha: 0.08);
    final borderColor = isSuccess ? colors.statusSuccess.withValues(alpha: 0.22) : colors.accentPrimary.withValues(alpha: 0.20);
    final textColor = isSuccess ? colors.statusSuccess : colors.accentPrimary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: textColor, letterSpacing: 0.2, textBaseline: TextBaseline.alphabetic)),
    );
  }

  Widget _buildSubCategorySelectorSmall(List<String> activeSubCategories, String currentSubCategory) {
    if (activeSubCategories.length <= 1) {
      return _tagSmall(currentSubCategory.toUpperCase());
    }

    String selectedValue = activeSubCategories.firstWhere(
      (s) => s.toLowerCase() == currentSubCategory.toLowerCase(),
      orElse: () => activeSubCategories.first,
    );

    return Container(
      decoration: BoxDecoration(
        color: colors.accentPrimary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.accentPrimary.withValues(alpha: 0.20), width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedValue,
            isDense: true,
            isExpanded: false,
            icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF0059B3), size: 12),
            style: const TextStyle(
              color: Color(0xFF0059B3),
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 0.2,
              height: 1.0,
            ),
            items: activeSubCategories.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type.toUpperCase()),
              );
            }).toList(),
            onChanged: (newType) {
              if (newType != null) {
                controller.setProfile(controller.activeBusiness, newType);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _modeSegmentSmall(String label, IconData icon, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? colors.accentPrimary : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isActive ? colors.accentPrimary : colors.borderSubtle, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: isActive ? Colors.white : colors.textSecondary),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: isActive ? Colors.white : colors.textSecondary, letterSpacing: 0.2)),
          ],
        ),
      ),
    );
  }

  Widget _utilityButtonSmall(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: colors.borderSubtle, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: colors.accentPrimary),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF1A2A3A), letterSpacing: 0.2)),
          ],
        ),
      ),
    );
  }

  Widget _iconToolSmall(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: colors.borderSubtle, width: 0.5),
        ),
        child: Icon(icon, size: 12, color: icon == Icons.refresh_rounded ? colors.textPrimary : colors.accentPrimary),
      ),
    );
  }

  Widget _advancedToggleSmall() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: controller.isAdvancedMode ? colors.accentPrimary : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: controller.isAdvancedMode ? colors.accentPrimary : colors.borderSubtle,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () => controller.toggleViewMode(),
        borderRadius: BorderRadius.circular(6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              controller.isAdvancedMode ? Icons.check_circle_rounded : Icons.settings_rounded,
              size: 12,
              color: controller.isAdvancedMode ? Colors.white : colors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              "ADVANCED",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: controller.isAdvancedMode ? Colors.white : colors.textSecondary,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
