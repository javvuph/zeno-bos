import 'package:zeno/features/billing/domain/models/bill.dart';
import 'package:zeno/features/billing/domain/models/bill_item.dart';
import 'package:zeno/features/billing/domain/models/billing_customer.dart';
import 'package:zeno/features/billing/domain/repositories/i_billing_repository.dart';
import 'package:zeno/features/billing/domain/models/tax_details.dart';

class MockBillingRepository implements IBillingRepository {
  final List<Bill> _heldBills = [];

  final List<BillingCustomer> _mockCustomers = [
    const BillingCustomer(
      id: 'CUST-001',
      name: 'John Doe',
      phone: '9876543210',
      loyaltyTier: 'Gold',
      currentBalance: 500.0,
    ),
    const BillingCustomer(
      id: 'CUST-002',
      name: 'Jane Smith',
      phone: '9123456789',
      loyaltyTier: 'Silver',
    ),
  ];

  final List<BillItem> _mockProducts = [
    const BillItem(
      productId: 'PROD-001',
      productName: 'iPhone 15 Pro Max',
      sku: 'PHN-15-PRO',
      variant: 'Natural Titanium / 256GB',
      unitPrice: 1199.0,
      quantity: 1,
      totalAmount: 1199.0,
      taxes: [TaxDetails(label: 'GST', percentage: 18, amount: 0)],
    ),
    const BillItem(
      productId: 'PROD-002',
      productName: 'MacBook Air M3',
      sku: 'MAC-AIR-M3',
      variant: 'Space Gray',
      unitPrice: 1099.0,
      quantity: 1,
      totalAmount: 1099.0,
      taxes: [TaxDetails(label: 'GST', percentage: 18, amount: 0)],
    ),
    const BillItem(
      productId: 'PROD-003',
      productName: 'ZENO Enterprise Mug',
      sku: 'MUG-ZEN-001',
      variant: 'White / 350ml',
      unitPrice: 25.0,
      quantity: 1,
      totalAmount: 25.0,
      taxes: [TaxDetails(label: 'VAT', percentage: 5, amount: 0)],
    ),
  ];

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
