# Implementation Plan - ZBOS Widget Framework & Personalization

Transform the ZBOS Dashboard into a fully customizable, user-driven workspace. This framework will allow users to build, save, and share personal business command centers without technical assistance.

## User Review Required

> [!IMPORTANT]
> - **Grid Engine**: I will integrate `flutter_staggered_grid_view` as the core layout engine. It is the industry standard for tile-based enterprise dashboards.
> - **Customization Workflow**: I will implement an "Edit Mode" toggle. While active, widgets will show drag handles and resizing borders. While inactive, they behave as standard interactive charts.
> - **Widget Sizes**: I will define a standard grid unit (e.g., 4 columns wide). Widgets will support spans:
>   - Small: 1x1
>   - Medium: 2x2
>   - Large: 2x4
>   - Wide: 4x2
>   - Full: 4x4

## Proposed Changes

### Core Framework

#### [NEW] [Dashboard Models](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/domain/models/dashboard_config.dart)
- `DashboardWidgetConfig`: Stores ID, type, grid position (x, y), size (w, h), and custom settings (refresh rate, theme).
- `DashboardProfile`: Stores a list of `DashboardWidgetConfig` and profile metadata (Name, Role, Template ID).

#### [NEW] [Dashboard Personalization Controller](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/controllers/dashboard_customization_controller.dart)
- Manages the state of the active profile.
- Handles logic for adding/removing/moving widgets.
- Triggers auto-save to local storage.

#### [NEW] [Widget Registry](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/widgets/customization/widget_registry.dart)
- A dictionary mapping String IDs (e.g., 'sales_trend') to the actual Widget constructors.
- Central point for all 30+ existing BI/Operations/AI modules.

### UI Components

#### [NEW] [CustomizableGrid](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/widgets/customization/customizable_grid.dart)
- The main rendering area using `StaggeredGrid`.
- Wraps each widget in a `PersonalizableWidgetWrapper` (adds drag handles/resizers in Edit Mode).

#### [NEW] [WidgetLibraryDrawer](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/widgets/customization/widget_library_drawer.dart)
- Categorized side-panel or overlay showing all available widgets with Search.
- Support for "Drag from Library" into the grid.

#### [NEW] [PersonalizationToolbar](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/widgets/customization/personalization_toolbar.dart)
- Sticky bar with actions: [Edit Layout], [Templates], [Save As], [Profile Switcher].

### Migration

#### [MODIFY] [dashboard_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/screens/dashboard_screen.dart)
- Replace static `Column` layout with the `CustomizableGrid`.
- Inject the `DashboardCustomizationController`.

## Verification Plan

### Automated Tests
- Logic tests for the "Grid Collision" algorithm (preventing widgets from overlapping).
- Persistence tests for saving/loading `DashboardProfile` JSON blobs.

### Manual Verification
- Verify drag-and-drop "Snap to Grid" behavior.
- Test resizing widgets and ensuring internal charts (Syncfusion) re-render correctly to the new aspect ratio.
- Test profile switching (e.g., switching from "Executive" to "Warehouse" view).
