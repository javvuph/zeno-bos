# Navigation Bar Overflow Fix Plan

This plan addresses the layout assertions (overflows) in the top navigation bar caused by high module density.

## User Review Required

> [!IMPORTANT]
> To fit all 12 core modules on a single screen without overflow, we will transition to a more compact horizontal layout.

- **Horizontal Scaling**: Reducing gaps between menu items from 24px to 8px.
- **Scroll Support**: Adding horizontal scrolling to the nav bar as a safety measure for smaller screens (laptop/tablets).
- **Vertical Alignment**: Adjusting internal padding to eliminate the 4px bottom overflow.

## Proposed Changes

### 1. Top Navigation Refinement
#### [MODIFY] [zeno_top_nav_bar.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/navigation/widgets/zeno_top_nav_bar.dart)
- **Outer Padding**: Reduce from 24 to 12.
- **Item Margin**: Reduce from `horizontal: 4` to `horizontal: 2`.
- **Item Padding**: Reduce from `horizontal: 16` to `horizontal: 10`.
- **Vertical Padding**: Reduce `vertical: 8` to `vertical: 4` to fix the bottom overflow.
- **Spacing**: Reduce `SizedBox(height: 6)` to `height: 4`.
- **Safety**: Wrap the `Row` in a `SingleChildScrollView` with `scrollDirection: Axis.horizontal`.

## Verification Plan

### Manual Verification
- Resize the browser window and ensure the navigation bar remains functional (scrollable).
- Verify that the "yellow/black striped" overflow pattern is gone.
- Ensure the "Electric" bold style is still legible at the tighter spacing.
