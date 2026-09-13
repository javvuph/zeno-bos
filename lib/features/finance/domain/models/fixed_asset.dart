import 'asset_status.dart';

enum DepreciationMethod { straightLine, reducingBalance, doubleDeclining }

class FixedAsset {
  final String id;
  final String assetCode;
  final String name;
  final String categoryId;
  final String groupId;
  final DateTime acquisitionDate;
  final double purchaseValue;
  final double currentBookValue;
  final double residualValue;
  final DepreciationMethod depreciationMethod;
  final int usefulLifeMonths;
  final String? locationId;
  final String? custodianId;
  final AssetStatus status;
  final String? insurancePolicyNumber;
  final DateTime? insuranceExpiry;
  final DateTime? warrantyExpiry;
  final bool isCapitalized;
  final DateTime? capitalizationDate;
  final double aiUtilizationScore;
  final double aiHealthScore;

  const FixedAsset({
    required this.id,
    required this.assetCode,
    required this.name,
    required this.categoryId,
    required this.groupId,
    required this.acquisitionDate,
    required this.purchaseValue,
    this.currentBookValue = 0.0,
    this.residualValue = 0.0,
    this.depreciationMethod = DepreciationMethod.straightLine,
    this.usefulLifeMonths = 60,
    this.locationId,
    this.custodianId,
    this.status = AssetStatus.acquired,
    this.insurancePolicyNumber,
    this.insuranceExpiry,
    this.warrantyExpiry,
    this.isCapitalized = false,
    this.capitalizationDate,
    this.aiUtilizationScore = 100.0,
    this.aiHealthScore = 100.0,
  });

  FixedAsset copyWith({
    double? currentBookValue,
    AssetStatus? status,
    String? locationId,
    String? custodianId,
    double? aiUtilizationScore,
    double? aiHealthScore,
  }) {
    return FixedAsset(
      id: id,
      assetCode: assetCode,
      name: name,
      categoryId: categoryId,
      groupId: groupId,
      acquisitionDate: acquisitionDate,
      purchaseValue: purchaseValue,
      currentBookValue: currentBookValue ?? this.currentBookValue,
      residualValue: residualValue,
      depreciationMethod: depreciationMethod,
      usefulLifeMonths: usefulLifeMonths,
      locationId: locationId ?? this.locationId,
      custodianId: custodianId ?? this.custodianId,
      status: status ?? this.status,
      insurancePolicyNumber: insurancePolicyNumber,
      insuranceExpiry: insuranceExpiry,
      warrantyExpiry: warrantyExpiry,
      isCapitalized: isCapitalized,
      capitalizationDate: capitalizationDate,
      aiUtilizationScore: aiUtilizationScore ?? this.aiUtilizationScore,
      aiHealthScore: aiHealthScore ?? this.aiHealthScore,
    );
  }
}
