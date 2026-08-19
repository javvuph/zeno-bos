import '../models/fixed_asset.dart';
import '../models/asset_maintenance.dart';

class AssetLifecycleEngine {
  /// Calculates depreciation based on the specified method
  double calculateDepreciation(FixedAsset asset, DateTime asOfDate) {
    if (asOfDate.isBefore(asset.acquisitionDate)) return 0.0;

    int monthsOwned = (asOfDate.year - asset.acquisitionDate.year) * 12 +
        asOfDate.month -
        asset.acquisitionDate.month;
    if (monthsOwned <= 0) return 0.0;

    if (asset.depreciationMethod == DepreciationMethod.straightLine) {
      double annualDep = (asset.purchaseValue - asset.residualValue) /
          (asset.usefulLifeMonths / 12);
      return (annualDep / 12) * monthsOwned;
    }

    // Default fallback
    return 0.0;
  }

  /// AI-Driven Asset Health Score
  double calculateHealthScore(
      FixedAsset asset, List<AssetMaintenance> history) {
    double baseScore = asset.aiHealthScore;

    // Deduct for overdue maintenance
    final overdueCount = history
        .where((m) =>
            m.status == MaintenanceStatus.scheduled &&
            m.maintenanceDate.isBefore(DateTime.now()))
        .length;
    baseScore -= (overdueCount * 10);

    // Deduct for age
    int ageMonths =
        DateTime.now().difference(asset.acquisitionDate).inDays ~/ 30;
    double lifeUsed = ageMonths / asset.usefulLifeMonths;
    baseScore -= (lifeUsed * 20);

    return baseScore.clamp(0, 100);
  }

  /// Predicts next maintenance date based on frequency and history
  DateTime predictNextMaintenance(
      FixedAsset asset, List<AssetMaintenance> history) {
    if (history.isEmpty) return DateTime.now().add(const Duration(days: 90));
    final last =
        history.where((m) => m.status == MaintenanceStatus.completed).toList();
    if (last.isEmpty) return DateTime.now().add(const Duration(days: 30));

    last.sort((a, b) => b.maintenanceDate.compareTo(a.maintenanceDate));
    return last.first.maintenanceDate
        .add(const Duration(days: 180)); // Mock 6 month cycle
  }
}
