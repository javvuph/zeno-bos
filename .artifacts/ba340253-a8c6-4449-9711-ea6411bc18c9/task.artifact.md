# Task List - Phase 6: Billing Studio Production Readiness

- [x] Domain Model Updates
    - [x] Update `BillItem` with `serialNumber`, `batchNumber`, `expiryDate`, `originalPrice`, `notes`
    - [x] Update `Bill` with `isLocked` and `auditTrail`
- [x] Controller & Business Logic
    - [x] Implement Undo/Redo history stack in `BillingState`
    - [x] Update `BillingStudioController` with Undo/Redo handlers
    - [x] Implement `LockBillRequested` logic
    - [x] Implement `PriceOverrideRequested` with audit logging
- [x] Production UI & Dialogs
    - [x] Create `ManagerOverrideDialog` (PIN/Approval)
    - [x] Create `ItemDetailsDialog` (Serial/Batch/Expiry entry)
- [x] Final UI Integration
    - [x] Update `BillingTopToolbar` with production controls
    - [x] Update `SmartCartGrid` with tracking indicators
    - [x] Verify multi-warehouse stock display UI
    - [x] Compile verification
