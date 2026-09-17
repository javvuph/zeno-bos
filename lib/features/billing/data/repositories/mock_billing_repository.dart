import 'package:zeno/features/billing/domain/models/bill.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/domain/models/billing_customer.dart';
import 'package:zeno/features/billing/domain/repositories/i_billing_repository.dart';

class MockBillingRepository implements IBillingRepository {
  final List<Bill> _heldBills = [];

  final List<BillingCustomer> _mockCustomers = [];

  final List<BillItem> _mockProducts = [];

  @override
  Future<void> saveBill(Bill bill) async {
    _heldBills.removeWhere((b) => b.id == bill.id);
    if (bill.status == 'Held') {
      _heldBills.add(bill);
    }
  }

  @override
  Future<Bill?> getBill(String id) async {
    try {
      return _heldBills.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Bill>> getHeldBills() async {
    return List.unmodifiable(_heldBills);
  }

  @override
  Future<BillingCustomer?> findCustomer(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final q = query.toLowerCase();
    try {
      return _mockCustomers.firstWhere(
        (c) => c.name.toLowerCase().contains(q) || c.phone.contains(q),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<BillItem?> findProduct(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final q = query.toLowerCase();
    try {
      return _mockProducts.firstWhere(
        (p) =>
            p.productId.toLowerCase() == q ||
            p.sku.toLowerCase() == q ||
            p.productName.toLowerCase().contains(q),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveHeldBill(Bill bill) async {
    _heldBills.add(bill);
  }
}
