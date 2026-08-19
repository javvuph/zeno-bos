import 'supplier_address.dart';
import 'supplier_contact.dart';
import 'supplier_bank_details.dart';
import 'supplier_tax_profile.dart';
import 'supplier_payment_terms.dart';
import 'supplier_rating.dart';
import 'supplier_agreement.dart';

enum SupplierType { individual, company }

enum SupplierStatus { active, inactive, blacklisted, pending }

enum SupplierTier { bronze, silver, gold, platinum }

class Supplier {
  final String id;
  final String supplierCode;
  final SupplierType type;
  final String name;
  final String? legalName;
  final String category;
  final String email;
  final String phone;
  final String? mobile;
  final String? whatsapp;
  final String? website;
  final String status;
  final SupplierTier tier;
  final String currency;
  final bool isPreferred;
  final bool isStrategic;

  // BUSINESS & LEGAL
  final String? registrationNumber;
  final String? licenseNumber;
  final List<String> certifications;

  // FINANCIAL
  final double creditLimit;
  final int creditDays;
  final double outstandingBalance;
  final String? upiId;
  final List<SupplierBankDetails> bankAccounts;
  final SupplierPaymentTerms? paymentTerms;

  // PROCUREMENT
  final int averageLeadTime; // in days
  final double? moq; // Minimum Order Quantity
  final List<String> suppliedCategories;

  // PERFORMANCE
  final double onTimeDeliveryPercent;
  final double qualityRating;
  final double priceCompetitiveness;
  final double returnPercent;
  final double delayPercent;
  final SupplierRating rating;

  final List<SupplierContact> contacts;
  final List<SupplierAddress> addresses;
  final SupplierTaxProfile? taxProfile;
  final List<SupplierAgreement> agreements;
  final Map<String, dynamic> aiProfile; // AI Risk, Spend Analysis, etc.

  final DateTime createdAt;
  final DateTime updatedAt;

  const Supplier({
    required this.id,
    required this.supplierCode,
    required this.type,
    required this.name,
    this.legalName,
    required this.category,
    required this.email,
    required this.phone,
    this.mobile,
    this.whatsapp,
    this.website,
    this.status = "Active",
    this.tier = SupplierTier.silver,
    required this.currency,
    this.isPreferred = false,
    this.isStrategic = false,
    this.registrationNumber,
    this.licenseNumber,
    this.certifications = const [],
    this.creditLimit = 0.0,
    this.creditDays = 30,
    this.outstandingBalance = 0.0,
    this.upiId,
    this.bankAccounts = const [],
    this.paymentTerms,
    this.averageLeadTime = 0,
    this.moq,
    this.suppliedCategories = const [],
    this.onTimeDeliveryPercent = 0.0,
    this.qualityRating = 0.0,
    this.priceCompetitiveness = 0.0,
    this.returnPercent = 0.0,
    this.delayPercent = 0.0,
    this.rating = const SupplierRating(),
    this.contacts = const [],
    this.addresses = const [],
    this.taxProfile,
    this.agreements = const [],
    this.aiProfile = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  Supplier copyWith({
    String? name,
    String? legalName,
    String? category,
    String? email,
    String? phone,
    String? status,
    SupplierTier? tier,
    bool? isPreferred,
    bool? isStrategic,
    double? creditLimit,
    double? outstandingBalance,
    int? averageLeadTime,
    SupplierRating? rating,
    Map<String, dynamic>? aiProfile,
    DateTime? updatedAt,
  }) {
    return Supplier(
      id: id,
      supplierCode: supplierCode,
      type: type,
      name: name ?? this.name,
      legalName: legalName ?? this.legalName,
      category: category ?? this.category,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile,
      whatsapp: whatsapp,
      website: website,
      status: status ?? this.status,
      tier: tier ?? this.tier,
      currency: currency,
      isPreferred: isPreferred ?? this.isPreferred,
      isStrategic: isStrategic ?? this.isStrategic,
      registrationNumber: registrationNumber,
      licenseNumber: licenseNumber,
      certifications: certifications,
      creditLimit: creditLimit ?? this.creditLimit,
      creditDays: creditDays,
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      upiId: upiId,
      bankAccounts: bankAccounts,
      paymentTerms: paymentTerms,
      averageLeadTime: averageLeadTime ?? this.averageLeadTime,
      moq: moq,
      suppliedCategories: suppliedCategories,
      onTimeDeliveryPercent: onTimeDeliveryPercent,
      qualityRating: qualityRating,
      priceCompetitiveness: priceCompetitiveness,
      returnPercent: returnPercent,
      delayPercent: delayPercent,
      rating: rating ?? this.rating,
      contacts: contacts,
      addresses: addresses,
      taxProfile: taxProfile,
      agreements: agreements,
      aiProfile: aiProfile ?? this.aiProfile,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
