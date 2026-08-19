import 'package:flutter/material.dart';
import 'package:zeno/core/industry/industry_registry.dart';
import 'package:zeno/app/theme.dart';

class AttributeInput extends StatelessWidget {
  final AttributeDefinition definition;
  final String? value;
  final ValueChanged<String> onChanged;

  const AttributeInput({
    super.key,
    required this.definition,
    this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(definition.label,
              style: const TextStyle(
                  fontSize: 12, color: ZenoTheme.textSecondary)),
          const SizedBox(height: 4),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildInput() {
    switch (definition.type) {
      case AttributeType.text:
      case AttributeType.numeric:
        return TextField(
          decoration: _inputDecoration(),
          style: const TextStyle(fontSize: 14),
          onChanged: onChanged,
        );
      case AttributeType.selection:
        return DropdownButtonFormField<String>(
          initialValue: value ??
              (definition.options?.isNotEmpty == true
                  ? definition.options![0]
                  : null),
          dropdownColor: ZenoTheme.surface,
          decoration: _inputDecoration(),
          items: definition.options
              ?.map((opt) => DropdownMenuItem(value: opt, child: Text(opt)))
              .toList(),
          onChanged: (val) => onChanged(val ?? ''),
        );
      case AttributeType.toggle:
        return SwitchListTile(
          title: Text(definition.label, style: const TextStyle(fontSize: 14)),
          value: value == 'true',
          onChanged: (val) => onChanged(val.toString()),
          contentPadding: EdgeInsets.zero,
          activeThumbColor: ZenoTheme.accent,
        );
    }
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: ZenoTheme.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: ZenoTheme.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: ZenoTheme.border)),
    );
  }
}
