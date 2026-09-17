part of '../tab2_specs.dart';

extension _Tab2SpecsClothingState on _Tab2SpecsState {
  Widget _buildClothingSmallLayout(ProductStudioData p, ZenoSemanticColors colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _compactSection("CLASSIFICATION", colors, [
                ZenoDropdown<String>(label: "Apparel Category", value: p.apparelCategory.isEmpty ? null : p.apparelCategory, items: _withCurrent(_Tab2SpecsState._apparelCategories, p.apparelCategory).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(apparelCategory: v), onQuickAdd: () => _showQuickAddDialog(context, "Apparel Category", (val) => widget.controller.updateField(apparelCategory: val))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: ZenoDropdown<String>(label: "Gender", value: p.gender.isEmpty ? null : p.gender, items: _withCurrent(_Tab2SpecsState._genderOptions, p.gender).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(gender: v), onQuickAdd: () => _showQuickAddDialog(context, "Gender", (val) => widget.controller.updateField(gender: val)))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoDropdown<String>(label: "Age Group", value: p.targetAgeGroup.isEmpty ? null : p.targetAgeGroup, items: _withCurrent(_Tab2SpecsState._ageGroupOptions, p.targetAgeGroup).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(targetAgeGroup: v), onQuickAdd: () => _showQuickAddDialog(context, "Age Group", (val) => widget.controller.updateField(targetAgeGroup: val)))),
                  ],
                ),
              ]),
              const SizedBox(height: 12),
              _compactSection("COLLECTION & SEASON", colors, [
                Row(
                  children: [
                    Expanded(child: ZenoDropdown<String>(label: "Season", value: p.season.isEmpty ? null : p.season, items: _withCurrent(_Tab2SpecsState._seasonOptions, p.season).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(season: v), onQuickAdd: () => _showQuickAddDialog(context, "Season", (val) => widget.controller.updateField(season: val)))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoDropdown<String>(label: "Collection / Edition", value: p.collectionEdition.isEmpty ? null : p.collectionEdition, items: _withCurrent(_Tab2SpecsState._collectionOptions, p.collectionEdition).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(collectionEdition: v), onQuickAdd: () => _showQuickAddDialog(context, "Collection / Edition", (val) => widget.controller.updateField(collectionEdition: val)))),
                  ],
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _compactSection("FABRIC & MATERIAL", colors, [
                Row(
                  children: [
                    Expanded(child: ZenoDropdown<String>(label: "Material", value: p.material.isEmpty ? null : p.material, items: _withCurrent(_Tab2SpecsState._materialOptions, p.material).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(material: v), onQuickAdd: () => _showQuickAddDialog(context, "Material", (val) => widget.controller.updateField(material: val)))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoTextField(label: "Fabric Composition", initialValue: p.ingredients, onChanged: (v) => widget.controller.updateField(ingredients: v))),
                  ],
                ),
              ]),
              const SizedBox(height: 12),
              _compactSection("DESIGN", colors, [
                Row(
                  children: [
                    Expanded(child: ZenoDropdown<String>(label: "Pattern / Design", value: p.patternDesign.isEmpty ? null : p.patternDesign, items: _withCurrent(_Tab2SpecsState._patternOptions, p.patternDesign).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(patternDesign: v), onQuickAdd: () => _showQuickAddDialog(context, "Pattern / Design", (val) => widget.controller.updateField(patternDesign: val)))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoDropdown<String>(label: "Fit Type", value: p.fitType.isEmpty ? null : p.fitType, items: _withCurrent(_Tab2SpecsState._fitOptions, p.fitType).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(fitType: v), onQuickAdd: () => _showQuickAddDialog(context, "Fit Type", (val) => widget.controller.updateField(fitType: val)))),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: ZenoDropdown<String>(label: "Sleeve Type", value: p.styleCategory.isEmpty ? null : p.styleCategory, items: _withCurrent(_Tab2SpecsState._sleeveOptions, p.styleCategory).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(styleCategory: v), onQuickAdd: () => _showQuickAddDialog(context, "Sleeve Type", (val) => widget.controller.updateField(styleCategory: val)))),
                    const SizedBox(width: 8),
                    Expanded(child: ZenoDropdown<String>(label: "Neck Type", value: p.sleeveNeckType.isEmpty ? null : p.sleeveNeckType, items: _withCurrent(_Tab2SpecsState._neckOptions, p.sleeveNeckType).map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => widget.controller.updateField(sleeveNeckType: v), onQuickAdd: () => _showQuickAddDialog(context, "Neck Type", (val) => widget.controller.updateField(sleeveNeckType: val)))),
                  ],
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: _compactSection("CARE", colors, [
            ZenoTextField(label: "Care Guide", initialValue: p.careGuide, onChanged: (v) => widget.controller.updateField(careGuide: v), maxLines: 6),
          ]),
        ),
      ],
    );
  }
}
