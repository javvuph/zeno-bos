# ZENO BOS — VERSION MANIFEST

## Current Active Version: `version-2.0-lock`

### Version Lock Status:
- **Git Tag**: `version-2.0-lock`
- **Locked Date**: September 12, 2026
- **Branch**: `main`

### Restoring Version 2.0 Lock:
To restore the codebase to `version-2.0-lock` at any time, run:
```bash
git checkout version-2.0-lock
```
or
```bash
git restore --source=version-2.0-lock .
```

---

### Core Specifications Locked in `version-2.0-lock`:

1. **Product Studio Header**:
   - Medium-sized, single straight horizontal line layout (`ZenoAdaptiveHeader`).
   - Integrates title, completion progress bar, business tags, mode selector (MANUAL, SCAN, BULK), Import, Fullscreen, and Advanced toggle.

2. **Fashion Workstation & Attributes (`fashion_variants_tab.dart`)**:
   - 70/30 desktop column split (Workstation + Colour Media Library).
   - Parallel Table layout for **SIZES** and **COLOURS**.
   - Size chips with checkmark badges for selected items (`S`, `M`, `L`, `XL`, `XXL`).
   - 6 default colors (`Black`, `Navy`, `White`, `Red`, `Blue`, `Grey`).
   - Custom size & color dialogs with full palette picker.

3. **Colour Media Library Inspector**:
   - Photography managed strictly at the **colourway level** (no size selectors in media panel).
   - Active colorway summary with automatic size sharing note (`"1 colour set will be shared across sizes"`).
   - 4-grid image preview tiles (*Front View*, *Back View*, *Detail*, *Side View*).
   - Dropzone upload box and additional image slots.
   - Table row click synchronization with active colorway inspector.

4. **Generated Variants Table (`variant_matrix.dart`)**:
   - Clean SKU formatting without dangling hyphens (`GREY-XXL`).
   - Bulk price and stock action toolbar with default `0` values and active Apply actions.
   - Barcode generator and search box.
   - 160px spacious default container for empty states.
   - Active row checkbox selection and header select-all.
   - Active row delete action and Clear All confirmation.
   - Connected spreadsheet-style matrix grid layout.

5. **Variant & Product Media Activation**:
   - Colour media upload is clickable and uses the active file picker.
   - Variant-level media upload/view is active from the MEDIA column.
   - Product media pickers are active for primary image and gallery flows.

6. **Saving Engine & Action Footer**:
   - **SAVE & CONTINUE**: Persists product and resets editor to a fresh new entry (`resetToNew()`).
   - **SAVE AS DRAFT**: Persists as `ProductLifecycleState.draft` keeping all entries on screen.
   - **CANCEL**: Clears entries and resets to a clean form (`resetToNew()`).
   - All three footer buttons styled with uniform `ZenoButtonSize.md`.
   - Product list refreshes after save and success feedback is shown.
   - Variant data plus media/SEO payload are included in persistence mapping.

7. **Quick-Add Dropdown Rollout**:
   - Matching `ZenoDropdown(... onQuickAdd: ...)` behavior added across the requested Aurora/Fashion fields.

8. **Navigation & Chart Life-cycle Safety**:
   - All Syncfusion charts wrapped in `SelectionContainer.disabled` and `RepaintBoundary` with unique `ValueKey`s.
   - `animationDuration: 0` configured on all chart series to prevent unmount mutations during navigation.
