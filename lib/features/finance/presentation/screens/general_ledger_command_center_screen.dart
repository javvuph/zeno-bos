import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../controllers/ledger_controller.dart';
import '../manifests/ledger_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/journal_entry.dart';

class GeneralLedgerCommandCenterScreen extends StatefulWidget {
  const GeneralLedgerCommandCenterScreen({super.key});

  @override
  State<GeneralLedgerCommandCenterScreen> createState() =>
      _GeneralLedgerCommandCenterScreenState();
}

class _GeneralLedgerCommandCenterScreenState
    extends State<GeneralLedgerCommandCenterScreen> {
  late final LedgerController controller;
  final manifest = const LedgerWorkspaceManifest();
  JournalEntry? _selectedEntry;

  @override
  void initState() {
    super.initState();
    controller = LedgerController(sl<IFinanceRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedEntry),
        isVisible: _selectedEntry != null,
        onClose: () => setState(() => _selectedEntry = null),
      ),
      body: ZenoTable<JournalEntry>(
        items: controller.journalEntries,
        onRowTap: (j) => setState(() => _selectedEntry = j),
        selectedItems: _selectedEntry != null ? [_selectedEntry!] : [],
        columns: manifest.tableColumns(context),
        trafficLightSelector: (j) {
          if (j.status == JournalEntryStatus.posted) {
            return ZenoTrafficLight.success;
          }
          if (j.status == JournalEntryStatus.draft) {
            return ZenoTrafficLight.info;
          }
          return ZenoTrafficLight.danger;
        },
      ),
    );
  }
}
