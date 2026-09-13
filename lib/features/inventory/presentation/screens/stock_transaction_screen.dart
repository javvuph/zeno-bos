import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_inventory_repository.dart';
import '../controllers/inventory_controller.dart';

class StockTransactionScreen extends StatefulWidget {
  final String type; // In, Out, Transfer, Adjust

  const StockTransactionScreen({super.key, required this.type});

  @override
  State<StockTransactionScreen> createState() => _StockTransactionScreenState();
}

class _StockTransactionScreenState extends State<StockTransactionScreen> {
  final controller = InventoryController(sl<IInventoryRepository>());
  final _qtyController = TextEditingController();
  final _skuController = TextEditingController();
  final _refController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _qtyController.dispose();
    _skuController.dispose();
    _refController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    final qty = double.tryParse(_qtyController.text) ?? 0;
    if (qty == 0 || _skuController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    if (widget.type.toLowerCase() == 'in') {
      await controller.processInward(_skuController.text, qty, 'current_user');
    } else if (widget.type.toLowerCase() == 'out') {
      await controller.processOutward(_skuController.text, qty, 'current_user');
    } else if (widget.type.toLowerCase() == 'adjust') {
      await controller.processAdjustment(
          _skuController.text, qty, 'current_user', _notesController.text);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "Transaction ${widget.type.toUpperCase()} recorded successfully")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "New Stock ${widget.type.toUpperCase()}",
          subtitle:
              "REGISTER A HIGH-PRECISION ${widget.type.toUpperCase()} TRANSACTION IN THE AUDIT LEDGER.",
          actions: [
            _ActionBtn(
              label: "SUBMIT ${widget.type.toUpperCase()}",
              colors: colors,
              isPrimary: true,
              onTap: _handleSubmit,
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ZenoSpacing.xl),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 720),
                child: ZenoCard(
                  title: "CORE TRANSACTION METRICS",
                  child: Column(
                    children: [
                      ZenoTextField(
                        label: "Source Reference",
                        hint: "E.G. PO-12345 / SO-9982",
                        isRequired: true,
                        controller: _refController,
                      ),
                      const SizedBox(height: ZenoSpacing.lg),
                      Row(
                        children: [
                          Expanded(
                            child: ZenoDropdown<String>(
                              label: "Storage Node",
                              items: const [
                                DropdownMenuItem(
                                    value: "main",
                                    child: Text("MAIN HQ WAREHOUSE")),
                                DropdownMenuItem(
                                    value: "sec",
                                    child: Text("DISTRIBUTION CENTER"))
                              ],
                              onChanged: (v) {},
                              value: "main",
                            ),
                          ),
                          const SizedBox(width: ZenoSpacing.md),
                          Expanded(
                            child: ZenoTextField(
                              label: "Quantity Delta",
                              hint: "0.00",
                              isRequired: true,
                              keyboardType: TextInputType.number,
                              controller: _qtyController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: ZenoSpacing.lg),
                      ZenoTextField(
                        label: "Target Product / SKU / Barcode",
                        hint: "SCAN OR SEARCH MASTER CATALOG...",
                        prefix: const Icon(Icons.qr_code_scanner, size: 18),
                        controller: _skuController,
                      ),
                      const SizedBox(height: ZenoSpacing.lg),
                      ZenoTextField(
                        label: "Audit Notes / Justification",
                        hint: "DESCRIBE REASON FOR MOVEMENT...",
                        maxLines: 3,
                        controller: _notesController,
                      ),
                      const SizedBox(height: ZenoSpacing.xl),
                      _FooterInfo(colors: colors),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  final bool isPrimary;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.label,
      required this.colors,
      this.isPrimary = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
            horizontal: ZenoSpacing.xl, vertical: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
      child: Text(label,
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
    );
  }
}

class _FooterInfo extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _FooterInfo({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.md),
      decoration: BoxDecoration(
        color: colors.bgTier3.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(ZenoRadius.md),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded,
              size: 16, color: colors.textDisabled),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
              child: Text(
                  "ALL TRANSACTIONS ARE PERMANENTLY LOGGED TO THE BLOCKCHAIN-READY AUDIT TRAIL.",
                  style: ZenoTypography.micro(colors.textDisabled))),
        ],
      ),
    );
  }
}
