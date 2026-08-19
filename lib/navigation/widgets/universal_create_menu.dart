import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../navigation_controller.dart';

class ZenoUniversalCreateMenu extends StatefulWidget {
  const ZenoUniversalCreateMenu({super.key});

  @override
  State<ZenoUniversalCreateMenu> createState() =>
      _ZenoUniversalCreateMenuState();
}

class _ZenoUniversalCreateMenuState extends State<ZenoUniversalCreateMenu> {
  String searchQuery = "";

  final List<Map<String, dynamic>> _actions = [
    {
      "label": "New Sales Invoice",
      "icon": Icons.receipt_long,
      "route": "billing/sales/new",
      "category": "Sales"
    },
    {
      "label": "New Purchase Order",
      "icon": Icons.shopping_bag,
      "route": "suppliers/procurement/orders",
      "category": "Purchase"
    },
    {
      "label": "Add New Customer",
      "icon": Icons.person_add,
      "route": "customers/mgmt/add",
      "category": "Customers"
    },
    {
      "label": "Add New Supplier",
      "icon": Icons.business,
      "route": "suppliers/mgmt/add",
      "category": "Suppliers"
    },
    {
      "label": "Add New Product",
      "icon": Icons.add_box,
      "route": "inventory/products/add",
      "category": "Inventory"
    },
    {
      "label": "New Expense Entry",
      "icon": Icons.money_off,
      "route": "finance/overview/expenses",
      "category": "Finance"
    },
    {
      "label": "Create Delivery Task",
      "icon": Icons.local_shipping,
      "route": "delivery/ops/create",
      "category": "Logistics"
    },
    {
      "label": "New Payment Received",
      "icon": Icons.payments,
      "route": "billing/payments/cash",
      "category": "Finance"
    },
    {
      "label": "Add New Employee",
      "icon": Icons.person_add_alt,
      "route": "staff/mgmt/add",
      "category": "HR"
    },
    {
      "label": "New Journal Entry",
      "icon": Icons.edit_note,
      "route": "finance/accounts/journal",
      "category": "Accounting"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final nav = NavigationController();
    final filteredActions = _actions
        .where((a) =>
            a['label'].toLowerCase().contains(searchQuery.toLowerCase()) ||
            a['category'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Material(
      color: Colors.black.withValues(alpha: 0.4),
      child: Stack(
        children: [
          GestureDetector(onTap: nav.toggleCreateMenu),
          Positioned(
            top: 60,
            left: 300, // Roughly below the create button
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: ZenoTheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ZenoTheme.border),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 30)
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSearchField(),
                  const Divider(height: 1, color: ZenoTheme.border),
                  _buildActionsList(nav, filteredActions),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline,
              size: 18, color: ZenoTheme.accent),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              autofocus: true,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: "What would you like to create?",
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (v) => setState(() => searchQuery = v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsList(
      NavigationController nav, List<Map<String, dynamic>> actions) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return ListTile(
            leading:
                Icon(action['icon'], size: 18, color: ZenoTheme.textSecondary),
            title: Text(action['label'],
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            subtitle: Text(action['category'].toUpperCase(),
                style: const TextStyle(
                    fontSize: 9,
                    color: ZenoTheme.textSecondary,
                    letterSpacing: 0.5)),
            onTap: () {
              nav.openTab(action['route'], title: action['label']);
              nav.toggleCreateMenu();
            },
          );
        },
      ),
    );
  }
}
