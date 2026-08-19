import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/delivery_order.dart';
import '../../domain/repositories/i_delivery_repository.dart';
import '../controllers/delivery_controller.dart';
import 'package:uuid/uuid.dart';

class DeliveryOrderFormScreen extends StatefulWidget {
  const DeliveryOrderFormScreen({super.key});

  @override
  State<DeliveryOrderFormScreen> createState() =>
      _DeliveryOrderFormScreenState();
}

class _DeliveryOrderFormScreenState extends State<DeliveryOrderFormScreen> {
  late DeliveryController _controller;
  final _idController = TextEditingController();
  final _orderRefController = TextEditingController();
  final _addressController = TextEditingController();
  final _customerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = DeliveryController(sl<IDeliveryRepository>());
    _idController.text =
        "DEL-${const Uuid().v4().substring(0, 8).toUpperCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: "Create Delivery Assignment",
      breadcrumbs: const ["Logistics", "Queue", "New"],
      onSave: () async {
        final order = DeliveryOrder(
          id: _idController.text,
          salesOrderId: _orderRefController.text,
          customerId: _customerController.text,
          address: _addressController.text,
          status: DeliveryStatus.pending,
          expectedDeliveryTime: DateTime.now().add(const Duration(hours: 4)),
        );
        await _controller.updateStatus(order, DeliveryStatus.pending);
        if (mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Assignment Details",
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                  labelText: "Task ID", border: OutlineInputBorder()),
            ),
            TextField(
              controller: _orderRefController,
              decoration: const InputDecoration(
                  labelText: "Sales Order Ref", border: OutlineInputBorder()),
            ),
            TextField(
              controller: _customerController,
              decoration: const InputDecoration(
                  labelText: "Customer ID", border: OutlineInputBorder()),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                  labelText: "Full Delivery Address",
                  border: OutlineInputBorder()),
              maxLines: 2,
            ),
          ],
        ),
      ],
    );
  }
}
