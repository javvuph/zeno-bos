# AI Center Functional Testing & Bug Fixing Plan

This plan outlines the steps to verify the AI Center module, fix identified bugs, and ensure compliance with enterprise validation requirements.

## User Review Required

- **Multi-provider Support**: Currently, the system registers only one provider (Gemini or Mock). I will implement a mechanism to switch between them if needed for the "Verify provider switching" test.
- **Automation Hub**: I will transition the Automation Hub from mock data to the `IAIRepository`.

## Proposed Changes

### [AI Center - Controller & Models]

#### [MODIFY] [ai_controller.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/presentation/controllers/ai_controller.dart)
- Implement `loadHistory()` to fetch actual sessions from `IAIRepository`.
- Implement `loadUsage()` to fetch actual usage stats.
- Call these in the constructor or via a `refresh()` method.
- Update `processNLQuery` to use `selectOptimalModel` from `AIIntelligenceEngine`.

### [AI Center - Presentation]

#### [MODIFY] [ai_chat_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/presentation/screens/ai_chat_screen.dart)
- Update `COGNITIVE HISTORY` sidebar to list actual sessions from the controller.
- Add navigation between sessions.

#### [MODIFY] [ai_command_center_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/screens/ai_command_center_screen.dart)
- Wrap the "Interactive AI Chat Interface" placeholder with a `GestureDetector` or `InkWell` to navigate to `AIChatScreen`.

#### [MODIFY] [ai_automation_hub.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/home/presentation/widgets/ai/ai_automation_hub.dart)
- Use `AIController` to fetch and display automations.

#### [MODIFY] [ai_dashboard_screen.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/features/ai_center/presentation/screens/ai_dashboard_screen.dart)
- Connect "MODEL HEALTH" button to `AIModelsScreen` (if it's not already connected).
- Connect "AI WORKSPACE" button to `AIChatScreen`.

### [AI Center - Domain & Infrastructure]

#### [MODIFY] [ai_gateway.dart](file:///C:/Users/HP/AndroidStudioProjects/MyApplication/lib/core/ai/ai_gateway.dart)
- Ensure the gateway provides enough information for usage tracking (tokens, model ID).

## Verification Plan

### Automated Tests
- Run `flutter analyze` to ensure no linting errors.
- Run `flutter test` (if there are unit tests for AI Center).

### Manual Verification
- Verify that data persists in Isar (via code check and repository logic).
- Verify that the chat interface updates correctly after a message.
- Verify that cost calculations are performed and displayed on the dashboard.
