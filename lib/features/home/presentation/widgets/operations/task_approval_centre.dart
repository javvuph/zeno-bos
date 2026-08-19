import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';

class TaskApprovalCentre extends StatefulWidget {
  const TaskApprovalCentre({super.key});

  @override
  State<TaskApprovalCentre> createState() => _TaskApprovalCentreState();
}

class _TaskApprovalCentreState extends State<TaskApprovalCentre> {
  int activeTab = 0; // 0: Approvals, 1: Tasks

  @override
  Widget build(BuildContext context) {
    return BISectionContainer(
      title:
          activeTab == 0 ? "Strategic Approval Center" : "Operational Task Hub",
      accentColor: activeTab == 0 ? Colors.amber : Colors.blue,
      trailing: _buildTabs(),
      child: Column(
        children: [
          Expanded(
              child: activeTab == 0 ? _buildApprovalList() : _buildTaskList()),
          _hubFooter(),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _tabItem("APPROVALS", activeTab == 0, 0),
        const SizedBox(width: 8),
        _tabItem("TASKS", activeTab == 1, 1),
      ],
    );
  }

  Widget _tabItem(String label, bool active, int index) {
    return InkWell(
      onTap: () => setState(() => activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: active
              ? ZenoTheme.accent.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border:
              Border.all(color: active ? ZenoTheme.accent : ZenoTheme.border),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: active ? ZenoTheme.accent : ZenoTheme.textSecondary)),
      ),
    );
  }

  Widget _buildApprovalList() {
    final items = BIMockData.getApprovals();
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      separatorBuilder: (_, __) =>
          const Divider(color: ZenoTheme.border, height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return Row(
          children: [
            _categoryIcon(item['type']!),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['type']!.toString().toUpperCase(),
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: Colors.amber)),
                      Text(item['time']!,
                          style: const TextStyle(
                              fontSize: 9, color: ZenoTheme.textSecondary)),
                    ],
                  ),
                  Text(item['from']!,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(item['msg']!,
                      style: const TextStyle(
                          fontSize: 10, color: ZenoTheme.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _actionBtn(Icons.close, Colors.red, "Reject"),
            const SizedBox(width: 8),
            _actionBtn(Icons.check, ZenoTheme.neonGreen, "Approve"),
            const SizedBox(width: 8),
            _actionBtn(
                Icons.visibility_outlined, ZenoTheme.textSecondary, "Details"),
          ],
        );
      },
    );
  }

  Widget _buildTaskList() {
    final tasks = [
      {"title": "Quarterly Tax Filing", "due": "Today", "p": "Critical"},
      {"title": "Staff Meeting", "due": "14:00 PM", "p": "Medium"},
      {"title": "Audit North WH", "due": "Tomorrow", "p": "High"},
      {"title": "Supplier Review", "due": "28 Jul", "p": "Low"},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: tasks.length,
      separatorBuilder: (_, __) =>
          const Divider(color: ZenoTheme.border, height: 16),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Row(
          children: [
            Checkbox(
                value: false,
                onChanged: (v) {},
                visualDensity: VisualDensity.compact,
                side: const BorderSide(color: ZenoTheme.border)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task['title']!,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Text("Due: ${task['due']} • Priority: ${task['p']}",
                      style: const TextStyle(
                          fontSize: 10, color: ZenoTheme.textSecondary)),
                ],
              ),
            ),
            Row(
              children: [
                _actionBtn(
                    Icons.person_add_alt_1, ZenoTheme.neonCyan, "Assign"),
                const SizedBox(width: 6),
                _actionBtn(
                    Icons.check_circle_outline, ZenoTheme.neonGreen, "Done"),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _hubFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: ZenoTheme.background.withValues(alpha: 0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _miniStat("Pending Approvals", "8", Colors.amber),
          _miniStat("Tasks Today", "5", Colors.blue),
          _miniStat("Overdue", "2", Colors.red),
          _miniStat("Meetings", "3", ZenoTheme.neonCyan),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String val, Color color) {
    return Row(
      children: [
        Text("$val ",
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w900, color: color)),
        Text(label,
            style:
                const TextStyle(fontSize: 8, color: ZenoTheme.textSecondary)),
      ],
    );
  }

  Widget _categoryIcon(String type) {
    IconData icon = Icons.receipt_long_outlined;
    if (type == 'Leave') icon = Icons.beach_access_outlined;
    if (type == 'Discount') icon = Icons.sell_outlined;
    if (type == 'Credit') icon = Icons.credit_card_outlined;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          color: ZenoTheme.border, borderRadius: BorderRadius.circular(6)),
      child: Icon(icon, size: 16, color: ZenoTheme.textSecondary),
    );
  }

  Widget _actionBtn(IconData icon, Color color, String tip) {
    return Tooltip(
      message: tip,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4)),
          child: Icon(icon, size: 14, color: color),
        ),
      ),
    );
  }
}
