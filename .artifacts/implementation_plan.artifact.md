# Implementation Plan - AI Center Functional Testing & Production Fixes

The goal is to move the AI Center from a framework-only state to a "Production-Functional" state, satisfying the 20-point AI Center test suite and ensuring cross-module contextual awareness.

## User Review Required

> [!IMPORTANT]
> **API Key Dependency**: Most functional tests require a valid `GEMINI_API_KEY`. If not provided, the system will fall back to `MockAIProvider`, which allows UI/Persistence testing but not actual intelligence verification.
> **Contextual Injection**: I will be implementing a global context aggregator that pulls data from Sales, Finance, and Inventory to provide "Brain-Aware" responses.

## 12-Step Functional Testing Protocol (AI Center)

1.  **Command Center Access**: Open `AI Command Center` and verify Model Health KPIs.
2.  **Model Registry**: Verify listing of available models (Chat, Vision, Analysis).
3.  **Provider Switching**: Switch between Gemini and Mock providers and verify status.
4.  **Natural Language Query**: Execute a chat query and verify response persistence.
5.  **Multi-Module Context**: Test a query like "Summarize my inventory" and verify context injection.
6.  **Usage Tracking**: Verify token usage and cost calculation in `AIUsageCollection`.
7.  **Automation Hub**: Verify system-generated automation suggestions based on stock levels.
8.  **Anomaly Detection**: Verify the anomaly detection engine against mocked Finance data.
9.  **Session History**: Create multiple chat sessions and verify Isar persistence.
10. **Prompt Orchestration**: Verify that system prompts are correctly appended to user queries.
11. **Cost Monitoring**: Verify that the Dashboard reflects cumulative AI expenditure.
12. **Stability**: Verify zero runtime exceptions during streaming or long-context queries.

## Proposed Changes

### 1. Data Layer (Isar Persistence)

#### [NEW] [ai_collections.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/core/database/collections/ai_collections.dart)
- Add `AISessionCollection`, `AIUsageCollection`, `AIModelCollection`.

#### [NEW] [isar_ai_repository.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/data/repositories/isar_ai_repository.dart)
- Implement `getModels`, `saveModel`, `logUsage`, `getSessions`, `saveSession`.

### 2. Business Logic & AI Gateway

#### [MODIFY] [ai_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/presentation/controllers/ai_controller.dart)
- Implement `processNLQuery` with actual `AIGateway` calls.
- Implement token counting and cost logging logic.
- Add support for multi-module data gathering in `context`.

#### [MODIFY] [ai_intelligence_engine.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/domain/services/ai_intelligence_engine.dart)
- Enhance `buildContextPrompt` to use structured module data.
- Add `calculateInteractionCost` based on actual provider pricing.

### 3. UI & Experience

#### [MODIFY] [ai_chat_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/presentation/screens/ai_chat_screen.dart)
- Wire up the text controller to the `AIController.processNLQuery`.
- Implement streaming-like UI feedback.

#### [MODIFY] [ai_dashboard_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/presentation/screens/ai_dashboard_screen.dart)
- Bind KPIs to live usage data from Isar.

## Verification Plan

### Automated Verification
- Run `flutter analyze` to ensure zero errors.
- Run `dart run build_runner build` to verify schema integrity.

### Manual Verification
- Execute the 20 AI-specific tests provided by the user.
- Verify that AI responses correctly mention specific products or balances from the local database.
