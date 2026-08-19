# Implementation Plan - Phase 6: Billing Studio Production Readiness

Enhance the Billing Studio with production-grade features such as Undo/Redo, Bill Locking, Manager Overrides, and advanced item tracking (Serials, Batches, Expiry).

## User Review Required

> [!IMPORTANT]
> This phase implements advanced business logic using in-memory state. Full audit trail hooks are provided, but permanent persistence (database) is not included as per requirements.

## Proposed Changes

### Domain & Data Layer

#### [MODIFY] [bill_item.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/domain/models/bill_item.dart)
- Add `serialNumber`, `batchNumber`, `expiryDate`, and `notes` fields.
- Add `originalPrice` (to track price overrides).

#### [MODIFY] [bill.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/domain/models/bill.dart)
- Add `isLocked` and `auditTrail` (list of logs).

### Presentation & Business Logic

#### [MODIFY] [billing_event.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/presentation/controllers/billing_event.dart)
- Add events: `UndoRequested`, `RedoRequested`, `LockBillRequested`, `PriceOverrideRequested`, `UpdateItemTrackingRequested`, `AddLineNoteRequested`.

#### [MODIFY] [billing_state.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/presentation/controllers/billing_state.dart)
- Add `history` (stack for Undo/Redo).
- Add `isLocked` flag.

#### [MODIFY] [billing_studio_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/presentation/controllers/billing_studio_controller.dart)
- Implement state snapshots for Undo/Redo.
- Implement Locking logic (prevent modifications when locked).
- Implement Price Override with audit logging.
- Add handlers for Serial/Batch/Expiry updates.

### UI & UX Components

#### [NEW] [manager_override_dialog.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/presentation/dialogs/manager_override_dialog.dart)
A secure PIN/Password dialog for authorizing sensitive actions like Price Overrides.

#### [NEW] [item_details_dialog.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/presentation/dialogs/item_details_dialog.dart)
Dialog for managing Serial Numbers, Batches, and Expiry Dates per line item.

#### [MODIFY] [smart_cart_grid.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/presentation/widgets/smart_cart_grid.dart)
- Show "Price Overridden" indicators.
- Add badge for "Notes" or "Serial Numbers" attached to items.
- Display multi-warehouse stock availability (UI ready).

#### [MODIFY] [billing_top_toolbar.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/billing/presentation/widgets/billing_top_toolbar.dart)
- Add Undo/Redo buttons.
- Add Lock/Unlock toggle with visual state change.

## Verification Plan

### Automated Tests
- `flutter analyze` to ensure zero errors.
- Verify that Locked state correctly disables add/remove/update events in the controller.

### Manual Verification
- **Undo/Redo:** Perform multiple actions (Add, Qty Change, Discount) and verify Undo/Redo works perfectly.
- **Locking:** Verify UI disables when bill is locked.
- **Overrides:** Trigger a Price Override and ensure the audit trail logs the change.
- **Advanced Tracking:** Add a Serial Number to an item and verify it persists in the bill state.
