# Implementation Plan - ZENO Professional Dashboard & Navigation Overhaul

This plan details the implementation of the high-fidelity, enterprise-grade UI requested by the user, matching the provided visual reference. We will build a "workspace" environment with multi-pane navigation, hover-triggered mega menus, and a sophisticated dark theme.

## User Review Required

> [!IMPORTANT]
> This is a complete UI replacement. The application will transition from a simple layout to a professional multi-pane workspace. I will implement the exact color palette (Deep Navy/Slate) and layout seen in your reference image.

## Proposed Changes

### 1. Theme & Design Tokens
#### [MODIFY] `lib/app/theme.dart`
- **Colors:** Implement the "Zeno Night" palette:
    - Background: `#0B0F17` (Deepest Navy)
    - Surface: `#151B26` (Panel background)
    - Accent: `#3D8BFF` (Electric Blue)
    - Glass: `#151B26` with 80% opacity and Gaussian blur.
- **Typography:** Inter/Roboto with specific scales for high-density data.

### 2. Application Shell (The "Zeno Workspace")
#### [MODIFY] `lib/core/widgets/zeno_shell.dart`
- **Top Header:**
    - Top-most: Brand Logo, Global Search (Ctrl+K), Notifications/Chat/Profile icons.
    - Below Search: Horizontal Menu Bar (Home, Billing, Inventory, etc.).
- **Left Sidebar:** Slim productivity bar for "Dashboard", "Quick Actions", "Favorites", and "Workspace Switcher".
- **Right Sidebar:** (NEW) Notifications and Activity timeline panel.
- **Status Bar:** Bottom bar with "SYSTEM READY", Branch Info, User Role, and Version.

### 3. Navigation Framework (Photoshop-Style)
#### [MODIFY] `lib/navigation/menu_registry.dart`
- **Structure:** Update model to support "Mega Menu Sections" (6-8 columns) and "Bottom Metadata" (Favorites/Recent).
#### [NEW] `lib/navigation/widgets/zeno_mega_menu.dart`
- **Interaction:** `OverlayPortal` based hover menu.
- **Design:** Glassmorphism background, multi-column grid, search-within-menu feature.
- **Behavior:** Hover-to-open, mouse-path-tracking (to prevent flickering), smooth fade/slide animation.

### 4. Dashboard Framework
#### [NEW] `lib/features/home/presentation/widgets/zeno_dashboard.dart`
- **Widgets:** Implement the specific cards from the reference:
    - **KPI Row:** Today's Sales, Total Orders, Gross Profit, Low Stock.
    - **Charts:** Sales Overview (spline area chart), Low Stock Items (mini line chart).
    - **Data Lists:** Top Selling Products with images.
    - **Intelligence:** AI Insight card with gradient background.
    - **Tasks:** Upcoming tasks list with priority badges.

## Verification Plan

### Manual Verification (Chrome)
- **Visual Accuracy:** Compare the running app against the reference image for spacing, colors, and shadows.
- **Hover Logic:** Hover over "Inventory" -> Mega menu appears instantly -> Moving mouse into the menu maintains state -> Moving mouse away closes it.
- **Responsiveness:** Verify the layout adapts when the Chrome window is resized.
- **Search:** Ensure the "Ctrl + K" bar remains fixed at the top.
