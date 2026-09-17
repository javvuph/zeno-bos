part of '../isar_finance_repository.dart';

extension IsarFinanceRepositoryAssetsTaxPart on IsarFinanceRepository {
  Future<List<FixedAsset>> getFixedAssetsImpl() async {
    final results = await assetCol.where().findAll();
    return results
        .map((e) => FixedAsset(
              id: e.uuid,
              assetCode: e.assetCode,
              name: e.name,
              categoryId: e.categoryId,
              groupId: e.groupId,
              acquisitionDate: e.acquisitionDate,
              purchaseValue: e.purchaseValue,
              currentBookValue: e.currentBookValue,
              residualValue: e.residualValue,
              depreciationMethod: DepreciationMethod.values.firstWhere(
                  (m) => m.name == e.depreciationMethod,
                  orElse: () => DepreciationMethod.straightLine),
              usefulLifeMonths: e.usefulLifeMonths,
              locationId: e.locationId,
              custodianId: e.custodianId,
              status: AssetStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => AssetStatus.active),
              insurancePolicyNumber: e.insurancePolicyNumber,
              insuranceExpiry: e.insuranceExpiry,
              warrantyExpiry: e.warrantyExpiry,
              isCapitalized: e.isCapitalized,
              capitalizationDate: e.capitalizationDate,
            ))
        .toList();
  }

  Future<void> saveFixedAssetImpl(FixedAsset asset) async {
    final existing = await assetCol.filter().uuidEqualTo(asset.id).findFirst();
    final entry = (existing ?? FixedAssetCollection())
      ..uuid = asset.id
      ..assetCode = asset.assetCode
      ..name = asset.name
      ..categoryId = asset.categoryId
      ..groupId = asset.groupId
      ..acquisitionDate = asset.acquisitionDate
      ..purchaseValue = asset.purchaseValue
      ..currentBookValue = asset.currentBookValue
      ..residualValue = asset.residualValue
      ..depreciationMethod = asset.depreciationMethod.name
      ..usefulLifeMonths = asset.usefulLifeMonths
      ..locationId = asset.locationId
      ..custodianId = asset.custodianId
      ..status = asset.status.name
      ..insurancePolicyNumber = asset.insurancePolicyNumber
      ..insuranceExpiry = asset.insuranceExpiry
      ..warrantyExpiry = asset.warrantyExpiry
      ..isCapitalized = asset.isCapitalized
      ..capitalizationDate = asset.capitalizationDate;

    await db.isar.writeTxn(() async {
      await assetCol.put(entry);
    });
  }

  Future<List<AssetMaintenance>> getAssetMaintenanceImpl(String assetId) async {
    final results =
        await maintenanceCol.filter().assetIdEqualTo(assetId).findAll();
    return results
        .map((e) => AssetMaintenance(
              id: e.uuid,
              assetId: e.assetId,
              maintenanceDate: e.maintenanceDate,
              description: e.description,
              cost: e.cost,
              status: MaintenanceStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => MaintenanceStatus.scheduled),
              vendorName: e.vendorName,
            ))
        .toList();
  }

  Future<void> recordAssetMaintenanceImpl(AssetMaintenance maintenance) async {
    final existing =
        await maintenanceCol.filter().uuidEqualTo(maintenance.id).findFirst();
    final entry = (existing ?? AssetMaintenanceCollection())
      ..uuid = maintenance.id
      ..assetId = maintenance.assetId
      ..maintenanceDate = maintenance.maintenanceDate
      ..description = maintenance.description
      ..cost = maintenance.cost
      ..status = maintenance.status.name
      ..vendorName = maintenance.vendorName;

    await db.isar.writeTxn(() async {
      await maintenanceCol.put(entry);
    });
  }

  Future<List<TaxRule>> getTaxRulesImpl() async {
    final results = await taxRuleCol.where().findAll();
    return results
        .map((e) => TaxRule(
              id: e.uuid,
              code: e.code,
              name: e.name,
              country: e.country,
              state: e.state,
              type: TaxType.values.firstWhere((t) => t.name == e.type,
                  orElse: () => TaxType.gst),
              category: TaxCategory.values.firstWhere(
                  (c) => c.name == e.category,
                  orElse: () => TaxCategory.custom),
              rate: e.rate,
              effectiveDate: e.effectiveDate,
              expiryDate: e.expiryDate,
              isReverseCharge: e.isReverseCharge,
            ))
        .toList();
  }

  Future<void> saveTaxRuleImpl(TaxRule rule) async {
    final existing = await taxRuleCol.filter().uuidEqualTo(rule.id).findFirst();
    final entry = (existing ?? TaxRuleCollection())
      ..uuid = rule.id
      ..code = rule.code
      ..name = rule.name
      ..country = rule.country
      ..state = rule.state
      ..type = rule.type.name
      ..category = rule.category.name
      ..rate = rule.rate
      ..effectiveDate = rule.effectiveDate
      ..expiryDate = rule.expiryDate
      ..isReverseCharge = rule.isReverseCharge;

    await db.isar.writeTxn(() async {
      await taxRuleCol.put(entry);
    });
  }

  Future<List<TaxReturn>> getTaxReturnsImpl() async {
    final results = await taxReturnCol.where().findAll();
    return results
        .map((e) => TaxReturn(
              id: e.uuid,
              periodId: e.periodId,
              type: e.type,
              filingDate: e.filingDate,
              totalTaxableValue: e.totalTaxableValue,
              totalTaxAmount: e.totalTaxAmount,
              inputTaxCredit: e.inputTaxCredit,
              status: TaxReturnStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => TaxReturnStatus.draft),
              filingReference: e.filingReference,
            ))
        .toList();
  }

  Future<void> saveTaxReturnImpl(TaxReturn taxReturn) async {
    final existing =
        await taxReturnCol.filter().uuidEqualTo(taxReturn.id).findFirst();
    final entry = (existing ?? TaxReturnCollection())
      ..uuid = taxReturn.id
      ..periodId = taxReturn.periodId
      ..type = taxReturn.type
      ..filingDate = taxReturn.filingDate
      ..totalTaxableValue = taxReturn.totalTaxableValue
      ..totalTaxAmount = taxReturn.totalTaxAmount
      ..inputTaxCredit = taxReturn.inputTaxCredit
      ..status = taxReturn.status.name
      ..filingReference = taxReturn.filingReference;

    await db.isar.writeTxn(() async {
      await taxReturnCol.put(entry);
    });
  }

  Future<List<ClosingTask>> getClosingChecklistImpl(String periodId) async {
    final results =
        await closingTaskCol.filter().periodIdEqualTo(periodId).findAll();
    return results
        .map((e) => ClosingTask(
              id: e.uuid,
              title: e.title,
              description: e.description,
              category: e.category,
              status: ClosingTaskStatus.values.firstWhere(
                  (s) => s.name == e.status,
                  orElse: () => ClosingTaskStatus.pending),
              isMandatory: e.isMandatory,
              assignedTo: e.assignedTo,
              completedAt: e.completedAt,
            ))
        .toList();
  }

  Future<void> updateClosingTaskImpl(ClosingTask task) async {
    final existing =
        await closingTaskCol.filter().uuidEqualTo(task.id).findFirst();
    if (existing != null) {
      existing.status = task.status.name;
      existing.completedAt = task.completedAt;
      await db.isar.writeTxn(() async {
        await closingTaskCol.put(existing);
      });
    }
  }
}
