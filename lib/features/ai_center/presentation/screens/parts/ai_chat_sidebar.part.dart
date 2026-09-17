part of '../ai_chat_screen.dart';

extension _AIChatScreenSidebarState on _AIChatScreenState {
  Widget _buildSidebar(ZenoSemanticColors colors) {
    return SizedBox(
      width: 280,
      child: Column(
        children: [
          ZenoCard(
            title: "SYSTEM CONTEXT",
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...controller.lastGlobalContext.keys
                    .where((k) => k != 'error')
                    .map((k) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: colors.accentPrimary
                                  .withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(4)),
                          child: Text(k.toUpperCase(),
                              style: ZenoTypography.micro(
                                      colors.accentPrimary)
                                  .copyWith(
                                      fontWeight: FontWeight.bold)),
                        )),
              ],
            ),
          ),
          const SizedBox(height: ZenoSpacing.lg),
          Expanded(
            child: ZenoCard(
              title: "COGNITIVE HISTORY",
              trailing:
                  Text("${controller.history.length} SESSIONS"),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.history.length,
                itemBuilder: (context, index) {
                  final session = controller.history[index];
                  final isSelected =
                      controller.activeConversation?.id ==
                          session.id;
                  return GestureDetector(
                    onTap: () =>
                        controller.selectConversation(session),
                    child: _HistoryItem(
                      label: session.title,
                      colors: colors,
                      isSelected: isSelected,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
