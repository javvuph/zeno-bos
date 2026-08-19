# ZENO Workspace & Window Management Research Notes

## 1. IDE-Style Workspace Patterns (2024)
- **Supporting Pane Scaffold:** The modern standard for professional tools (VS Code, Photoshop). A central "Main Pane" (Work area) flanked by "Supporting Panes" (Metadata, AI, Shortcuts) that can dock/undock.
- **Canonical Layouts:** Using `ListDetailPaneScaffold` for record-heavy modules like CRM and Inventory to handle responsive transitions from Phone to Desktop.

## 2. Flutter Desktop Multi-Window Architecture
- **Isolated Engines:** Each window runs in a separate Flutter isolate. Sharing state requires a **Reactive Local Database** (like Drift/SQLite) or an **IPC (Inter-Process Communication)** bridge.
- **Session Registry:** A local JSON/SQL schema to store the "Window Inventory" (ID, Type, Route, Arguments, X/Y position).
- **Restoration Hook:** The `main()` entry point must check for a "Previous Session" flag and batch-spawn windows during cold boot.

## 3. Modular Dashboard Engine
- **Coordinate-based Grid:** Using a resizable `x, y, w, h` system for widget placement, allowing users to build a custom "Cockpit."
- **Event-Driven Widgets:** Widgets should communicate via a shared filter state (e.g., a global "Date Range" widget updates all KPI cards simultaneously).
- **Server-Driven UI (SDUI):** For large enterprises, the dashboard layout can be stored on the server to push standardized layouts to different departments.

## 4. AI Workspace Integration
- **AI Side Panel (Copilot):** A persistent "Contextual Listener" that sees the active tab's data and offers proactive insights.
- **AI Canvas (Artifacts):** A split-view where AI-generated content (Reports, Invoices, Marketing text) is rendered as an interactable object, not just chat text.
- **Command Palette (Ctrl+K):** A unified search and execution hub for "Intent-Based Navigation."

## 5. Hardware-Aware Shell
- **Status Hub:** The shell must monitor the **Infrastructure Layer** (peripherals).
- **Interlock Logic:** The workspace should "interlock" certain actions (e.g., "Print Receipt") if the status bar reports a "Printer Offline" state.
