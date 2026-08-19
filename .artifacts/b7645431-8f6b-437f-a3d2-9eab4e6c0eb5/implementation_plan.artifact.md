# Refactor Product Studio for High-Efficiency Basic/Advanced Modes

This plan refactors the `ProductStudioScreen` to provide a "Basic" view for fast data entry and an "Advanced" view for full catalog management, while removing visual clutter and optimizing screen real estate.

## User Review Required

> [!IMPORTANT]
> I will be collapsing the "Live Preview" panel by default in Basic mode to prioritize data entry space. The user can still toggle it back on if needed.

## Proposed Changes

### [Inventory Feature]

#### [MODIFY] [product_studio_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/controllers/product_studio_controller.dart)
- Add `bool isAdvancedMode` and a toggle method.
- Update `entryLevel` logic to sync with the toggle.

#### [MODIFY] [product_studio_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/inventory/presentation/screens/product_studio_screen.dart)
- **Header:** Add a "Basic / Advanced" toggle switch.
- **Layout:** Refactor `_buildAdvancedTopDashboard` to be adaptive.
- **Basic Mode:**
    - Hide/Collapse the "Live Preview" and "Business Context" sidebars.
    - Expand the form to fill the width.
    - Group Media + Core Identity at the top.
- **Advanced Mode:** Restore the multi-panel "Master Catalog" view.
- **Spacing:** Globally reduce padding and gaps to remove "unwanted free spaces."

## Verification Plan

### Automated Tests
- N/A (UI refactor focus)

### Manual Verification
- Deploy to emulator/device.
- Toggle between Basic and Advanced modes.
- Verify that data entry fields are "handy" and at the top.
- Check that no data is lost when switching modes.
- Confirm "Media Studio" is mandatory and prominent in both.
