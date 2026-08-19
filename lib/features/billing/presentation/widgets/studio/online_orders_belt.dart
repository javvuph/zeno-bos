import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class OnlineOrdersBelt extends StatelessWidget {
  const OnlineOrdersBelt({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.flash_on_rounded,
                  size: 18, color: Color(0xFF6366F1)),
              const SizedBox(width: 10),
              const Text("INCOMING ONLINE ORDERS",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5)),
              const SizedBox(width: 14),
              _CountBadge(count: 5, colors: colors),
              const Spacer(),
              const Text("View All Orders ›",
                  style: TextStyle(
                      fontSize: 9,
                      color: Color(0xFF6366F1),
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _OrderCard(
                    status: "New",
                    orderId: "#1034",
                    time: "2m",
                    name: "Lucy",
                    amount: "₹850",
                    phone: "9876543210",
                    colors: colors),
                _OrderCard(
                    status: "New",
                    orderId: "#1035",
                    time: "3m",
                    name: "",
                    amount: "₹1.2k",
                    phone: "9123456789",
                    colors: colors),
                _OrderCard(
                    status: "Preparing",
                    orderId: "#1032",
                    time: "18m",
                    name: "Maria",
                    amount: "₹2.4k",
                    phone: "9988776655",
                    colors: colors,
                    statusColor: Colors.orange),
                _OrderCard(
                    status: "Ready",
                    orderId: "#1031",
                    time: "28m",
                    name: "Ahmed",
                    amount: "₹1.1k",
                    phone: "9445566778",
                    colors: colors,
                    statusColor: Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final String status;
  final String orderId;
  final String time;
  final String name;
  final String amount;
  final String phone;
  final ZenoSemanticColors colors;
  final Color? statusColor;

  const _OrderCard(
      {required this.status,
      required this.orderId,
      required this.time,
      required this.name,
      required this.amount,
      required this.phone,
      required this.colors,
      this.statusColor});

  @override
  Widget build(BuildContext context) {
    // Show Name if exists, otherwise show Phone Number
    final String displayName = name.isNotEmpty ? name : "+91 $phone";

    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _StatusTag(label: status, color: statusColor ?? Colors.red),
              const SizedBox(width: 4),
              Text(orderId,
                  style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B))),
              const Spacer(),
              Text(time,
                  style: const TextStyle(fontSize: 7, color: Colors.grey)),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                  radius: 8,
                  backgroundColor: const Color(0xFFF1F5F9),
                  child: Text(displayName[0],
                      style: const TextStyle(
                          fontSize: 7, fontWeight: FontWeight.bold))),
              const SizedBox(width: 6),
              Expanded(
                  child: Text(displayName,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E293B)),
                      overflow: TextOverflow.ellipsis)),
              Text(amount,
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B))),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: _ActionBtn(
                label: status == "New" ? "Accept" : "View",
                color: status == "New" ? Colors.green : Colors.blue,
                colors: colors),
          ),
        ],
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  final String label;
  final Color color;
  const _StatusTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 7, fontWeight: FontWeight.bold)),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final ZenoSemanticColors colors;
  const _ActionBtn(
      {required this.label, required this.color, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color.withValues(alpha: 0.2))),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 8, fontWeight: FontWeight.bold)),
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  final ZenoSemanticColors colors;
  const _CountBadge({required this.count, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Text("$count New",
          style: const TextStyle(
              color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
    );
  }
}
