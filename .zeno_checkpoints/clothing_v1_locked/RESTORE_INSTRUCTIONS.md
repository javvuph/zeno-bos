# RESTORE INSTRUCTIONS: CLOTHING V1

This directory contains the finalized, high-density version of the Clothing (Fashion) Workstation.

## Why is this here?
The user has requested a permanent lock on this specific UI version. No AI or developer should modify the source files in `lib/.../fashion/` without explicit instruction to change "Clothing".

## How to restore?
If the UI is accidentally modified, run these commands:

```powershell
cp -r .zeno_checkpoints/clothing_v1_locked/fashion/* lib/features/inventory/presentation/screens/workstations/fashion/
cp .zeno_checkpoints/clothing_v1_locked/variant_matrix.dart lib/features/inventory/presentation/screens/workstations/
cp .zeno_checkpoints/clothing_v1_locked/variant_matrix_row.dart lib/features/inventory/presentation/screens/workstations/widgets/
cp .zeno_checkpoints/clothing_v1_locked/product_studio_controller_variants.part.dart lib/features/inventory/presentation/controllers/parts/
```

## Maintenance Rule
Any future changes authorized by the user for the Clothing module must also be manually synced back to this folder to maintain the "LOCKED" integrity.
