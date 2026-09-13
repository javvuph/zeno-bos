import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import '../../../../domain/services/ingestion/ingestion_models.dart';

class AIReviewDialog extends StatefulWidget {
  final List<AIExtractedField> fields;
  const AIReviewDialog({super.key, required this.fields});

  @override
  State<AIReviewDialog> createState() => _AIReviewDialogState();
}

class _AIReviewDialogState extends State<AIReviewDialog> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 100, vertical: 60),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            _buildHeader(colors),
            Expanded(child: _buildTable(colors)),
            _buildFooter(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          Icon(Icons.auto_awesome_rounded, color: colors.accentPrimary),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("AI EXTRACTION REVIEW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("Please verify extracted values before importing.", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ],
      ),
    );
  }

  Widget _buildTable(ZenoSemanticColors colors) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildTableHeader(colors),
        ...widget.fields.map((f) => _buildRow(colors, f)),
      ],
    );
  }

  Widget _buildTableHeader(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(4)),
      child: const Row(
        children: [
          Expanded(flex: 2, child: Text("FIELD", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text("EXTRACTED VALUE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          Expanded(flex: 1, child: Text("CONFIDENCE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("SOURCE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
          SizedBox(width: 100, child: Text("ACTION", textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildRow(ZenoSemanticColors colors, AIExtractedField field) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(field.label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
          Expanded(flex: 3, child: ZenoTextField(label: null, initialValue: field.value, onChanged: (v) => field.value = v)),
          Expanded(flex: 1, child: _buildConfidenceBadge(colors, field.confidence)),
          Expanded(flex: 2, child: Text(field.source, style: const TextStyle(fontSize: 11, color: Colors.grey))),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(value: field.isAccepted, onChanged: (v) => setState(() => field.isAccepted = v ?? false)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceBadge(ZenoSemanticColors colors, double confidence) {
    final color = confidence > 0.9 ? colors.statusSuccess : confidence > 0.7 ? colors.statusWarning : colors.statusError;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
      child: Text("${(confidence * 100).toInt()}%", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _buildFooter(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.borderSubtle))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ZenoButton(label: "CANCEL", variant: ZenoButtonVariant.ghost, onPressed: () => Navigator.pop(context)),
          const SizedBox(width: 12),
          ZenoButton(label: "ACCEPT & POPULATE", onPressed: () => Navigator.pop(context, widget.fields.where((f) => f.isAccepted).toList())),
        ],
      ),
    );
  }
}
