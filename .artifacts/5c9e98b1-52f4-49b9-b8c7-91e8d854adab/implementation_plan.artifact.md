# Rebuild Variants UI for Fashion

Rebuild the UI of the VARIANTS tab specifically for the Fashion clothing business, focusing on a clean, compact, and professional design with automatic variant generation.

## Proposed Changes

### [Inventory Feature]

#### [MODIFY] [fashion_variants_tab.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/workstations/fashion/fashion_variants_tab.dart)
- Reorganize the layout to have a dedicated **SIZE ROW** and **COLOUR ROW**.
- Implement **Size Chips** that update dynamically based on the selected Size System.
- Implement **Colour Swatches** (dots) with selection states.
- Ensure the "+ Add Colour" functionality is preserved.
- Remove the separate "COLOUR SELECTION" and "SIZE SELECTION" cards and merge them into a single, clean header area to save space.

#### [MODIFY] [variant_matrix.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/workstations/variant_matrix.dart)
- Simplify the action toolbar to be more compact.
- Ensure the list remains the only scrollable area.

#### [MODIFY] [variant_matrix_row.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/workstations/widgets/variant_matrix_row.dart)
- Redesign the row to be a compact "card" or "row".
- Add **Numbering** (e.g., `[1]`, `[2]`).
- Arrange fields horizontally: `Index | Colour | Size | SKU | Barcode | Stock | Price`.
- Use compact input fields to maximize visibility.

#### [MODIFY] [product_studio_controller_variants.part.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/controllers/parts/product_studio_controller_variants.part.dart)
- Ensure `generateMatrix` is robust and called whenever size or colour selection changes.
- (Optional) Enhance `getColorValue` to support common fashion colours if missing.

## Verification Plan

### Automated Tests
- N/A (UI focused task, manual verification is primary)

### Manual Verification
- Deploy the app and navigate to the VARIANTS tab in a Fashion product.
- Select multiple sizes and verify they appear as chips.
- Change the Size System and verify the chips update.
- Select multiple colours and verify the swatches remain highlighted.
- Add a custom colour and verify it works.
- Verify that combinations are automatically generated in the list below.
- Verify that removing a size or colour removes the corresponding combinations.
- Check the layout of each variant row: [Index] Colour | Size | SKU | Barcode | Stock | Price.
- Ensure the outer viewport is fixed and only the list scrolls.
- Verify the overall aesthetic is "Professional Fashion POS".
