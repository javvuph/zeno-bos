import 'package:flutter/material.dart';
import '../../domain/repositories/i_finance_repository.dart';
import '../../domain/models/fixed_asset.dart';
import '../../domain/models/asset_status.dart';
import '../../domain/models/asset_maintenance.dart';
import '../../domain/services/finance_master_data_service.dart';

class AssetController extends ChangeNotifier {
  final IFinanceRepository _repository;
  final FinanceMasterDataService _masterData = FinanceMasterDataService();

  AssetController(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<FixedAsset> _assets = [];
  List<FixedAsset> get assets =>
      _assets.isEmpty ? _masterData.getMockAssets() : _assets;

  FixedAsset? _selectedAsset;
  FixedAsset? get selectedAsset => _selectedAsset;

  // KPI Bridges
  double get totalAssetValue =>
      assets.fold(0, (sum, a) => sum + a.purchaseValue);
  double get totalBookValue =>
      assets.fold(0, (sum, a) => sum + a.currentBookValue);
  int get underMaintenanceCount =>
      assets.where((a) => a.status == AssetStatus.underMaintenance).length;

  Future<void> loadAssets() async {
    _isLoading = true;
    notifyListeners();
    try {
      _assets = await _repository.getFixedAssets();
    } catch (e) {
      debugPrint("Error loading assets: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectAsset(FixedAsset asset) {
    _selectedAsset = asset;
    notifyListeners();
  }

  Future<void> recordMaintenance(AssetMaintenance maintenance) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.recordAssetMaintenance(maintenance);
      await loadAssets();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
