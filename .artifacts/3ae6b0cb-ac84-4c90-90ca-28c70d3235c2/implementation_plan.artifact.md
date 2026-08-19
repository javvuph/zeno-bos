# Implementation Plan - Product Studio Hi-Fi Remake & Stability Fix

The goal is to remake the `ProductStudioScreen` to match the high-fidelity design provided in the image while simultaneously resolving the critical `RenderFlex` layout crash in the header.

## User Review Required

> [!IMPORTANT]
> - **Layout Stability**: I will apply the "Step-by-Step Fix" provided to resolve the `RenderFlex` unbounded width crash in the header. This is the top priority to ensure the screen actually opens.
> - **Design Fidelity**: I will transform the layout to the multi-panel, high-density dashboard seen in the image. This involves a total overhaul of the `ProductStudioScreen` widget tree.
> - **Singleton Management**: I will ensure `ProductStudioController` state is correctly updated to support the new UI sections (Shortcuts, Health Score, etc.).

## Proposed Changes

### 1. Header Stability & Remake [FIX]
- **Fix Layout Crash**: Ensure the breadcrumb/search `Column` and its child `Row` have bounded width constraints using `BoxConstraints` or explicit `SizedBox`.
- **Match Design**: Update breadcrumbs to `Inventory > Products > Product Studio`. Add the `Draft` badge.
- **Action Buttons**: Implement the full row of buttons: `+ New Product`, `Bulk Import`, `AI Generate`, `Preview`, `Save Draft`, `Publish to Stores`.

#### [MODIFY] [product_studio_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/product_studio_screen.dart)
- Update `_buildHeader` with the fix and new UI elements.

---

### 2. Left Sidebar (Navigation Rail & Tools)
- **Main Rail**: Refine icons and typography for `Overview`, `Media Studio`, `Pricing & Markets`, `Inventory`, `Variants`, `Suppliers`, `Barcode & Labels`, `Store Sync`, `AI Assistant`, `History & Logs`, `Related Records`.
- **Shortcuts Section**: Add a secondary list for `Duplicate Product`, `Import Products`, `Export Template`, `Command Palette`.
- **Need Help? Card**: Add the "Ask AI Assistant" card with "Start Chat" button.

#### [MODIFY] [product_studio_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/product_studio_screen.dart)
- Update `_buildWorkflowRail` and add `_buildShortcuts` and `_buildHelpCard`.

---

### 3. Identity Hub & Media Studio (Top Section)
- **Primary Info**: 3-column layout for Product Identity (Title, SKU, Barcode, etc.), Media Studio, and Live Preview.
- **Media Studio**: Large preview with thumbnails, tags (Primary), and tool buttons (Upload, Camera, AI Generate).
- **Live Preview**: Polished mobile phone mockup with indicator dots.

#### [MODIFY] [product_studio_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/product_studio_screen.dart)
- Remake `_buildAdvancedTopDashboard`.

---

### 4. Template Fields & Bottom Grids
- **Template Tabs**: `Template Fields`, `Variants (6)`, `Pricing & Taxes`, `Inventory Rules`, `Additional Info`, `Compliance`.
- **Fields Grid**: 8-card grid for `Size System`, `Gender`, `Material`, etc.
- **Dynamic Pricing Grid**: Table with status indicators and simulated trend sparklines.
- **Warehouse Stock**: Table with availability progress bars.

#### [MODIFY] [product_studio_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/product_studio_screen.dart)
- Update `_buildTabbedContent`, `_buildFinancialAndStockGrids`, and `_buildBulkOperationsDock`.

---

### 5. Right Sidebar (Business Context & Health)
- **Context Panel**: Industry, Store, Currency, Tax Profile, etc.
- **Store Sync**: Branch list with `Synced` / `Pending` status.
- **Health Score**: 92% gauge with missing items checklist and "Improve with AI" button.

#### [MODIFY] [product_studio_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/product_studio_screen.dart)
- Remake `_buildBusinessContextPanel`.

## Verification Plan

### Manual Verification
- **Open Studio (F4)**: Verify the screen opens instantly without crashing.
- **Visual Audit**: Side-by-side check with the provided image.
- **Responsiveness**: Resize window to verify the `LayoutBuilder` handles the dense grids correctly.

### Automated Tests
- `flutter build windows` to verify syntax and dependency integrity.
