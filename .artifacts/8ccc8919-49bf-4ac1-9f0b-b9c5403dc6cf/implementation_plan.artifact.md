# Implementation Plan: Complete Enterprise Navigation & Premium Workspace Framework

Upgrade the ZENO navigation backbone to a premium enterprise-grade system with universal create actions, notification center, and advanced status monitoring.

## User Review Required

> [!IMPORTANT]
> This update introduces a **Universal Create Button** in the header. It provides a searchable dropdown for initiating any business process (Sale, Purchase, Employee, etc.).

> [!TIP]
> I am expanding the **Status Bar** and **Top Header** to include license status, company/branch switching enhancements, and profile settings (Language, Support).

## Proposed Changes

### Core Logic & State

#### [MODIFY] [navigation_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/navigation/navigation_controller.dart)
- Add `closedTabsStack` to support **Restore Closed Tab** (Ctrl+Shift+T).
- Add `notificationCategories` and `unreadCounts` state.
- Add `licenseStatus` and `serverTime` state.

#### [MODIFY] [quick_access_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/navigation/quick_access_controller.dart)
- Increase `maxItems` to 12.
- Support **Quick Access Groups** for better organization.

### Premium UI Components

#### [NEW] [universal_create_menu.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/navigation/widgets/universal_create_menu.dart)
- A searchable, icon-rich overlay for global "Create" actions.

#### [NEW] [notification_centre_overlay.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/navigation/widgets/notification_centre_overlay.dart)
- A categorized notification panel (Business, Finance, AI, HR).
- Support for "Pin", "Archive", and "Mark as Read".

#### [NEW] [enterprise_profile_menu.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/navigation/widgets/enterprise_profile_menu.dart)
- Expanded profile dropdown with Language selection, Theme toggle, and Support links.

### Shell Integration

#### [MODIFY] [zeno_shell.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/core/widgets/zeno_shell.dart)
- Integrate **Universal Create (+)** next to Search.
- Enhance **BottomStatusBar** with Database Status, Sync, and License indicators.
- Add **Ctrl+Shift+T** shortcut to `ZenoShortcuts`.

#### [MODIFY] [side_info_panel.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/core/widgets/side_info_panel.dart)
- Add **Tasks** and **Calendar** tabs to the multi-tab side panel.

## Verification Plan

### Manual Verification
1.  **Universal Create**: Click the `＋` button in the header, search for "Sale", and verify it opens the New Bill tab.
2.  **Restore Tab**: Open a tab, close it, then press `Ctrl+Shift+T` and verify it restores.
3.  **Notification Centre**: Click the bell icon, verify categories (AI, Finance) and "Archive" functionality.
4.  **Status Bar**: Verify "License: Active" and "DB: Connected" indicators are visible.
5.  **Side Panel**: Toggle "Tasks" tab and verify the task list loads correctly.
