import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:uuid/uuid.dart';
import '../../domain/repositories/i_product_repository.dart';
import '../controllers/product_controller.dart';
import '../../domain/models/product.dart';
import '../../domain/models/sku.dart';
import '../../domain/models/unit.dart';
import 'widgets/form/product_form_widgets.dart';

class ProductFormScreen extends StatefulWidget {
  final bool isEdit;
  final String? productId;

  const ProductFormScreen({super.key, this.isEdit = false, this.productId});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  late final ProductController controller;
  final _nameController = TextEditingController(), _descController = TextEditingController(), _skuController = TextEditingController(), _basePriceController = TextEditingController(), _baseCostController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = ProductController(sl<IProductRepository>());
    if (widget.isEdit && widget.productId != null) _loadProduct();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() { if (mounted) setState(() {}); }

  Future<void> _loadProduct() async {
    await controller.loadProduct(widget.productId!);
    final p = controller.currentProduct;
    if (p != null) {
      _nameController.text = p.name; _descController.text = p.description ?? '';
      _skuController.text = p.sku.value; _basePriceController.text = p.basePrice.toString();
      _baseCostController.text = p.baseCost.toString();
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    _nameController.dispose(); _descController.dispose(); _skuController.dispose(); _basePriceController.dispose(); _baseCostController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final product = Product(
      id: widget.productId ?? const Uuid().v4(), name: _nameController.text, description: _descController.text, sku: SKU(_skuController.text),
      unit: const Unit(id: 'unit_pc', name: 'Piece', symbol: 'Pc'),
      basePrice: double.tryParse(_basePriceController.text) ?? 0.0, baseCost: double.tryParse(_baseCostController.text) ?? 0.0,
      createdAt: DateTime.now(), updatedAt: DateTime.now(),
    );
    await controller.saveProduct(product);
    if (mounted && controller.error == null) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return ZenoWorkspace(
      header: ZenoHeader(
        title: widget.isEdit ? "Edit Product Identity" : "Product Studio / New",
        subtitle: "DESIGNING CORE CATALOG DATA AND SUPPLY CHAIN PARAMETERS.",
        actions: [
          ZenoButton(label: "Discard", icon: Icons.close_rounded, variant: ZenoButtonVariant.secondary, size: ZenoButtonSize.sm, onPressed: () => Navigator.pop(context)),
          ZenoButton(label: widget.isEdit ? "Update Identity" : "Publish Product", icon: Icons.publish_rounded, size: ZenoButtonSize.sm, onPressed: _handleSave),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(ZenoSpacing.xl),
        child: Column(children: [
          if (controller.error != null) FormErrorBar(error: controller.error!, colors: colors),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 3, child: Column(children: [_buildPrimaryIdentity(), const SizedBox(height: 24), _buildFinancialParams()])),
            const SizedBox(width: 24),
            Expanded(flex: 2, child: Column(children: [StudioPreviewCard(colors: colors), const SizedBox(height: 24), AIAssistCard(colors: colors)])),
          ]),
        ]),
      ),
    );
  }

  Widget _buildPrimaryIdentity() {
    return ZenoCard(title: "1. PRIMARY IDENTITY", child: Column(children: [
      ZenoTextField(label: "Canonical Name", controller: _nameController, hint: "Enter clear product title...", isRequired: true),
      const SizedBox(height: 24),
      ZenoTextField(label: "Strategic Description", controller: _descController, hint: "Technical specifications, materials, or features...", maxLines: 4),
      const SizedBox(height: 24),
      Row(children: [
        Expanded(child: ZenoTextField(label: "SKU / Barcode ID", controller: _skuController, hint: "e.g. PRD-9001", isRequired: true)),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Business Configuration", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
              const SizedBox(height: 8),
              Text("🔒 ${controller.currentProduct?.category?.name ?? 'Standard Retail'}", style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ]),
    ]));
  }

  Widget _buildFinancialParams() {
    return ZenoCard(title: "2. FINANCIAL PARAMETERS", child: Column(children: [
      Row(children: [
        Expanded(child: ZenoTextField(label: "Base Cost (Excl. Tax)", controller: _baseCostController, prefix: const Text("₹", style: TextStyle(fontWeight: FontWeight.bold)))),
        const SizedBox(width: 24),
        Expanded(child: ZenoTextField(label: "Target Sale Price", controller: _basePriceController, prefix: const Text("₹", style: TextStyle(fontWeight: FontWeight.bold)))),
      ]),
    ]));
  }
}
