import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/journal_entry.dart';
import '../../domain/models/journal_line.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/finance_controller.dart';
import 'package:uuid/uuid.dart';

class JournalEntryFormScreen extends StatefulWidget {
  const JournalEntryFormScreen({super.key});

  @override
  State<JournalEntryFormScreen> createState() => _JournalEntryFormScreenState();
}

class _JournalEntryFormScreenState extends State<JournalEntryFormScreen> {
  late FinanceController _controller;
  final _refController = TextEditingController();
  final _descController = TextEditingController();
  final List<JournalLine> _lines = [];

  @override
  void initState() {
    super.initState();
    _controller = FinanceController(sl<IFinanceRepository>());
    _controller.loadChartOfAccounts();
    _refController.text = "JV-${DateTime.now().millisecondsSinceEpoch}";
    _addLine();
    _addLine();
  }

  void _addLine() {
    setState(() {
      _lines.add(const JournalLine(accountId: ''));
    });
  }

  double get _totalDebit => _lines.fold(0, (sum, l) => sum + l.debit);
  double get _totalCredit => _lines.fold(0, (sum, l) => sum + l.credit);
  bool get _isBalanced =>
      (_totalDebit - _totalCredit).abs() < 0.001 && _totalDebit > 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return ZenoInputFormTemplate(
      title: "New Journal Entry",
      breadcrumbs: const ["Finance", "General Ledger", "New Entry"],
      onSave: _isBalanced
          ? () async {
              final entry = JournalEntry(
                id: const Uuid().v4(),
                referenceNumber: _refController.text,
                date: DateTime.now(),
                description: _descController.text,
                lines: _lines,
                createdById: 'admin',
                sourceModule: 'finance',
              );
              await _controller.createJournalEntry(entry);
              if (mounted) Navigator.pop(context);
            }
          : () {},
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Entry Header",
          children: [
            TextField(
              controller: _refController,
              decoration: const InputDecoration(
                  labelText: "Reference #", border: OutlineInputBorder()),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                  labelText: "Description", border: OutlineInputBorder()),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Line Items",
          columns: 1,
          children: [
            ..._lines.asMap().entries.map((entry) {
              final i = entry.key;
              final line = entry.value;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownButtonFormField<String>(
                          initialValue: line.accountId.isEmpty ? null : line.accountId,
                          decoration:
                              const InputDecoration(labelText: "Account"),
                          items: _controller.accounts
                              .map((a) => DropdownMenuItem(
                                  value: a.id,
                                  child: Text("${a.code} - ${a.name}")))
                              .toList(),
                          onChanged: (v) => setState(() {
                            _lines[i] = JournalLine(
                                accountId: v!,
                                debit: line.debit,
                                credit: line.credit);
                          }),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: "Debit"),
                          onChanged: (v) => setState(() {
                            _lines[i] = JournalLine(
                                accountId: line.accountId,
                                debit: double.tryParse(v) ?? 0.0,
                                credit: 0.0);
                          }),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: "Credit"),
                          onChanged: (v) => setState(() {
                            _lines[i] = JournalLine(
                                accountId: line.accountId,
                                debit: 0.0,
                                credit: double.tryParse(v) ?? 0.0);
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            TextButton.icon(
                onPressed: _addLine,
                icon: const Icon(Icons.add),
                label: const Text("ADD LINE")),
          ],
        ),
        ZenoFormSection(
          title: "Balancing Summary",
          children: [
            Text("Total Debit: \$${_totalDebit.toStringAsFixed(2)}",
                style: ZenoTypography.bodyLG(colors.textPrimary)),
            Text("Total Credit: \$${_totalCredit.toStringAsFixed(2)}",
                style: ZenoTypography.bodyLG(colors.textPrimary)),
            Text(_isBalanced ? "BALANCED" : "UNBALANCED",
                style: ZenoTypography.headlineSM(
                    _isBalanced ? colors.statusSuccess : colors.statusDanger)),
          ],
        ),
      ],
    );
  }
}
