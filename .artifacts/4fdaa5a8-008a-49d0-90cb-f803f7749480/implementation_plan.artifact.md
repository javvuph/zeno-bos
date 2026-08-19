# Implementation Plan - Menu UI Fix & Alignment

The goal is to fix the navigation layout so that the main menu fits within the window and sub-menus (workspaces) appear as dropdowns directly beneath their parent module.

## Proposed Changes

### 1. Dropdown Positioning Logic
*   Modify `lib/core/widgets/zeno_shell.dart` to track the horizontal position (`Offset`) of the hovered module.
*   Update `ZenoShell` to use this offset to position the sub-menu exactly under the parent.

### 2. Sub-Menu (Dropdown) Redesign
*   Refactor `lib/navigation/widgets/zeno_mega_menu.dart` (or create a compact version) to be a vertical **Enterprise Dropdown**.
*   Remove the internal search bar and footer to match the "flowing down" list style requested.
*   Set a fixed width (e.g., 240px) and apply glassmorphism with professional ZBOS styling.

### 3. Navigation Bar (Top Nav) Fixes
*   Ensure the `ZenoTopNavBar` Row is wrapped correctly to prevent "went out of window" issues if horizontal space is tight.
*   Optimize padding and margins for 13 modules.

## Verification Plan
*   Test hover on the first (Home) and last (Administration) modules to ensure dropdowns don't go off-screen.
*   Verify vertical alignment of sub-menu items.
*   Ensure colors and fonts match the current ZBOS theme.
