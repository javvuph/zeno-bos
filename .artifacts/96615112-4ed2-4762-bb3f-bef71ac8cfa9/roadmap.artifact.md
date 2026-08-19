# ZENO Business Operating System - Project Roadmap

This document outlines the strategic implementation sequence for the ZENO BOS project. The strategy follows a "Module-First" approach, completing core business logic and UI for all modules before integrating infrastructure and persistence.

## Phase 1: Core Business Modules (Current Focus)

Implementing the vertical business logic and high-fidelity UI for each core domain.

- [x] **1. Product Studio**
    - Domain Foundation
    - Business Logic (SKU/Barcode/Readiness)
    - Enterprise UI Polish
- [ ] **2. Inventory Module**
    - Stock Management
    - Warehouse Operations
    - Movement Tracking
- [ ] **3. Customer CRM**
    - Profiles & Segments
    - Communication Timeline
    - Loyalty & Credit
- [ ] **4. Supplier Management**
    - Vendor Directory
    - Procurement Profiles
    - Performance Analytics
- [ ] **5. Purchase Management**
    - Purchase Orders (PO)
    - Goods Received (GRN)
    - Landed Costing
- [ ] **6. Sales & Orders**
    - Order Fulfillment
    - Picking & Packing
    - Shipping Manifests
- [ ] **7. Reports & Analytics**
    - Unified Report Viewer
    - Executive Intelligence
    - AI Risk Radar
- [ ] **8. Finance**
    - General Ledger
    - Expense Management
    - Accounts Payable/Receivable

---

## Phase 2: Integration & Infrastructure

Connecting the completed modules to system-wide services and persistence.

- [ ] **9. Database Integration (Isar)**
    - Entity Mappings
    - Local Persistence Layer
    - Offline-First Storage
- [ ] **10. Media Hub**
    - File Storage Service
    - Image Processing
    - Attachment Management
- [ ] **11. Multi-Store**
    - Inter-Branch Sync
    - Global Stock Visibility
    - Location-Specific Pricing
- [ ] **12. Cloud Sync**
    - Remote Backend Integration
    - Conflict Resolution
    - Real-time Updates
- [ ] **13. Hardware Integration**
    - POS Printers
    - Barcode Scanners (USB/HID)
    - Payment Terminals

---

## Strategic Notes

> [!IMPORTANT]
> **Business Logic First:** Infrastructure (DB/Hardware) is deferred to ensure business workflows are fully validated in the UI and Domain layers before locking in schemas.

> [!TIP]
> **Modular Independence:** Each module should be developed as a standalone feature within the `lib/features/` structure to ensure clean architecture boundaries.
