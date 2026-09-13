import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';

class ActiveCustomerBanner extends StatelessWidget {
  const ActiveCustomerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        final customer = state.activeBill.customer;
        if (customer == null) return const _WalkInEntryBar();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFF1F5F9),
                child: Text(customer.name[0],
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B))),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(customer.name.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1E293B))),
                        const SizedBox(width: 6),
                        _TierBadge(label: customer.loyaltyTier),
                      ],
                    ),
                    Text("+91 ${customer.phone}",
                        style: const TextStyle(
                            fontSize: 8, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              _buildStat("Points", "4250", const Color(0xFF10B981)),
              _buildStat("Wallet", "₹1,250", const Color(0xFF1E293B)),
              _buildStat("Credit", "₹2,450", const Color(0xFF8B5CF6)),
              _buildStat("Due", "₹2,450", const Color(0xFFEF4444)),
              const VerticalDivider(width: 12, indent: 4, endIndent: 4),
              IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 12),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStat(String label, String value, Color valueColor) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 7,
                  color: Color(0xFF94A3B8),
                  fontWeight: FontWeight.bold)),
          Text(value,
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.w900, color: valueColor)),
        ],
      ),
    );
  }
}

class _WalkInEntryBar extends StatefulWidget {
  const _WalkInEntryBar();

  @override
  State<_WalkInEntryBar> createState() => _WalkInEntryBarState();
}

class _WalkInEntryBarState extends State<_WalkInEntryBar> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_outline_rounded,
              color: Colors.grey, size: 16),
          const SizedBox(width: 12),

          // DUAL COLUMN ENTRY
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _CompactInput(
                    controller: _nameController,
                    hint: "CUSTOMER NAME",
                    icon: Icons.person_outline,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _CompactInput(
                    controller: _phoneController,
                    hint: "PHONE NUMBER*",
                    icon: Icons.phone_android_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // SELECT FROM CONTACTS
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.contact_page_outlined,
                size: 16, color: Color(0xFF6366F1)),
            tooltip: "Select from Contacts",
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          const SizedBox(width: 12),

          // ACTION BUTTON
          ElevatedButton(
            onPressed: () {
              if (_phoneController.text.isNotEmpty) {
                context
                    .read<BillingStudioController>()
                    .add(SearchCustomerRequested(_phoneController.text));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: const Text("SELECT",
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _CompactInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;

  const _CompactInput(
      {required this.controller,
      required this.hint,
      required this.icon,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Icon(icon, size: 12, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B)),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.normal),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TierBadge extends StatelessWidget {
  final String label;
  const _TierBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
            color: Color(0xFFD97706), fontSize: 6, fontWeight: FontWeight.bold),
      ),
    );
  }
}
