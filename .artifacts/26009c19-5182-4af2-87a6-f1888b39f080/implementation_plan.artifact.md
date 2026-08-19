# Implementation Plan - Window Performance & "Handy" Layout Refinement

Optimize the window system for instant, snappy movement and refine the Store Setup layout to ensure critical actions like the "Save" button are always visible and accessible.

## User Review Required

> [!IMPORTANT]
> **Performance Optimization**: Switched from `AnimatedContainer` to a standard `Container` during dragging. This eliminates the "lag" caused by the animation engine trying to interpolate coordinates.
> **Layout Visibility**: Standardized the default window height to **600px** and tightened the form footer.
> **Sidebar UX**: Grouped the Store Name and Status Badge together on the left, leaving the **[EDIT]** trigger with plenty of clickable "air" on the right.

## Proposed Changes

### Window Infrastructure
#### [MODIFY] [zeno_window_shell.dart](file:///C:\Users\HP\AndroidStudioProjects\MyApplication\lib\core\widgets\zeno_window_shell.dart)
- **Instant Dragging**: Conditionally render a standard `Container` (instead of `AnimatedContainer`) when `_isDragging` is true. This provides "glued to cursor" performance.
- **Full Screen Maximize**: Confirmed `top: 0` and `height: 100%` behavior for focused work.

### Store Setup Module
#### [MODIFY] [store_setup_modal.dart](file:///C:\Users\HP\AndroidStudioProjects\MyApplication\lib\features\administration\presentation\widgets\store_setup_modal.dart)
- **Sidebar Row Refactor**:
    - Layout: `[Name] [Badge] <Spacer> [EDIT]`.
    - This allows the store name to breathe while keeping the edit action distinctly separate.
- **Form Density**:
    - Reduced tab header height from 50px to **44px**.
    - Reduced form section bottom padding from 20px to **12px**.
- **Footer Polish**: Reduced vertical padding to **8px** to keep the "Save & Sync" button visible on all common screen heights.

#### [MODIFY] [zeno_mega_menu.dart](file:///C:\Users\HP\AndroidStudioProjects\MyApplication\lib\navigation\widgets\zeno_mega_menu.dart)
- **Default Size**: Updated the opening dimensions to **820x600** for a more "handy" but complete view.

## Verification Plan

### Manual Verification
- **Snappiness**: Drag the window rapidly; verify there is zero lag or "catch-up" delay.
- **Visibility**: Open the window and confirm the footer "Save" button is fully visible without any initial scrolling.
- **Sidebar Item**: Verify the Name and Badge are adjacent and the EDIT button is on the far right.
- **Theming**: Confirm all text remains legible in both Light and Dark themes.
