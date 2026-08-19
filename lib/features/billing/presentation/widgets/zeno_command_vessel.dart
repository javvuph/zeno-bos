import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/core/widgets/zeno_command_vessel.dart' as core;
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';

class ZenoCommandVessel extends StatelessWidget {
  const ZenoCommandVessel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<BillingStudioController>();

    return core.ZenoCommandVessel(
      hint: "Scan barcode / Search product / or type command",
      onSubmitted: (value) => controller.add(AddItemRequested(value)),
      commands: {
        'cust': (query) => controller.add(SearchCustomerRequested(query)),
        'clear': (_) => controller.add(ClearCartRequested()),
        'hold': (_) => controller.add(BillHoldRequested()),
      },
    );
  }
}
