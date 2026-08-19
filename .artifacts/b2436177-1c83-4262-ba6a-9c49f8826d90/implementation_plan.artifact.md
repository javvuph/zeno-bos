# Implementation Plan: High-Density Enterprise Dashboard Upgrade

Upgrade the ZENO BOS dashboard to a high-information-density layout with advanced visualizations, including radial donut charts, capsule-style pillar charts, and glassmorphic elements as per the refined design prompt.

## Proposed Changes

### 1. Theme & Colors
#### [MODIFY] [theme.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/app/theme.dart)
- Add `neonGreen` (#00FF88) to the palette.
- Ensure all accent colors are defined for various charts.

### 2. High-Density Dashboard Implementation
#### [MODIFY] [dashboard_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/screens/dashboard_screen.dart)
- **Top Metric Cards**:
    - Implement `_DonutChart` for Gross Sales.
    - Implement `_RadialProgress` for Expense and Profit.
- **Main Analytics**:
    - Build `_PillarLineChart`: A custom painter for the 3D capsule-style pillars with overlaid curved line graphs.
- **Side Panel**:
    - Update `_CustomerList` with channel badges, timestamps, and CLV.
    - Implement `_CategoryDonutChart` for Inventory Velocity (Fashion, Food, Electronics).
- **Mock Data**: Update all values to match the specific numbers ($142k sales, 1,980 transactions, etc.).

### 3. Header & UI Polish
#### [MODIFY] [zeno_shell.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/core/widgets/zeno_shell.dart)
- Add "AI Assistant" indicator in the top header.
- Ensure the horizontal menu reflects the full list (Billing, Inventory, ..., Administration).

## Verification Plan

### Manual Verification
- Deploy to web/desktop.
- Verify the high-density layout: ensure no "dead space" as requested.
- Check the visual fidelity of the custom painters:
    - 3D capsule bars (pillars).
    - Radial donut charts in cards.
    - Multi-segment glowing donut in the side panel.
