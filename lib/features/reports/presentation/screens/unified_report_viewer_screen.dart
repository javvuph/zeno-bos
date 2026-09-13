import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/reports_controller.dart';
import '../../domain/models/report_definition.dart';

class UnifiedReportViewerScreen extends StatefulWidget {
  final String reportTitle;
  final String module;
  const UnifiedReportViewerScreen({super.key, required this.reportTitle, required this.module});

  @override
  State<UnifiedReportViewerScreen> createState() => _UnifiedReportViewerScreenState();
}

class _UnifiedReportViewerScreenState extends State<UnifiedReportViewerScreen> {
  late final ReportsController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<ReportsController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _initReport();
    });
  }

  void _initReport() {
    final existing = controller.customReports.firstWhere(
      (r) => r.module.name == widget.module,
      orElse: () => ReportDefinition(
        id: 'default_${widget.module}',
        name: widget.reportTitle,
        description: 'Auto-generated report for ${widget.module}',
        module: ReportModule.custom,
        dataSource: widget.module,
        visualization: ReportVisualization.table,
        ownerId: 'system',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
    controller.setActiveReport(existing);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.activeReport == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(widget.reportTitle.toUpperCase(), 
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.refresh), onPressed: _initReport),
                    IconButton(icon: const Icon(Icons.file_download_outlined), onPressed: () {}),
                  ],
                ),
              ),
              Expanded(
                child: controller.isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : _buildReportView(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReportView() {
    if (controller.activeReportData.isEmpty) {
      return const Center(child: Text("No data matching filters found."));
    }

    final data = controller.activeReportData;
    final keys = data.first.keys.toList();
    
    return ZenoTable(
      items: data,
      columns: keys.map((key) {
        return ZenoTableColumn(
          label: key.toUpperCase(),
          builder: (row) => Text((row as Map<String, dynamic>)[key]?.toString() ?? '-'),
        );
      }).toList(),
    );
  }
}
