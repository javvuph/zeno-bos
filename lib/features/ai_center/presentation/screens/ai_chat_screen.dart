import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_ai_repository.dart';
import '../controllers/ai_controller.dart';
import '../../domain/services/ai_context_service.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final controller = AIController(sl<IAIRepository>());
  final contextService = sl<AIContextService>();
  final TextEditingController _queryController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    controller.refreshIntelligence();
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "Enterprise AI Assistant".toUpperCase(),
          subtitle:
              "MULTI-MODAL CONTEXT-AWARE INTELLIGENCE FOR REAL-TIME DATA ANALYSIS AND CROSS-MODULE EXECUTION.",
          actions: [
            _ChatAction(
              label: "NEW SESSION",
              icon: Icons.add,
              colors: colors,
              onPressed: () => controller.startNewSession(),
            ),
            const SizedBox(width: ZenoSpacing.md),
            _ChatAction(
                label: "NEURAL VOICE",
                icon: Icons.mic_none,
                isPrimary: true,
                colors: colors),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Row(
              children: [
                // History Sidebar
                SizedBox(
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
                ),
                const SizedBox(width: ZenoSpacing.lg),
                // Main Chat
                Expanded(
                  child: ZenoCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Expanded(
                          child: controller.activeConversation == null ||
                                  controller.activeConversation!.history.isEmpty
                              ? _buildEngineActive(colors)
                              : ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.all(ZenoSpacing.lg),
                                  itemCount: controller
                                      .activeConversation!.history.length,
                                  itemBuilder: (context, index) {
                                    final interaction = controller
                                        .activeConversation!.history[index];
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildMessage(
                                            interaction.prompt.content,
                                            true,
                                            colors),
                                        const SizedBox(height: 12),
                                        _buildMessage(
                                            interaction.response.content,
                                            false,
                                            colors),
                                        const SizedBox(height: 24),
                                      ],
                                    );
                                  },
                                ),
                        ),
                        // Input Area
                        Container(
                          padding: const EdgeInsets.all(ZenoSpacing.lg),
                          decoration: BoxDecoration(
                            color: colors.bgTier2,
                            border: Border(
                                top: BorderSide(color: colors.borderSubtle)),
                          ),
                          child: Row(
                            children: [
                              _IconAction(
                                  icon: Icons.attach_file,
                                  color: colors.textSecondary),
                              const SizedBox(width: ZenoSpacing.md),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: colors.bgTier3,
                                      borderRadius:
                                          BorderRadius.circular(ZenoRadius.md)),
                                  child: TextField(
                                    controller: _queryController,
                                    style: ZenoTypography.bodyMD(
                                        colors.textPrimary),
                                    decoration: InputDecoration(
                                      hintText: "TYPE YOUR COMMAND OR QUERY...",
                                      hintStyle: ZenoTypography.caption(
                                          colors.textDisabled),
                                      border: InputBorder.none,
                                    ),
                                    onSubmitted: (v) => _sendMessage(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: ZenoSpacing.md),
                              GestureDetector(
                                onTap:
                                    controller.isLoading ? null : _sendMessage,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: controller.isLoading
                                        ? colors.textDisabled
                                        : colors.accentPrimary,
                                    borderRadius:
                                        BorderRadius.circular(ZenoRadius.md),
                                    boxShadow: [
                                      if (!controller.isLoading)
                                        BoxShadow(
                                            color: colors.accentPrimary
                                                .withValues(alpha: 0.3),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4)),
                                    ],
                                  ),
                                  child: controller.isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.black))
                                      : const Icon(Icons.send_rounded,
                                          size: 20, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _sendMessage() async {
    if (_queryController.text.isNotEmpty) {
      final query = _queryController.text;
      _queryController.clear();
      final context = await contextService.gatherGlobalContext();
      await controller.processNLQuery(query, context);
      _scrollToBottom();
    }
  }

  Widget _buildEngineActive(ZenoSemanticColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: ZenoTheme.cyan500.withValues(alpha: 0.05),
                shape: BoxShape.circle),
            child: const Icon(Icons.auto_awesome,
                size: 48, color: ZenoTheme.cyan500),
          ),
          const SizedBox(height: 24),
          Text("ZENO NEURAL ENGINE ACTIVE",
              style: ZenoTypography.headlineSM(colors.textPrimary)
                  .copyWith(letterSpacing: 2, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text("READY FOR CROSS-MODULE QUANTUM ANALYSIS.",
              style: ZenoTypography.micro(colors.textDisabled)
                  .copyWith(letterSpacing: 1)),
        ],
      ),
    );
  }

  Widget _buildMessage(String text, bool isUser, ZenoSemanticColors colors) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
        padding: const EdgeInsets.all(ZenoSpacing.lg),
        decoration: BoxDecoration(
          color: isUser
              ? colors.accentPrimary.withValues(alpha: 0.1)
              : colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.lg),
          border: Border.all(
              color: isUser
                  ? colors.accentPrimary.withValues(alpha: 0.2)
                  : colors.borderSubtle),
        ),
        child: Text(text,
            style: ZenoTypography.bodyLG(colors.textPrimary)
                .copyWith(height: 1.5)),
      ),
    );
  }
}

class _ChatAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  final VoidCallback? onPressed;
  const _ChatAction(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors,
      this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed ?? () {},
      icon: Icon(icon, size: 16),
      label: Text(label.toUpperCase(),
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  final bool isSelected;
  const _HistoryItem(
      {required this.label, required this.colors, this.isSelected = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: isSelected
            ? colors.accentPrimary.withValues(alpha: 0.1)
            : colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.md),
        border: Border.all(
            color: isSelected
                ? colors.accentPrimary.withValues(alpha: 0.3)
                : colors.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(isSelected ? Icons.psychology : Icons.history_outlined,
              size: 14,
              color: isSelected ? colors.accentPrimary : colors.textDisabled),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label.toUpperCase(),
                  style: ZenoTypography.micro(isSelected
                          ? colors.accentPrimary
                          : colors.textPrimary)
                      .copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconAction({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, size: 18, color: color),
    );
  }
}
