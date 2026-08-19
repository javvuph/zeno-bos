# Implementation Plan: ZENO Enterprise BI Command Center

This plan transforms the Home Dashboard into a world-class Business Intelligence Command Center, comparable to SAP Analytics Cloud and Power BI.

## 1. Top Bar & Global Filtering Overhaul
- [MODIFY] [zeno_shell.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/core/widgets/zeno_shell.dart): Redesign `TopHeader` to include:
    - Company and Branch Selectors (Dropdowns).
    - **Global Date Filter**: A comprehensive selector (Today, This Week, This Quarter, Custom, etc.).
    - Theme Switcher, Language Selector, and enhanced Profile/Settings access.
    - Integrated AI Assistant trigger and Notification badge.

## 2. Advanced Analytics Widget Library
Create a new suite of high-density BI widgets in `lib/features/home/presentation/widgets/bi_widgets.dart`:
- `BISparklineCard`: KPI card with mini-trend line and Target vs Actual progress bar.
- `BIGrowthChart`: Multi-series Area/Line chart for Revenue and Profit trends.
- `AIRiskFeed`: Color-coded AI insight cards (Critical, Warning, Opportunity).
- `BIEntityGrid`: Compact status grid for multi-branch/company health.
- `BIAnalyticTile`: Small, modular tiles for specific metrics (e.g., "Top 5 Products", "Customer Segments").

## 3. World-Class Dashboard Layout
- [MODIFY] [dashboard_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/screens/dashboard_screen.dart):
    - Replace the reorderable list with a **Fixed-Grid Enterprise Layout** designed for high information density.
    - Implement a 4-Column system for desktop/large screens.
    - Sections:
        1. **KPI Belt**: 8 critical metrics at the top.
        2. **Main Analytics Row**: 75% Growth Chart / 25% AI Strategic Insights.
        3. **Sub-Analytics Grid**: 4 blocks (Products, Customers, Finance, Inventory).
        4. **Operational Row**: Online Orders, Logistics, and Branch Status.

## 4. State Management for Global Filters
- [NEW] `lib/features/home/presentation/controllers/dashboard_controller.dart`:
    - A `DashboardController` (ChangeNotifier) to manage the global filter state (Date range, Branch, Company).
    - All BI Widgets will listen to this controller to update their "Live Data".

## 5. Visual Wireframe (ASCII)
```text
┌────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ [LOGO] [ Global Search ] [📅 Date Filter] [🏢 Company] [📍 Branch] [🔔] [🤖] [❓] [🌓] [🌐 EN] [👤 Profile] [⚙️]             │
├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ HOME  INVENTORY  BILLING  CUSTOMERS  SUPPLIERS  ORDERS  DELIVERY  STAFF  FINANCE  REPORTS  AI CENTER  ADMINISTRATION        │
├────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐                   │
│ │ REVENUE  │ │ PROFIT   │ │ ORDERS   │ │ CUSTOMER │ │ MARGIN   │ │ GROWTH   │ │ CASH     │ │ STOCK    │                   │
│ └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘                   │
├───────────────────────────────────────────────────────┬────────────────────────────────────────────────────────────────────┤
│                                                       │                                                                    │
│   MAIN REVENUE & GROWTH CENTER (Area Chart)           │   AI STRATEGIC INSIGHTS (Priority Feed)                            │
│   - Revenue vs Target                                 │   - [!] High Risk: Inventory Shortage                              │
│   - Projected vs Actual                               │   - [+] Opportunity: Expansion Trend                               │
│                                                       │                                                                    │
├───────────────────────────┬───────────────────────────┼───────────────────────────┬────────────────────────────────────────┤
│                           │                           │                           │                                        │
│  PRODUCT ANALYTICS        │  CUSTOMER INTELLIGENCE    │  FINANCIAL SNAPSHOT       │  INVENTORY HEALTH                      │
│  - Top 10 SKU Performance │  - Segment Distribution   │  - P&L Mini-Statement     │  - Velocity / Turnover                 │
│  - Stock Value vs Age     │  - Retention Heatmap      │  - Cash Flow Forecast     │  - Dead Stock Value                    │
│                           │                           │                           │                                        │
├───────────────────────────┴───────────┬───────────────┴───────────┬───────────────┴────────────────────────────────────────┤
│                                       │                           │                                                        │
│  OPERATIONAL HUB                      │  LOGISTICS & DELIVERY      │  GLOBAL BRANCH HEALTH                                  │
│  - Online Store Status                │  - Fleet Efficiency       │  - Live Branch Uptime                                  │
│  - Procurement Backlog                │  - Delivery SLA %         │  - Real-time Employee Count                            │
│                                       │                           │                                                        │
└───────────────────────────────────────┴───────────────────────────┴────────────────────────────────────────────────────────┘
```

## Verification Plan
- **Filter Reactivity**: Change the date filter to "Last Month" and verify all widgets update their simulated data.
- **Responsive Layout**: Resize the window to ensure the 4-column grid stacks correctly.
- **Enterprise Aesthetics**: Compare the final UI with SAP Fiori/Power BI design standards.
