part of '../fashion_variants_tab.dart';

extension _FashionVariantsTabAttrCardState on _FashionVariantsTabState {
  Widget _buildVariantAttributesCard(BuildContext context) {
    final availableSizes = controller.getSizesForType(controller.sizeType);
    final availableColors = controller.availableColors;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header & Size System Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Variant Attributes',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
              ),
              Row(
                children: [
                  const Text('SIZE SYSTEM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF64748B))),
                  const SizedBox(width: 6),
                  Container(
                    height: 26,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<VariantSizeType>(
                        value: controller.sizeType,
                        items: VariantSizeType.values.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString().split('.').last.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                        )).toList(),
                        onChanged: (v) => setState(() => controller.setSizeType(v ?? VariantSizeType.alpha)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Perfectly Aligned Parallel Vertical Columns for Sizes & Colours (32x32 px buttons, unclipped labels)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Labels Column (Unclipped, clean visibility)
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: SizedBox(
                        width: 65,
                        child: Text('Sizes', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                      ),
                    ),
                    SizedBox(height: 38),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 65,
                        child: Text('Colours', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF64748B))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                // Parallel Vertical Columns
                ...List.generate(
                  math.max(availableSizes.length + 1, availableColors.length + 1),
                  (i) {
                    final hasSize = i < availableSizes.length;
                    final isAddSize = i == availableSizes.length;
                    final hasColor = i < availableColors.length;
                    final isAddColor = i == availableColors.length;

                    Widget sizeWidget;
                    if (hasSize) {
                      final size = availableSizes[i];
                      final isSelected = controller.selectedSizes.contains(size);
                      sizeWidget = InkWell(
                        onTap: () => setState(() => controller.toggleSize(size)),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF667EEA) : const Color(0xFFCBD5E1),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                              color: isSelected ? const Color(0xFF667EEA) : const Color(0xFF1E293B),
                            ),
                          ),
                        ),
                      );
                    } else if (isAddSize) {
                      sizeWidget = InkWell(
                        onTap: () => _showAddDialog(context, "Size", (v, _) => controller.addCustomSize(v)),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFF667EEA).withValues(alpha: 0.4)),
                          ),
                          child: const Center(
                            child: Icon(Icons.add, size: 14, color: Color(0xFF667EEA)),
                          ),
                        ),
                      );
                    } else {
                      sizeWidget = const SizedBox(width: 32, height: 32);
                    }

                    Widget colorWidget;
                    if (hasColor) {
                      final cName = availableColors[i];
                      final isSelected = controller.selectedColors.contains(cName);
                      final colorVal = controller.getColorValue(cName);
                      colorWidget = InkWell(
                        onTap: () => setState(() => controller.toggleColor(cName)),
                        borderRadius: BorderRadius.circular(6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF667EEA) : const Color(0xFFCBD5E1),
                                  width: isSelected ? 2.0 : 1,
                                ),
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: colorVal,
                                  border: Border.all(color: cName.toLowerCase() == 'white' ? Colors.grey.shade300 : Colors.black12),
                                ),
                                child: isSelected
                                    ? const Center(child: Icon(Icons.check, size: 10, color: Colors.white))
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              cName,
                              style: TextStyle(
                                fontSize: 9,
                                color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (isAddColor) {
                      colorWidget = InkWell(
                        onTap: () => _showAddDialog(context, "Colour", (v, col) => controller.addCustomColor(v, col)),
                        borderRadius: BorderRadius.circular(6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFF667EEA).withValues(alpha: 0.4)),
                              ),
                              child: const Center(
                                child: Icon(Icons.add, size: 14, color: Color(0xFF667EEA)),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Add',
                              style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF667EEA)),
                            ),
                          ],
                        ),
                      );
                    } else {
                      colorWidget = const SizedBox(width: 32, height: 32);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          sizeWidget,
                          const SizedBox(height: 12),
                          colorWidget,
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
