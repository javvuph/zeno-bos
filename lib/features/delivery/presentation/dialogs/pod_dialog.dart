import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/delivery_order.dart';
import '../../domain/models/pod.dart';
import 'package:uuid/uuid.dart';

class PODDialog extends StatefulWidget {
  final DeliveryOrder order;
  final Function(ProofOfDelivery) onConfirm;

  const PODDialog({super.key, required this.order, required this.onConfirm});

  @override
  State<PODDialog> createState() => _PODDialogState();
}

class _PODDialogState extends State<PODDialog> {
  final _otpController = TextEditingController();
  final _recipientController = TextEditingController();
  bool _isVerifying = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return AlertDialog(
      title: Text("PROOF OF DELIVERY - ${widget.order.id}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _recipientController,
            decoration: const InputDecoration(
                labelText: "Recipient Name", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _otpController,
            decoration: const InputDecoration(
                labelText: "Delivery OTP", border: OutlineInputBorder()),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: colors.borderSubtle),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text("SIGNATURE CAPTURE AREA")),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL")),
        ElevatedButton(
          onPressed: _isVerifying
              ? null
              : () async {
                  setState(() => _isVerifying = true);
                  // Simulate OTP verification
                  await Future.delayed(const Duration(seconds: 1));

                  final pod = ProofOfDelivery(
                    id: const Uuid().v4(),
                    deliveryOrderId: widget.order.id,
                    otp: _otpController.text,
                    recipientName: _recipientController.text,
                    timestamp: DateTime.now(),
                  );

                  widget.onConfirm(pod);
                  if (mounted) Navigator.pop(context);
                },
          child: const Text("CONFIRM DELIVERY"),
        ),
      ],
    );
  }
}
