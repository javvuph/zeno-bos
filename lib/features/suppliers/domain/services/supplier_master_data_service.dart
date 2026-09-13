import '../models/supplier.dart';
import '../models/supplier_rating.dart';
import '../models/supplier_payment_terms.dart';

class SupplierMasterDataService {
  List<Supplier> getMockSuppliers() => [
        Supplier(
          id: 'VND-201',
          supplierCode: 'VND-201',
          type: SupplierType.company,
          name: 'Global Electronics Ltd',
          category: 'Hardware',
          email: 'sales@global.com',
          phone: '+1 444 555 666',
          currency: 'USD',
          isPreferred: true,
          averageLeadTime: 3,
          rating: const SupplierRating(
            overallScore: 0.98,
            qualityScore: 0.96,
            deliveryScore: 0.99,
            valueScore: 0.95,
            perfectOrderCount: 45,
            totalOrderCount: 46,
          ),
          createdAt: DateTime.now().subtract(const Duration(days: 500)),
          updatedAt: DateTime.now(),
        ),
        Supplier(
          id: 'VND-202',
          supplierCode: 'VND-202',
          type: SupplierType.company,
          name: 'Tech Logistics Inc',
          category: 'Services',
          email: 'ops@techlog.com',
          phone: '+1 222 333 444',
          currency: 'USD',
          averageLeadTime: 2,
          rating: const SupplierRating(
            overallScore: 0.92,
            qualityScore: 0.90,
            deliveryScore: 0.94,
            valueScore: 0.88,
          ),
          createdAt: DateTime.now().subtract(const Duration(days: 300)),
          updatedAt: DateTime.now(),
        ),
      ];

  List<SupplierPaymentTerms> getStandardTerms() => [
        const SupplierPaymentTerms(id: 'term_1', label: 'Net 30', dueDays: 30),
        const SupplierPaymentTerms(id: 'term_2', label: 'Net 60', dueDays: 60),
        const SupplierPaymentTerms(
            id: 'term_3',
            label: '2/10 Net 30',
            dueDays: 30,
            discountPercentage: 2.0,
            discountDays: 10),
        const SupplierPaymentTerms(
            id: 'term_4', label: 'Immediate', dueDays: 0),
      ];
}
