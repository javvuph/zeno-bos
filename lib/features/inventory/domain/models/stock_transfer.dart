import 'package:equatable/equatable.dart';

enum TransferStatus { requested, approved, dispatched, inTransit, received, variance, cancelled }

class StockTransfer extends Equatable {
  final String id;
  final String fromStoreId;
  final String toStoreId;
  final String productId;
  final double requestedQty;
  final double approvedQty;
  final double dispatchedQty;
  final double receivedQty;
  final TransferStatus status;
  final String? remarks;
  final DateTime createdAt;

  const StockTransfer({
    required this.id,
    required this.fromStoreId,
    required this.toStoreId,
    required this.productId,
    required this.requestedQty,
    this.approvedQty = 0,
    this.dispatchedQty = 0,
    this.receivedQty = 0,
    this.status = TransferStatus.requested,
    this.remarks,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, status, requestedQty, receivedQty];
}
