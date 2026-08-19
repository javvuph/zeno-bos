import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoInputFormTemplate extends StatefulWidget {
  final String title;
  final List<String> breadcrumbs;
  final Widget? statusBadge;
  final List<ZenoFormSection> sections;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String saveLabel;
  final bool isSaving;

  const ZenoInputFormTemplate({
    super.key,
    required this.title,
    this.breadcrumbs = const [],
    this.statusBadge,
    required this.sections,
    required this.onSave,
    required this.onCancel,
    this.saveLabel = "SAVE & SYNC",
    this.isSaving = false,
  });

  @override
  State<ZenoInputFormTemplate> createState() => _ZenoInputFormTemplateState();
}

class _ZenoInputFormTemplateState extends State<ZenoInputFormTemplate> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      color: colors.bgTier1,
      child: Column(
        children: [
          // HEADER
          _buildHeader(colors),

          // BODY
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: widget.sections,
                ),
              ),
            ),
          ),

          // FOOTER
          _buildFooter(colors),
        ],
      ),
    );
  }

  Widget _buildHeader(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.breadcrumbs.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: widget.breadcrumbs.asMap().entries.map((e) {
                      final isLast = e.key == widget.breadcrumbs.length - 1;
                      return Row(
                        children: [
                          Text(
                            e.value.toUpperCase(),
                            style: TextStyle(
                                fontSize: 10,
                                color: colors.textDisabled,
                                fontWeight: FontWeight.w700),
                          ),
                          if (!isLast)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 10, color: colors.textDisabled),
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              Row(
                children: [
                  Text(
                    widget.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: colors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (widget.statusBadge != null) ...[
                    const SizedBox(width: 16),
                    widget.statusBadge!,
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(top: BorderSide(color: colors.borderSubtle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: widget.onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.textSecondary,
              side: BorderSide(color: colors.borderSubtle),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("CANCEL",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: widget.isSaving ? null : widget.onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.accentPrimary,
              foregroundColor: colors.bgTier1, // Contrast color
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              elevation: 0,
            ),
            child: widget.isSaving
                ? SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: colors.bgTier1))
                : Text(widget.saveLabel,
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class ZenoFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final int columns;

  const ZenoFormSection({
    super.key,
    required this.title,
    required this.children,
    this.columns = 2,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  color: colors.textDisabled,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Divider(
                      color: colors.borderSubtle.withValues(alpha: 0.5))),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              const double spacing = 24.0;
              final double itemWidth =
                  (constraints.maxWidth - (spacing * (columns - 1))) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: 24,
                children: children.map((child) {
                  return SizedBox(
                    width: itemWidth,
                    child: child,
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
