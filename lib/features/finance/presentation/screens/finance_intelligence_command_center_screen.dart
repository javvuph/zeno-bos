import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import '../controllers/finance_intelligence_controller.dart';
import '../manifests/finance_intelligence_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/finance_insight.dart';

class FinanceIntelligenceCommandCenterScreen extends StatefulWidget {
  const FinanceIntelligenceCommandCenterScreen({super.key});

  @override
  State<FinanceIntelligenceCommandCenterScreen> createState() =>
      _FinanceIntelligenceCommandCenterScreenState();
}

class _FinanceIntelligenceCommandCenterScreenState
    extends State<FinanceIntelligenceCommandCenterScreen> {
  final controller = FinanceIntelligenceController();
  final manifest = const FinanceIntelligenceManifest();
  FinanceIntelligenceInsight? _selectedInsight;

  @override
  void initState() {
    super.initState();
    controller.runFullIntelligenceAnalysis();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      isLoading: controller.isLoading,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedInsight),
        isVisible: _selectedInsight != null,
        onClose: () => setState(() => _selectedInsight = null),
      ),
      body: ZenoTable<FinanceIntelligenceInsight>(
        items: controller.insights,
        onRowTap: (i) => setState(() => _selectedInsight = i),
        selectedItems: _selectedInsight != null ? [_selectedInsight!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
