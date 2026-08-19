import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/staff_controller.dart';
import '../../domain/models/leave.dart';

class LeaveManagementScreen extends StatefulWidget {
  const LeaveManagementScreen({super.key});

  @override
  State<LeaveManagementScreen> createState() => _LeaveManagementScreenState();
}

class _LeaveManagementScreenState extends State<LeaveManagementScreen> {
  late final StaffController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<StaffController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Leave \u0026 Time-Off Workflow Hub", 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ZenoTable<LeaveRequest>(
            items: controller.leaveRequests,
            columns: [
              ZenoTableColumn(label: "EMPLOYEE", width: 250, builder: (l) => Text(l.employeeId.toUpperCase())),
              ZenoTableColumn(label: "TYPE", width: 120, builder: (l) => Text(l.type.toUpperCase())),
              ZenoTableColumn(label: "FROM", width: 120, builder: (l) => Text(l.startDate.toString().substring(0, 10))),
              ZenoTableColumn(label: "TO", width: 120, builder: (l) => Text(l.endDate.toString().substring(0, 10))),
              ZenoTableColumn(label: "STATUS", width: 140, builder: (l) => ZenoBadge(
                label: l.status.name.toUpperCase(), 
                color: _getStatusColor(l.status)
              )),
              ZenoTableColumn(label: "REASON", builder: (l) => Text(l.reason, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(LeaveStatus s) {
    switch (s) {
      case LeaveStatus.approved: return Colors.green;
      case LeaveStatus.rejected: return Colors.red;
      case LeaveStatus.pending: return Colors.orange;
      case LeaveStatus.cancelled: return Colors.grey;
    }
  }
}
