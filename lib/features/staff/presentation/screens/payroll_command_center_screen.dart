import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/staff_controller.dart';
import '../../domain/models/payroll_record.dart';

class PayrollCommandCenterScreen extends StatefulWidget {
  const PayrollCommandCenterScreen({super.key});

  @override
  State<PayrollCommandCenterScreen> createState() => _PayrollCommandCenterScreenState();
}

class _PayrollCommandCenterScreenState extends State<PayrollCommandCenterScreen> {
  late final StaffController controller;

  @override
  void initState() {
    super.initState();
    controller = sl<StaffController>();
  }

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace(
      header: ZenoHeader(
        title: "Payroll Control Hub".toUpperCase(),
        subtitle: "ORCHESTRATING STATUTORY COMPLIANCE AND SALARY DISBURSEMENT.",
        actions: [
          ZenoButton(
            label: "Generate Payslips",
            icon: Icons.picture_as_pdf_outlined,
            variant: ZenoButtonVariant.secondary,
            size: ZenoButtonSize.sm,
            onPressed: () {},
          ),
          ZenoButton(
            label: "Disburse Salaries",
            icon: Icons.payments_rounded,
            size: ZenoButtonSize.sm,
            onPressed: () {},
          ),
        ],
      ),
      body: ZenoTable<PayrollRecord>(
        items: controller.payrollHistory,
        columns: [
          ZenoTableColumn(label: "EMPLOYEE", width: 250, builder: (p) => Text(p.employeeId.toUpperCase())),
          ZenoTableColumn(label: "MONTH", width: 120, builder: (p) => Text(p.month)),
          ZenoTableColumn(label: "GROSS", width: 120, isNumeric: true, builder: (p) => Text("₹${p.grossAmount.toInt()}")),
          ZenoTableColumn(label: "TAXES", width: 100, isNumeric: true, builder: (p) => Text("₹${p.taxes.toInt()}")),
          ZenoTableColumn(label: "NET SALARY", width: 120, isNumeric: true, builder: (p) => Text("₹${p.netAmount.toInt()}", 
            style: const TextStyle(fontWeight: FontWeight.bold))),
          ZenoTableColumn(label: "STATUS", builder: (p) => ZenoBadge(
            label: p.isPaid ? "PAID" : "PENDING", 
            color: p.isPaid ? Colors.green : Colors.orange
          )),
        ],
      ),
    );
  }
}
