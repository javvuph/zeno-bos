import 'dart:math';
import '../models/delivery_order.dart';
import '../repositories/i_delivery_repository.dart';

class DeliveryWorkflowService {
  final IDeliveryRepository _repository;
  DeliveryWorkflowService(this._repository);

  Future<void> transitionStatus(
      DeliveryOrder order, DeliveryStatus newStatus) async {
    final updatedOrder = DeliveryOrder(
      id: order.id,
      salesOrderId: order.salesOrderId,
      customerId: order.customerId,
      address: order.address,
      destinationGps: order.destinationGps,
      status: newStatus,
      expectedDeliveryTime: order.expectedDeliveryTime,
      aiOptimizationData: order.aiOptimizationData,
    );
    await _repository.saveDeliveryOrder(updatedOrder);
  }

  String generateOTP() {
    return (Random().nextInt(900000) + 100000).toString();
  }

  bool verifyOTP(String orderId, String inputOtp, String actualOtp) {
    return inputOtp == actualOtp;
  }
}
