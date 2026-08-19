import 'package:zeno/features/billing/domain/models/bill.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/domain/models/billing_customer.dart';

/// Enterprise interface for Billing data operations.
/// Supports Offline-First and Cloud-Sync capabilities.
abstract class IBillingRepository {
  /// Saves a bill to local storage and queues for sync.
  Future<void> saveBill(Bill bill);

  /// Retrieves a specific bill by ID.
  Future<Bill?> getBill(String id);

  /// Retrieves all held bills for the current terminal.
  Future<List<Bill>> getHeldBills();

  /// Searches for a customer by phone or name.
  Future<BillingCustomer?> findCustomer(String query);

  /// Searches for a product by barcode, SKU or name.
  Future<BillItem?> findProduct(String query);

  /// Saves a bill as held.
  Future<void> saveHeldBill(Bill bill);

  // TODO: Add streaming methods for real-time inventory and pricing updates
}
