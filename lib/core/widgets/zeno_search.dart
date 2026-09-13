import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ZenoSearch extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String hint;
  final bool autofocus;

  const ZenoSearch({
    super.key,
    this.onChanged,
    this.hint = "Search...",
    this.autofocus = false,
  });

  @override
  State<ZenoSearch> createState() => _ZenoSearchState();
}

class _ZenoSearchState extends State<ZenoSearch> {
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Focus(
      onFocusChange: (focus) => setState(() => _isFocused = focus),
      child: AnimatedContainer(
        duration: ZenoDuration.fast,
        height: 36,
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: colors.bgTier3,
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(
            color: _isFocused ? colors.accentPrimary : colors.borderSubtle,
            width: ZenoBorderWidth.thin,
          ),
          boxShadow: _isFocused
              ? [
                  BoxShadow(
                      color: colors.accentPrimary.withValues(alpha: 0.1),
                      blurRadius: 4)
                ]
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: ZenoSpacing.sm),
        child: Row(
          children: [
            Icon(Icons.search,
                size: 16,
                color:
                    _isFocused ? colors.accentPrimary : colors.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _controller,
                autofocus: widget.autofocus,
                onChanged: widget.onChanged,
                style: ZenoTypography.bodyMD(colors.textPrimary),
                decoration: InputDecoration(
                  hintText: widget.hint.toUpperCase(),
                  hintStyle: ZenoTypography.micro(colors.textDisabled),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (_controller.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  _controller.clear();
                  widget.onChanged?.call("");
                  setState(() {});
                },
                child: Icon(Icons.close, size: 14, color: colors.textDisabled),
              ),
          ],
        ),
      ),
    );
  }
}
