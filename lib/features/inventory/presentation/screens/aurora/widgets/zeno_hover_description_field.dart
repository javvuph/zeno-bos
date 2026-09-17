import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';

class ZenoHoverDescriptionField extends StatefulWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final ZenoFieldWidth width;
  final bool isRequired;

  const ZenoHoverDescriptionField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.width = ZenoFieldWidth.full,
    this.isRequired = false,
  });

  @override
  State<ZenoHoverDescriptionField> createState() => _ZenoHoverDescriptionFieldState();
}

class _ZenoHoverDescriptionFieldState extends State<ZenoHoverDescriptionField> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.initialValue.isEmpty ? "No description provided." : widget.initialValue,
                style: const TextStyle(fontSize: 13, color: Color(0xFF0F172A), height: 1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) {
          _showOverlay();
        },
        onExit: (_) {
          _hideOverlay();
        },
        child: ZenoTextField(
          label: widget.label,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          width: widget.width,
          isRequired: widget.isRequired,
          hint: "Hover to preview full description...",
        ),
      ),
    );
  }
}
