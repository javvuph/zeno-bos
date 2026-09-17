import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/report_definition.dart';
import '../controllers/reports_controller.dart';
import 'package:uuid/uuid.dart';

class ReportBuilderScreen extends StatefulWidget {
  final ReportDefinition? existingReport;
  const ReportBuilderScreen({super.key, this.existingReport});

  @override
  State<ReportBuilderScreen> createState() => _ReportBuilderScreenState();
}

class _ReportBuilderScreenState extends State<ReportBuilderScreen> {
  late final ReportsController _controller;
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  ReportModule _module = ReportModule.custom;
  ReportVisualization _visualization = ReportVisualization.table;

  @override
  void initState() {
    super.initState();
    _controller = sl<ReportsController>();
    if (widget.existingReport != null) {
      _nameController.text = widget.existingReport!.name;
      _descController.text = widget.existingReport!.description;
      _module = widget.existingReport!.module;
      _visualization = widget.existingReport!.visualization;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: widget.existingReport == null ? "Build Neural Report" : "Refine Report",
      breadcrumbs: const ["Reports", "Builder"],
      onSave: () async {
        final report = ReportDefinition(
          id: widget.existingReport?.id ?? const Uuid().v4(),
          name: _nameController.text,
          description: _descController.text,
          module: _module,
          dataSource: _module.name, 
          visualization: _visualization,
          ownerId: 'admin_1',
          createdAt: widget.existingReport?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _controller.saveReport(report);
        if (mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Identity \u0026 Classification",
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Report Name", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Description", border: OutlineInputBorder()),
              maxLines: 2,
            ),
          ],
        ),
        ZenoFormSection(
          title: "Data Source \u0026 Module",
          children: [
            DropdownButtonFormField<ReportModule>(
              initialValue: _module,
              decoration: const InputDecoration(labelText: "Data Module", border: OutlineInputBorder()),
              items: ReportModule.values.map((m) => DropdownMenuItem(value: m, child: Text(m.name.toUpperCase()))).toList(),
              onChanged: (v) => setState(() => _module = v!),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Visualization Strategy",
          children: [
            DropdownButtonFormField<ReportVisualization>(
              initialValue: _visualization,
              decoration: const InputDecoration(labelText: "Primary View", border: OutlineInputBorder()),
              items: ReportVisualization.values.map((v) => DropdownMenuItem(value: v, child: Text(v.name.toUpperCase()))).toList(),
              onChanged: (v) => setState(() => _visualization = v!),
            ),
          ],
        ),
      ],
    );
  }
}
