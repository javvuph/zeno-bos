import 'customer_address.dart';
import 'customer_contact.dart';
import 'customer_tier.dart';
export 'customer_tier.dart';
import 'customer_credit.dart';
import 'customer_loyalty.dart';
import 'customer_note.dart';

enum CustomerType { individual, business, walkIn, corporate }

class Customer {
  final String id;
  final String customerCode;
  final CustomerType type;
  final String name;
  final String? companyName;
  final String? taxId; // GST/VAT
  final String email;
  final String phone;
  final String? whatsapp;
  final CustomerTier tier;
  final String? categoryId;
  final String? segmentId;
  final String? territoryId;
  final String? salesRepId;
  final List<String> groupIds;
  final List<CustomerAddress> addresses;
  final List<CustomerContact> contacts;
  final CustomerCredit credit;
  final CustomerLoyalty loyalty;
  final List<CustomerNote> notes;
  final Map<String, dynamic> aiProfile; // Health Score, Churn, etc.
  final List<String> tags;
  final String? branchId;
  final String? companyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastPurchaseAt;

  const Customer({
    required this.id,
    required this.customerCode,
    required this.type,
    required this.name,
    this.companyName,
    this.taxId,
    required this.email,
    required this.phone,
    this.whatsapp,
    this.tier = CustomerTier.standard,
    this.categoryId,
    this.segmentId,
    this.territoryId,
    this.salesRepId,
    this.groupIds = const [],
    this.addresses = const [],
    this.contacts = const [],
    this.credit = const CustomerCredit(),
    this.loyalty = const CustomerLoyalty(),
    this.notes = const [],
    this.aiProfile = const {},
    this.tags = const [],
    this.branchId,
    this.companyId,
    required this.createdAt,
    required this.updatedAt,
    this.lastPurchaseAt,
  });

  double get outstandingBalance => credit.currentBalance;
  double get lifetimeValue => loyalty.totalSpent;
  double get aiHealthScore =>
      (aiProfile['health_score'] as num?)?.toDouble() ?? 100.0;

  Customer copyWith({
    String? name,
    String? companyName,
    String? taxId,
    String? email,
    String? phone,
    String? whatsapp,
    CustomerTier? tier,
    String? categoryId,
    String? segmentId,
    String? territoryId,
    String? salesRepId,
    List<String>? groupIds,
    List<CustomerAddress>? addresses,
    List<CustomerContact>? contacts,
    CustomerCredit? credit,
    CustomerLoyalty? loyalty,
    List<CustomerNote>? notes,
    Map<String, dynamic>? aiProfile,
    List<String>? tags,
    DateTime? updatedAt,
    DateTime? lastPurchaseAt,
  }) {
    return Customer(
      id: id,
      customerCode: customerCode,
      type: type,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      taxId: taxId ?? this.taxId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      tier: tier ?? this.tier,
      categoryId: categoryId ?? this.categoryId,
      segmentId: segmentId ?? this.segmentId,
      territoryId: territoryId ?? this.territoryId,
      salesRepId: salesRepId ?? this.salesRepId,
      groupIds: groupIds ?? this.groupIds,
      addresses: addresses ?? this.addresses,
      contacts: contacts ?? this.contacts,
      credit: credit ?? this.credit,
      loyalty: loyalty ?? this.loyalty,
      notes: notes ?? this.notes,
      aiProfile: aiProfile ?? this.aiProfile,
      tags: tags ?? this.tags,
      branchId: branchId,
      companyId: companyId,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastPurchaseAt: lastPurchaseAt ?? this.lastPurchaseAt,
    );
  }
}
