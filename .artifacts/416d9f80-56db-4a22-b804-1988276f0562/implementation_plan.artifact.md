# Centralized 3-Column Business Setup Architecture

This plan implements the new 3-column business selection system (Main Business, Sub-Business Type, and Business Scale) for ZENO BOS. It replaces the current dropdown-based selection in the Store Setup page and ensures the configuration is centrally managed and locked for non-admins.

## User Review Required

> [!IMPORTANT]
> The UI in `store_setup_modal.dart` will be updated to a 3-column list selector. This change will take up more vertical space than the original dropdowns. I will ensure it fits within the modal's layout without breaking existing elements.

> [!CAUTION]
> Business Scale will be mapped to the existing `businessSize` field in the `StoreBranch` model. I will ensure backward compatibility by mapping "Small (SMB)" to "SMALL", "Medium (Mid-Market)" to "GROWING", and "Large (Enterprise)" to "ENTERPRISE".

## Proposed Changes

### Administration Feature

---

#### [MODIFY] [store_setup_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/administration/presentation/controllers/store_setup_controller.dart)
- Update `industries` list to match the 18 main businesses.
- Update `industryMatrix` (or use `businessCategoryMap` from the registry) to match the sub-businesses.
- Add `scales` list: `['SMALL', 'GROWING', 'ENTERPRISE']`.
- Add permission logic to check if the current user can edit the configuration.

#### [MODIFY] [store_setup_modal.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/administration/presentation/widgets/store_setup_modal.dart)
- Replace the "Industry Vertical" and "Sub-Business Type" dropdowns in `_buildGeneralTab` with the new `BusinessSetupSelector` widget.
- Remove the "Business Size" dropdown from `_buildOperationsTab` as it is now moved to the central setup.
- Implement the "Locked" UI state (🔒) when the configuration is already set and the user is not an admin.
- Add a confirmation warning dialog when an admin attempts to change the configuration.

#### [NEW] [business_setup_selector.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/administration/presentation/widgets/business_setup_selector.dart)
- Create a new, compact widget that implements the 3-column side-by-side list view.
- Column 1: Main Business (Scrollable List)
- Column 2: Sub-Business Type (Scrollable List, filtered by Column 1)
- Column 3: Business Scale (Scrollable List: SMALL, GROWING, ENTERPRISE)
- Ensure the widget follows the "maintain 250 lines" rule.

## Verification Plan

### Manual Verification
- Deploy to emulator/device.
- Open Store Setup -> Edit Branch.
- Verify Main Business list shows 18 items.
- Verify selecting "FASHION" updates the second column to fashion sub-businesses.
- Verify selecting "RETAIL" updates the second column to retail sub-businesses.
- Verify selecting a Scale (e.g., SMALL) and saving correctly persists the data.
- Log in as a non-admin and verify the fields are locked with 🔒 icon.
- Log in as admin, try to change, and verify the confirmation warning appears.
- Open "Add Product" and verify it no longer asks for business selection but uses the saved config.
