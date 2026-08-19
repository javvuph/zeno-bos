# Task List - AI Center Functional Testing & Fixes

## Phase 1: Schema & Persistence
- [ ] Create `ai_collections.dart` for Isar
- [ ] Run `build_runner` to update Isar code
- [ ] Implement `IsarAIRepository` for sessions and usage logging
- [ ] Register `IAIRepository` in `service_locator.dart`

## Phase 2: Intelligence Engine
- [ ] Enhance `AIIntelligenceEngine` prompt building logic
- [ ] Implement actual model selection logic
- [ ] Implement token-to-cost conversion formulas

## Phase 3: Integration & UI
- [ ] Wire up `AIController` to `AIGateway` (Gemini/Mock)
- [ ] Implement "Cross-Module Intelligence" (Context Gathering)
- [ ] Update `AIChatScreen` for real message persistence
- [ ] Update `AIDashboardScreen` with live cost and model health metrics

## Phase 4: Functional Testing (12-Step Protocol)
- [ ] 1. Command Center Access Test
- [ ] 2. Model Registry Test
- [ ] 3. Provider Switching Test
- [ ] 4. NL Query Test
- [ ] 5. Multi-Module Context Test
- [ ] 6. Usage Tracking Test
- [ ] 7. Automation Hub Test
- [ ] 8. Anomaly Detection Test
- [ ] 9. Session History Test
- [ ] 10. Prompt Orchestration Test
- [ ] 11. Cost Monitoring Test
- [ ] 12. Stability & Exception Test

## Phase 5: Final Validation
- [ ] Verify all 20 AI-specific requirements
- [ ] Run `flutter analyze`
- [ ] Prepare final report
