import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';

/// ZenoCommandVessel v1.0
/// Universal command engine for ZENO BOS.
class ZenoCommandVessel extends StatefulWidget {
  final ValueChanged<String>? onSubmitted;
  final Map<String, ValueChanged<String>>? commands;
  final String hint;
  final double maxWidth;

  const ZenoCommandVessel({
    super.key,
    this.onSubmitted,
    this.commands,
    this.hint = "Search or type command...",
    this.maxWidth = 420,
  });

  @override
  State<ZenoCommandVessel> createState() => _ZenoCommandVesselState();
}

class _ZenoCommandVesselState extends State<ZenoCommandVessel> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit(String value) {
    if (value.isEmpty) return;

    if (value.startsWith('/') && widget.commands != null) {
      final parts = value.substring(1).split(' ');
      final cmd = parts[0].toLowerCase();
      final args = parts.length > 1 ? parts.sublist(1).join(' ') : "";

      if (widget.commands!.containsKey(cmd)) {
        widget.commands![cmd]!(args);
      }
    } else {
      widget.onSubmitted?.call(value);
    }

    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyL, control: true): () =>
            _focusNode.requestFocus(),
      },
      child: AnimatedContainer(
        duration: ZenoDuration.fast,
        curve: ZenoMotion.standard,
        width: _isFocused ? widget.maxWidth + 80 : widget.maxWidth,
        height: 36,
        decoration: BoxDecoration(
          color: _isFocused
              ? colors.bgTier1
              : colors.bgTier3.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(
            color: _isFocused ? colors.accentPrimary : colors.borderSubtle,
            width: _isFocused ? ZenoBorderWidth.thick : ZenoBorderWidth.thin,
          ),
          boxShadow: _isFocused ? ZenoElevation.soft : null,
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(Icons.search_rounded,
                size: 18,
                color: _isFocused ? colors.accentPrimary : colors.textDisabled),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                onSubmitted: _handleSubmit,
                style: ZenoTypography.bodyMD(colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: ZenoTypography.bodyMD(colors.textDisabled),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
            if (!_isFocused)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_command_key_rounded,
                        size: 12, color: colors.textDisabled),
                    const SizedBox(width: 4),
                    Text("Ctrl + L",
                        style: ZenoTypography.micro(colors.textDisabled)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
