import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/customer_segment.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/customer_controller.dart';

class CustomerGroupScreen extends StatefulWidget {
  const CustomerGroupScreen({super.key});

  @override
  State<CustomerGroupScreen> createState() => _CustomerGroupScreenState();
}

class _CustomerGroupScreenState extends State<CustomerGroupScreen> {
  final controller = CustomerController(sl<ICustomerRepository>());

  @override
  void initState() {
    super.initState();
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
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final items = controller.groups;

    return Column(
      children: [
        ZenoHeader(
          title: "Customer Groups & Segments".toUpperCase(),
          subtitle:
              "ORGANIZE YOUR CUSTOMER BASE INTO STRATEGIC CLUSTERS FOR TARGETED MARKETING.",
          actions: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.group_add_outlined),
              label: const Text("NEW GROUP"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accentPrimary,
                  foregroundColor: Colors.black),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ZenoTable<CustomerSegment>(
              items: items,
              columns: [
                ZenoTableColumn(
                  label: "Group Name",
                  builder: (g) => Row(
                    children: [
                      Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                              color: _parseColor(g.color),
                              shape: BoxShape.circle)),
                      const SizedBox(width: 12),
                      Text(g.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ZenoTableColumn(
                  label: "Description",
                  builder: (g) => Text(g.description ?? "No description",
                      style: TextStyle(color: colors.textSecondary)),
                ),
                ZenoTableColumn(
                  label: "Identifier",
                  width: 150,
                  builder: (g) => Text(g.id.toUpperCase(),
                      style: const TextStyle(fontFamily: 'monospace')),
                ),
                ZenoTableColumn(
                  label: "Actions",
                  width: 100,
                  builder: (g) => IconButton(
                      icon: const Icon(Icons.edit_outlined), onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _parseColor(String? colorStr) {
    if (colorStr == null || !colorStr.startsWith('#')) return Colors.grey;
    try {
      return Color(int.parse(colorStr.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.grey;
    }
  }
}
