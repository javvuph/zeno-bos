import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_bloc.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_event.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_state.dart';
import 'package:zeno/features/inventory/presentation/widgets/attribute_input.dart';
import 'package:zeno/app/theme.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _nameController = TextEditingController();
  final Map<String, String> _attributeValues = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        return Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          color: ZenoTheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Add New Product",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Industry: ${state.currentIndustry.displayName}",
                  style: const TextStyle(
                      color: ZenoTheme.accent, fontWeight: FontWeight.w600)),
              const Divider(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Standard Field
                      const Text("Product Name",
                          style: TextStyle(
                              fontSize: 12, color: ZenoTheme.textSecondary)),
                      TextField(
                        controller: _nameController,
                        decoration: _inputDecoration(),
                      ),
                      const SizedBox(height: 24),

                      // Dynamic Fields based on Schema
                      const Text("Industry Specific Attributes",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ZenoTheme.textPrimary)),
                      const SizedBox(height: 16),
                      ...state.currentIndustry.attributes
                          .map((attr) => AttributeInput(
                                definition: attr,
                                value: _attributeValues[attr.key],
                                onChanged: (val) =>
                                    _attributeValues[attr.key] = val,
                              )),

                      // AI Tools
                      if (state.status == InventoryStatus.loading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child:
                              LinearProgressIndicator(color: ZenoTheme.accent),
                        )
                      else if (state.aiGeneratedDescription != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(top: 16, bottom: 16),
                          decoration: BoxDecoration(
                              color: ZenoTheme.accent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.auto_awesome,
                                      size: 14, color: ZenoTheme.accent),
                                  SizedBox(width: 8),
                                  Text("AI Suggestion:",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(state.aiGeneratedDescription!,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.auto_awesome, size: 16),
                      label: const Text("AI Magic"),
                      onPressed: () {
                        context.read<InventoryBloc>().add(GenerateAIDescription(
                              productName: _nameController.text,
                              attributes: _attributeValues,
                            ));
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ZenoTheme.accent),
                      onPressed: () {
                        // Save logic here
                      },
                      child: const Text("Save Product"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: ZenoTheme.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: ZenoTheme.border)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: ZenoTheme.border)),
    );
  }
}
