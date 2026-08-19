import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'widgets/bulk/bulk_widgets.dart';

class BulkOperationsScreen extends StatelessWidget {
  final bool isImport;
  const BulkOperationsScreen({super.key, this.isImport = true});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(children: [
      ZenoHeader(title: isImport ? "Bulk Import Products" : "Bulk Export Products", subtitle: isImport ? "Upload Excel or CSV files to add or update multiple products at once." : "Download your entire product catalog or specific segments in your preferred format."),
      Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Center(child: Container(constraints: const BoxConstraints(maxWidth: 800), child: Column(children: [
        isImport ? _buildImportCard(colors) : _buildExportCard(colors),
        const SizedBox(height: 24), _buildHistoryCard(colors),
      ]))))),
    ]);
  }

  Widget _buildImportCard(ZenoSemanticColors colors) {
    return ZenoCard(title: "UPLOAD FILE", child: Column(children: [
      Container(height: 200, width: double.infinity, decoration: BoxDecoration(color: colors.bgTier2, borderRadius: BorderRadius.circular(12), border: Border.all(color: colors.borderSubtle)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.upload_file, size: 48, color: colors.accentPrimary), const SizedBox(height: 16),
        Text("Drag and drop your file here", style: ZenoTypography.bodyLG(colors.textPrimary).copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8), Text("Supports .xlsx, .csv, .json", style: ZenoTypography.micro(colors.textSecondary)),
        const SizedBox(height: 24), ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: colors.accentPrimary, foregroundColor: colors.bgTier1), child: const Text("Select File")),
      ])),
      const SizedBox(height: 24), _templateTip(colors),
    ]));
  }

  Widget _templateTip(ZenoSemanticColors colors) {
    return Row(children: [
      Icon(Icons.info_outline, size: 16, color: colors.textSecondary), const SizedBox(width: 8),
      Expanded(child: Text("Download the sample template to ensure correct formatting:", style: ZenoTypography.micro(colors.textSecondary))),
      TextButton.icon(onPressed: () {}, icon: const Icon(Icons.download, size: 14), label: Text("Download Template", style: ZenoTypography.micro(colors.accentPrimary))),
    ]);
  }

  Widget _buildExportCard(ZenoSemanticColors colors) {
    return ZenoCard(title: "EXPORT CONFIGURATION", child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Select Format", style: ZenoTypography.caption(colors.textSecondary).copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 12), Row(children: [FormatOption(label: "Excel (.xlsx)", icon: Icons.table_chart, isSelected: true, colors: colors), const SizedBox(width: 16), FormatOption(label: "CSV (.csv)", icon: Icons.description, colors: colors), const SizedBox(width: 16), FormatOption(label: "PDF (.pdf)", icon: Icons.picture_as_pdf, colors: colors)]),
      const SizedBox(height: 32), Text("Data Segments", style: ZenoTypography.caption(colors.textSecondary).copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 12), Wrap(spacing: 8, runSpacing: 8, children: [BulkFilterChip(label: "All Products", isSelected: true, colors: colors), BulkFilterChip(label: "Electronics", colors: colors), BulkFilterChip(label: "Low Stock Items", colors: colors), BulkFilterChip(label: "Active Variants", colors: colors)]),
      const SizedBox(height: 40), SizedBox(width: double.infinity, height: 48, child: ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.download), label: const Text("Generate and Download"), style: ElevatedButton.styleFrom(backgroundColor: colors.accentPrimary, foregroundColor: colors.bgTier1))),
    ]));
  }

  Widget _buildHistoryCard(ZenoSemanticColors colors) {
    return ZenoCard(title: "RECENT OPERATIONS", child: Column(children: [
      OperationItem(name: "product_import_v2.xlsx", status: "Success", date: "Today, 10:45 AM", details: "450 records processed, 0 errors", isSuccess: true, colors: colors),
      OperationItem(name: "catalog_export_full.csv", status: "Success", date: "Yesterday, 4:12 PM", details: "12,450 records exported", isSuccess: true, colors: colors),
      OperationItem(name: "inventory_sync.json", status: "Failed", date: "2 days ago", details: "Invalid SKU format at row 45", isSuccess: false, colors: colors),
    ]));
  }
}
