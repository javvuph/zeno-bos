import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';

enum ZenoFieldWidth { micro, short, medium, standard, full }

class _NumericInputFormatter extends TextInputFormatter {
  final bool allowDecimal;

  const _NumericInputFormatter({this.allowDecimal = true});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final normalized = newValue.text.replaceAll(',', '.');
    final pattern = allowDecimal ? RegExp(r'^\d*\.?\d*$') : RegExp(r'^\d*$');

    if (!pattern.hasMatch(normalized)) {
      return oldValue;
    }

    if (allowDecimal && normalized.split('.').length > 2) {
      return oldValue;
    }

    return TextEditingValue(
      text: normalized,
      selection: TextSelection.collapsed(offset: normalized.length),
      composing: TextRange.empty,
    );
  }
}

class ZenoTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final bool isRequired;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  final bool readOnly;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final TextAlign textAlign;
  final ZenoFieldWidth? width;

  const ZenoTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.isRequired = false,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.focusNode,
    this.onSubmitted,
    this.textAlign = TextAlign.start,
    this.width,
  });

  @override
  State<ZenoTextField> createState() => _ZenoTextFieldState();
}

class _ZenoTextFieldState extends State<ZenoTextField> {
  TextEditingController? _internalController;
  FocusNode? _internalFocusNode;

  bool get _isNumericInput => widget.keyboardType.toString().contains('number');

  bool get _allowsDecimalInput =>
      widget.keyboardType == TextInputType.number ||
      widget.keyboardType.toString().contains('decimal') ||
      widget.keyboardType == const TextInputType.numberWithOptions(decimal: true);

  String? _normalizeInitialValue(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '';
    }

    final trimmed = value.trim();
    if (_isNumericInput) {
      final normalized = trimmed.replaceAll(',', '.');
      final parsed = double.tryParse(normalized);
      if (parsed != null && parsed == 0) {
        return '';
      }
    }

    return value;
  }

  TextEditingController get _effectiveController =>
      widget.controller ??
      (_internalController ??=
          TextEditingController(text: _normalizeInitialValue(widget.initialValue)));

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_effectiveFocusNode.hasFocus) {
      // Sync on blur if needed
    }
  }

  @override
  void didUpdateWidget(ZenoTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && widget.initialValue != oldWidget.initialValue) {
      final normalized = _normalizeInitialValue(widget.initialValue);
      if (!_effectiveFocusNode.hasFocus) {
        _effectiveController.text = normalized ?? '';
      }
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    _internalFocusNode?.removeListener(_handleFocusChange);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    double? pixelWidth;
    if (widget.width != null) {
      switch (widget.width!) {
        case ZenoFieldWidth.micro:
          pixelWidth = 100;
          break;
        case ZenoFieldWidth.short:
          pixelWidth = 160;
          break;
        case ZenoFieldWidth.medium:
          pixelWidth = 240;
          break;
        case ZenoFieldWidth.standard:
          pixelWidth = 380;
          break;
        case ZenoFieldWidth.full:
          pixelWidth = double.infinity;
          break;
      }
    }

    final inputFormatters = _isNumericInput
        ? <TextInputFormatter>[_NumericInputFormatter(allowDecimal: _allowsDecimalInput)]
        : null;

    final textField = Container(
      height: widget.maxLines == 1 ? 34 : null,
      width: pixelWidth,
      decoration: BoxDecoration(
        color: _effectiveFocusNode.hasFocus ? colors.bgTier1 : colors.bgTier2,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _effectiveFocusNode.hasFocus ? colors.accentPrimary : colors.borderSubtle,
          width: _effectiveFocusNode.hasFocus ? 1.2 : 1,
        ),
      ),
      child: TextField(
        controller: _effectiveController,
        focusNode: _effectiveFocusNode,
        maxLines: widget.maxLines,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textAlign: widget.textAlign,
        inputFormatters: inputFormatters,
        enableSuggestions: !_isNumericInput,
        autocorrect: !_isNumericInput,
        style: TextStyle(
          fontSize: 13,
          color: widget.readOnly ? colors.textDisabled : colors.textPrimary,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: colors.textDisabled, fontSize: 12),
          prefixIcon: widget.prefix != null
              ? IconTheme(
                  data: IconThemeData(size: 16, color: colors.textSecondary),
                  child: widget.prefix!,
                )
              : null,
          suffixIcon: widget.suffix != null
              ? IconTheme(
                  data: IconThemeData(size: 16, color: colors.textSecondary),
                  child: widget.suffix!,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          isDense: true,
        ),
      ),
    );

    if (widget.label == null || widget.label!.isEmpty) return textField;

    return SizedBox(
      width: pixelWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                widget.label!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                  fontFamily: 'Inter',
                ),
              ),
              if (widget.isRequired)
                Text(" *", style: TextStyle(color: colors.statusDanger, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 2),
          textField,
        ],
      ),
    );
  }
}

class ZenoDropdown<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool isRequired;
  final ZenoFieldWidth? width;
  final VoidCallback? onQuickAdd;

  const ZenoDropdown({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.isRequired = false,
    this.width,
    this.onQuickAdd,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    double? pixelWidth;
    if (width != null) {
      switch (width!) {
        case ZenoFieldWidth.micro:
          pixelWidth = 100;
          break;
        case ZenoFieldWidth.short:
          pixelWidth = 160;
          break;
        case ZenoFieldWidth.medium:
          pixelWidth = 240;
          break;
        case ZenoFieldWidth.standard:
          pixelWidth = 380;
          break;
        case ZenoFieldWidth.full:
          pixelWidth = double.infinity;
          break;
      }
    }

    T? effectiveValue = value;
    if (value != null && !items.any((item) => item.value == value)) {
      effectiveValue = null;
    }

    return SizedBox(
      width: pixelWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                  fontFamily: 'Inter',
                ),
              ),
              if (isRequired)
                Text(" *", style: TextStyle(color: colors.statusDanger, fontSize: 13)),
              if (onQuickAdd != null) ...[
                const Spacer(),
                InkWell(
                  onTap: onQuickAdd,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: colors.accentPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(Icons.add_rounded, size: 14, color: colors.accentPrimary),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: colors.bgTier2,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: effectiveValue,
                items: items,
                onChanged: onChanged,
                isExpanded: true,
                dropdownColor: colors.bgTier1,
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: colors.textSecondary, size: 18),
                style: TextStyle(
                    fontSize: 13,
                    color: colors.textPrimary,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
