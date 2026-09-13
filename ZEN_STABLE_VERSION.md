# ZENO STABLE BACKUP - 27 AUGUST 2026

This document records the exact state of the project for recovery by any AI tool (GitHub, Amazon, etc.).

## 🟢 Git Snapshot
- **Tag**: `STABLE-GROCERY-V1`
- **Commit**: `d0b5a3a`
- **Architecture**: authoritative 6-Tab Grocery/Kirana Product Studio.

## 🔵 Environment Versions
- **Flutter**: `3.44.7`
- **Channel**: `stable`
- **Dart**: `3.12.2`
- **Framework Revision**: `84fc5cbb22`
- **Engine Hash**: `7076f47b1d`

## 🔴 Authoritative 6-Tab Structure
1. **BASIC INFO**: Core Identity & Barcodes.
2. **DEPARTMENT**: Classification, Tags & 10-Capability Grid.
3. **PACK & SIZE**: Master UOM & Conversion owner.
4. **PRICE & TAX**: Pricing, HSN & GST owner.
5. **STOCK & SUPPLIER**: Inventory levels, Rack/Shelf/Bin & Suppliers.
6. **PHOTOS & ONLINE**: Media Studio & SEO.

## ⚠️ STRICT IMMUTABILITY RULE
**DO NOT MODIFY the Grocery/Kirana implementation unless explicitly instructed to "Modify the Grocery architecture."**
Any changes to shared components, themes, or other business profiles (Fashion, F&B, etc.) MUST NOT break or alter the fields, layout, or 6-tab structure of the Grocery/Kirana Product Studio. This logic is LOCKED.

## 🛠️ Recovery Instruction for AI
To restore this exact logic, the AI tool should perform:
1. `git checkout STABLE-GROCERY-V1`
2. Ensure Flutter version is matched to `3.44.7`.
3. Verify that `ProductStudioData` includes fields: `productType`, `segment`, `legalReference`, and `capWeighed` through `capAgeRestriction`.
