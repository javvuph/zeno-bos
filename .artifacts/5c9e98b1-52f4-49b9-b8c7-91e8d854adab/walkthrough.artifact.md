# Reconstruction of Variants Tab (Fashion Sector)

The VARIANTS tab has been completely rebuilt to provide a professional, high-density UI tailored for the fashion industry.

## Key Changes

### 1. New Selection Header
- **SIZE ROW**: Available sizes are displayed as selectable chips at the top. The list dynamically updates based on the selected **Size System** (Alpha, Numeric, Kids, etc.).
- **COLOUR ROW**: Direct selection of colours via dot swatches. Multiple colours can be selected, and each remains visibly highlighted with a checkmark and shadow.
- **Dynamic Systems**: Included support for **Kids** (2Y, 4Y, 6Y, 8Y) and extended **Alpha** sizes (S, M, L, XL, XXL, XXXL).

### 2. Automatic Generation
- As sizes and colours are selected, the system automatically generates all combinations (e.g., Black | S, Black | M, Navy | S).
- Removing a size or colour immediately prunes the variant list.

### 3. Compact Variant List
- Each variant is presented in a numbered, high-density row.
- **Horizontal Layout**: `[#] Colour | Size | SKU | Barcode | Stock | Price`.
- Uses compact, styled input fields for quick data entry.
- Professional "Fashion POS" aesthetic with subtle borders and highlights.

### 4. Compact Action Toolbar
- Unified action bar for bulk operations: **SYNC ALL**, **BARCODES**, **PRICE**, and **STOCK**.
- Real-time variant count badge.

### 5. Layout Integrity
- The outer viewport is fixed; only the variant list scrolls internally, ensuring the header controls are always accessible.

## Verification
- [x] Select multiple sizes (chips highlight).
- [x] Change Size System (chips update).
- [x] Select multiple colours (swatches highlight).
- [x] Automatic combination generation in the list.
- [x] Removal of selections updates list.
- [x] Bulk operations (Sync/Barcode) work as expected.
- [x] Individual variant fields (SKU, Price, Stock) are editable.
