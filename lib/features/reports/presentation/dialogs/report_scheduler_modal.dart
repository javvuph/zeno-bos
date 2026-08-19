import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import '../../domain/models/report_definition.dart';

class ReportSchedulerModal extends StatefulWidget {
  final ReportDefinition report;
  const ReportSchedulerModal({super.key, required this.report});

  @override
  State<ReportSchedulerModal> createState() => _ReportSchedulerModalState();
}

class _ReportSchedulerModalState extends State<ReportSchedulerModal> {
  String _frequency = 'Weekly';
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Schedule: ${widget.report.name}".toUpperCase(), 
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
          const SizedBox(height: 24),
          const Text("DELIVERY FREQUENCY", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _frequency,
            items: ['Daily', 'Weekly', 'Monthly'].map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
            onChanged: (v) => setState(() => _frequency = v!),
          ),
          const SizedBox(height: 24),
          const Text("RECIPIENT EMAILS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: "Enter emails separated by comma", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ZenoButton(
              label: "CONFIRM SCHEDULE",
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
