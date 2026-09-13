import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/quotation_controller.dart';
import '../manifests/quotation_workspace_manifest.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/quotation.dart';

class QuotationCommandCenterScreen extends StatefulWidget {
  const QuotationCommandCenterScreen({super.key});

  @override
  State<QuotationCommandCenterScreen> createState() =>
      _QuotationCommandCenterScreenState();
}

class _QuotationCommandCenterScreenState
    extends State<QuotationCommandCenterScreen> {
  late final QuotationController controller;
  final manifest = const QuotationWorkspaceManifest();
  Quotation? _selectedQuote;

  @override
  void initState() {
    super.initState();
    controller = QuotationController(sl<ICustomerRepository>());
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
        tabs: manifest.inspectorTabs(context, _selectedQuote),
        isVisible: _selectedQuote != null,
        onClose: () => setState(() => _selectedQuote = null),
      ),
      body: ZenoTable<Quotation>(
        items: controller.quotations,
        onRowTap: (q) => setState(() => _selectedQuote = q),
        selectedItems: _selectedQuote != null ? [_selectedQuote!] : [],
        columns: manifest.tableColumns(context),
      ),
    );
  }
}
