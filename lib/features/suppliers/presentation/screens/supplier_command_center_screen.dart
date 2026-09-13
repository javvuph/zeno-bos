import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import 'package:zeno/core/widgets/zeno_smart_inspector.dart';
import '../../domain/models/supplier.dart';
import '../../domain/models/supplier_rating.dart';
import '../manifests/suppliers_workspace_manifest.dart';

class SupplierCommandCenterScreen extends StatefulWidget {
  const SupplierCommandCenterScreen({super.key});

  @override
  State<SupplierCommandCenterScreen> createState() =>
      _SupplierCommandCenterScreenState();
}

class _SupplierCommandCenterScreenState
    extends State<SupplierCommandCenterScreen> {
  Supplier? _selectedSupplier;
  final manifest = const SuppliersWorkspaceManifest();

  // Mock data utilizing the new 360° Supplier Model
  final List<Supplier> items = [
    Supplier(
      id: 'SUP-001',
      supplierCode: 'VND-GTECH-99',
      type: SupplierType.company,
      name: 'Global Tech Industries',
      legalName: 'Global Technology Solutions Pvt Ltd',
      category: 'Manufacturer',
      email: 'procurement@globaltech.com',
      phone: '+91 99887 76655',
      currency: 'INR (₹)',
      status: "Active",
      tier: SupplierTier.platinum,
      isPreferred: true,
      isStrategic: true,
      creditLimit: 1500000,
      creditDays: 45,
      outstandingBalance: 124500,
      onTimeDeliveryPercent: 0.98,
      rating: const SupplierRating(overallScore: 0.96),
      averageLeadTime: 4,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Supplier(
      id: 'SUP-002',
      supplierCode: 'VND-NORTH-44',
      type: SupplierType.company,
      name: 'North Apparel Hub',
      category: 'Wholesaler',
      email: 'info@northapparel.in',
      phone: '+91 91234 56789',
      currency: 'INR (₹)',
      status: "Active",
      tier: SupplierTier.gold,
      creditLimit: 500000,
      creditDays: 30,
      outstandingBalance: 42000,
      onTimeDeliveryPercent: 0.85,
      rating: const SupplierRating(overallScore: 0.78),
      averageLeadTime: 7,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Supplier(
      id: 'SUP-003',
      supplierCode: 'VND-LOCAL-12',
      type: SupplierType.individual,
      name: 'Ravi Logistics Services',
      category: 'Local Vendor',
      email: 'ravi.log@gmail.com',
      phone: '+91 98765 43210',
      currency: 'INR (₹)',
      status: "Active",
      tier: SupplierTier.silver,
      creditLimit: 100000,
      creditDays: 15,
      outstandingBalance: 0,
      onTimeDeliveryPercent: 0.92,
      rating: const SupplierRating(overallScore: 0.84),
      averageLeadTime: 2,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ZenoWorkspace.fromManifest(
      manifest: manifest,
      context: context,
      inspector: ZenoSmartInspector(
        tabs: manifest.inspectorTabs(context, _selectedSupplier),
        isVisible: _selectedSupplier != null,
        onClose: () => setState(() => _selectedSupplier = null),
      ),
      body: ZenoTable<Supplier>(
        items: items,
        columns: manifest.tableColumns(context),
        selectedItems: _selectedSupplier != null ? [_selectedSupplier!] : [],
        onRowTap: (s) => setState(() => _selectedSupplier = s),
        trafficLightSelector: (s) => s.rating.overallScore > 0.9
            ? ZenoTrafficLight.success
            : (s.rating.overallScore > 0.7
                ? ZenoTrafficLight.neutral // Replaced 'info' with 'neutral' for safety if info is unstable
                : ZenoTrafficLight.warning),
      ),
    );
  }
}
