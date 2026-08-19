# Implementation Plan - Store Setup UI Final Polish & Features

This plan completes the Store Setup module by adding missing critical fields (Address, Contact), implementing store status management, and adding administrative actions like "Delete" and "Duplicate".

## User Review Required

> [!IMPORTANT]
> **Data Integrity**: Deleting a branch will remove its configuration. I'll implement a confirmation dialog to prevent accidental data loss.
> **Personnel Tab**: The initial version of the Personnel tab will allow viewing and potentially adding user emails to the `assignedUsers` list.

## Proposed Changes

### [Store Logic & Model]

#### [MODIFY] [store_setup_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/administration/presentation/controllers/store_setup_controller.dart)
- Update `StoreBranch` model to include:
    - `address`, `city`, `zipCode`.
    - `phone`, `email`.
- Add `duplicateStore(String id)` method to `StoreSetupController`.

### [Store Setup UI]

#### [MODIFY] [store_setup_modal.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/administration/presentation/widgets/store_setup_modal.dart)
- **New Tab**: Add a **"4. Personnel"** tab to manage the `assignedUsers` list.
- **Form Additions**:
    - **Regional Tab**: Add Address line, City, and Zip Code fields.
    - **Profile Tab**: Add "Contact Number" and "Branch Email" fields.
    - **Status Management**: Add a Switch/Toggle for "Branch Operational Status" (Active/Inactive) in the Profile tab.
- **Sidebar Actions**:
    - Add a **Trash/Delete** icon to each store row (with a confirmation dialog).
    - Add a **Duplicate** icon to quickly clone a branch configuration.
- **UI Refinement**:
    - Ensure the layout remains "Handy" (Save button visible) while adding new fields.

## Verification Plan

### Manual Verification
- **Add Branch**: Create a new branch and verify all new fields (Address, Email) are saved.
- **Duplicate**: Clone a branch and verify the new branch has the same config but a new ID.
- **Delete**: Delete a branch and confirm it disappears from the sidebar.
- **Status Toggle**: Change status to "Inactive" and verify the badge in the sidebar updates.
