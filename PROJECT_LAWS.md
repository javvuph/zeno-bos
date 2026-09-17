# ZENO BOS - IMMUTABLE AI DEVELOPMENT LAWS

> **ATTENTION ALL AI ASSISTANTS, AGENTS, AND DEVELOPERS WORKING ON THIS CODEBASE**
> 
> You MUST strictly adhere to these two fundamental, immutable laws when generating, editing, or refactoring code in this repository. No exceptions.

---

## 📜 LAW 1: MAXIMUM 250 LINES PER FILE RULE
1. **Hard Ceiling**: No single non-generated `.dart` file in `lib/` may EVER exceed **250 lines**.
2. **Proactive Splitting**:
   - When creating or extending widgets, controllers, screens, models, or repositories that approach 200–225 lines, immediately extract components into modular sub-files or `part` files.
   - For classes/widgets: Extract sub-widgets, helper methods, or table rows into `parts/<filename>_<component>.part.dart` or standalone files in a `widgets/` folder.
   - For data collections or models: Split fields and helper methods into dedicated `parts/` files.
3. **Clean Architecture**: Part files must be placed in a `parts/` subdirectory sibling to the main file and linked via `part 'parts/...';` and `part of '...';`.

---

## 📜 LAW 2: ZERO-LOSS & SURGICAL MODIFICATION RULE
1. **Preserve Everything**: Never delete, remove, rename, or omit existing code, classes, methods, getters, variables, imports, or functionality unless explicitly instructed by the user.
2. **Zero Regression**: Every refactoring must preserve 100% of existing behavior, design layout, and public APIs.
3. **No Unrequested Deletions**: Do not trim code, remove "unused" variables, or refactor out features under the assumption that they aren't needed.

---

## 📜 LAW 3: COMPILATION & INTEGRITY GUARANTEE
1. **Analysis Verification**: Every created or modified file MUST be verified using analysis tools to guarantee **0 errors**.
2. **Maintain Import Hygiene**: Ensure all part files and modular splits maintain correct package imports and part directives.

---
*Created and enacted as permanent project law.*
