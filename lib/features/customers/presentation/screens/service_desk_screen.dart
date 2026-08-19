import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/crm_controller.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_badge.dart';
import '../../domain/models/ticket.dart';

class ServiceDeskScreen extends StatefulWidget {
  const ServiceDeskScreen({super.key});

  @override
  State<ServiceDeskScreen> createState() => _ServiceDeskScreenState();
}

class _ServiceDeskScreenState extends State<ServiceDeskScreen> {
  late final CRMController controller;

  @override
  void initState() {
    super.initState();
    controller = CRMController(sl<ICustomerRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Service Desk \u0026 SLA Management Hub",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ZenoTable<Ticket>(
            items: controller.tickets,
            columns: [
              ZenoTableColumn<Ticket>(
                  label: "TICKET NO",
                  width: 120,
                  builder: (t) => Text(t.ticketNumber)),
              ZenoTableColumn<Ticket>(
                  label: "SUBJECT",
                  width: 250,
                  builder: (t) => Text(t.subject.toUpperCase())),
              ZenoTableColumn<Ticket>(
                  label: "PRIORITY",
                  width: 120,
                  builder: (t) => ZenoBadge(
                      label: t.priority.name.toUpperCase(),
                      color: _getPriorityColor(t.priority))),
              ZenoTableColumn<Ticket>(
                  label: "STATUS",
                  width: 120,
                  builder: (t) => Text(t.status.name.toUpperCase())),
              ZenoTableColumn<Ticket>(
                  label: "SLA DEADLINE",
                  builder: (t) => Text(
                      t.slaDeadline.toString().substring(0, 16),
                      style: TextStyle(
                          color: t.isSlaBreached ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(TicketPriority p) {
    switch (p) {
      case TicketPriority.critical:
        return Colors.red;
      case TicketPriority.high:
        return Colors.orange;
      case TicketPriority.medium:
        return Colors.blue;
      case TicketPriority.low:
        return Colors.grey;
    }
  }
}
