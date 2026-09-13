import 'package:get_it/get_it.dart';
import 'package:zeno/core/ai/ai_gateway.dart';
import 'package:zeno/core/ai/providers/gemini_provider.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/services/global_context_manager.dart';
import 'package:zeno/core/sync/sync_manager.dart';
import 'package:zeno/core/sync/replication_manager.dart';

// Repositories
import 'package:zeno/features/administration/domain/repositories/i_administration_repository.dart';
import 'package:zeno/features/administration/data/repositories/isar_administration_repository.dart';
import 'package:zeno/features/billing/domain/repositories/i_billing_repository.dart';
import 'package:zeno/features/billing/data/repositories/isar_billing_repository.dart';
import 'package:zeno/features/customers/domain/repositories/i_customer_repository.dart';
import 'package:zeno/features/customers/data/repositories/isar_customer_repository.dart';
import 'package:zeno/features/delivery/domain/repositories/i_delivery_repository.dart';
import 'package:zeno/features/delivery/data/repositories/isar_delivery_repository.dart';
import 'package:zeno/features/finance/domain/repositories/i_finance_repository.dart';
import 'package:zeno/features/finance/data/repositories/isar_finance_repository.dart';
import 'package:zeno/features/inventory/domain/repositories/i_inventory_repository.dart';
import 'package:zeno/features/inventory/data/repositories/isar_inventory_repository.dart';
import 'package:zeno/features/inventory/domain/repositories/i_product_repository.dart';
import 'package:zeno/features/inventory/data/repositories/isar_product_repository.dart';
import 'package:zeno/features/orders/domain/repositories/i_sales_repository.dart';
import 'package:zeno/features/orders/domain/repositories/i_fnb_repository.dart';
import 'package:zeno/features/orders/data/repositories/isar_sales_repository.dart';
import 'package:zeno/features/orders/data/repositories/isar_fnb_repository.dart';
import 'package:zeno/features/ai_center/domain/repositories/i_ai_repository.dart';
import 'package:zeno/features/ai_center/data/repositories/isar_ai_repository.dart';
import 'package:zeno/features/purchase/domain/repositories/i_purchase_repository.dart';
import 'package:zeno/features/purchase/data/repositories/isar_purchase_repository.dart';
import 'package:zeno/features/staff/domain/repositories/i_staff_repository.dart';
import 'package:zeno/features/staff/data/repositories/isar_staff_repository.dart';
import 'package:zeno/features/suppliers/domain/repositories/i_supplier_repository.dart';
import 'package:zeno/features/suppliers/data/repositories/isar_supplier_repository.dart';
import 'package:zeno/features/reports/domain/repositories/i_reports_repository.dart';
import 'package:zeno/features/reports/data/repositories/isar_reports_repository.dart';
import 'package:zeno/features/settings/domain/repositories/i_settings_repository.dart';
import 'package:zeno/features/settings/data/repositories/isar_settings_repository.dart';
import 'package:zeno/features/automation/domain/repositories/i_automation_repository.dart';
import 'package:zeno/features/automation/domain/repositories/automation_repository_impl.dart';
import 'package:zeno/features/governance/domain/repositories/i_governance_repository.dart';
import 'package:zeno/features/governance/domain/repositories/governance_repository_impl.dart';

import 'package:zeno/core/services/settings_service.dart';
import 'package:zeno/core/localization/country_registry.dart';
import 'package:zeno/core/localization/currency_service.dart';
import 'package:zeno/core/localization/tax_service.dart';
import 'package:zeno/features/inventory/data/services/ai_product_service.dart';
import 'package:zeno/features/purchase/domain/services/inventory_update_service.dart';
import 'package:zeno/features/purchase/domain/services/finance_journal_service.dart';
import 'package:zeno/features/purchase/domain/services/finance_journal_service.dart';
import 'package:zeno/features/billing/domain/services/billing_finance_service.dart';
import 'package:zeno/features/billing/domain/services/billing_sync_service.dart';
import 'package:zeno/features/delivery/domain/services/delivery_workflow_service.dart';
import 'package:zeno/features/staff/domain/services/payroll_processing_service.dart';
import 'package:zeno/core/integrations/upi_payment_service.dart';
import 'package:zeno/core/integrations/thermal_printer_service.dart';
import 'package:zeno/core/integrations/communication_service.dart';
import 'package:zeno/core/integrations/location_service.dart';
import 'package:zeno/core/integrations/biometric_auth_service.dart';
import 'package:zeno/features/inventory/domain/services/recipe_deduction_service.dart';
import 'package:zeno/features/orders/domain/services/kot_engine.dart';
import 'package:zeno/features/ai_center/domain/services/ai_context_service.dart';

// Controllers
import 'package:zeno/features/ai_center/presentation/controllers/ai_controller.dart';
import 'package:zeno/features/reports/presentation/controllers/reports_controller.dart';
import 'package:zeno/features/finance/presentation/controllers/finance_controller.dart';
import 'package:zeno/features/staff/presentation/controllers/staff_controller.dart';
import 'package:zeno/features/customers/presentation/controllers/customer_controller.dart';
import 'package:zeno/features/suppliers/presentation/controllers/supplier_controller.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_controller.dart';
import 'package:zeno/features/orders/presentation/controllers/sales_controller.dart';
import 'package:zeno/features/delivery/presentation/controllers/delivery_controller.dart';
import 'package:zeno/features/administration/presentation/controllers/administration_controller.dart';
import 'package:zeno/features/administration/presentation/controllers/store_setup_controller.dart';
import 'package:zeno/features/automation/presentation/controllers/automation_controller.dart';
import 'package:zeno/features/governance/presentation/controllers/governance_controller.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // --- LAYER 1: Core Foundation (Non-lazy) ---
  sl.registerSingleton<GlobalContextManager>(GlobalContextManager());

  final settingsService = SettingsService();
  sl.registerSingleton<SettingsService>(settingsService);

  final dbService = DatabaseService();
  await dbService.init();
  sl.registerSingleton<DatabaseService>(dbService);

  // --- LAYER 2: Core Infrastructure (Lazy) ---
  sl.registerLazySingleton<SyncManager>(() => SyncManager(sl()));
  sl.registerLazySingleton<ReplicationManager>(
      () => ReplicationManager(sl(), sl(), sl()));

  // AI Gateway
  const String geminiKey = String.fromEnvironment('GEMINI_API_KEY');
  if (geminiKey.isNotEmpty) {
    sl.registerLazySingleton<AIGateway>(
        () => GeminiAIProvider(apiKey: geminiKey));
  } else {
    sl.registerLazySingleton<AIGateway>(() => MockAIProvider());
  }

  // --- LAYER 3: Feature Repositories (Lazy) ---
  _registerRepositories();

  // --- LAYER 4: Feature Services (Lazy) ---
  _registerServices();

  // --- LAYER 5: Integrations (Lazy) ---
  _registerIntegrations();

  // --- LAYER 6: Shared Controllers (Lazy) ---
  _registerControllers();

  // Initialize Essential Foundation
  await sl<SettingsService>().init();
}

void _registerRepositories() {
  sl.registerLazySingleton<IAdministrationRepository>(
      () => IsarAdministrationRepository(sl()));
  sl.registerLazySingleton<IBillingRepository>(
      () => IsarBillingRepository(sl()));
  sl.registerLazySingleton<ICustomerRepository>(
      () => IsarCustomerRepository(sl()));
  sl.registerLazySingleton<IDeliveryRepository>(
      () => IsarDeliveryRepository(sl()));
  sl.registerLazySingleton<IFinanceRepository>(
      () => IsarFinanceRepository(sl()));
  sl.registerLazySingleton<IInventoryRepository>(
      () => IsarInventoryRepository(sl()));
  sl.registerLazySingleton<IProductRepository>(
      () => IsarProductRepository(sl()));
  sl.registerLazySingleton<IFnbRepository>(
      () => IsarFnbRepository(sl()));
  sl.registerLazySingleton<ISalesRepository>(() => IsarSalesRepository(sl()));
  sl.registerLazySingleton<IAIRepository>(() => IsarAIRepository(sl()));
  sl.registerLazySingleton<IPurchaseRepository>(
      () => IsarPurchaseRepository(sl()));
  sl.registerLazySingleton<IStaffRepository>(() => IsarStaffRepository(sl()));
  sl.registerLazySingleton<ISupplierRepository>(
      () => IsarSupplierRepository(sl()));
  sl.registerLazySingleton<IReportsRepository>(
      () => IsarReportsRepository(sl()));
  sl.registerLazySingleton<ISettingsRepository>(
      () => IsarSettingsRepository(sl()));
  sl.registerLazySingleton<IAutomationRepository>(
      () => AutomationRepositoryImpl());
  sl.registerLazySingleton<IGovernanceRepository>(
      () => GovernanceRepositoryImpl());
}

void _registerServices() {
  sl.registerLazySingleton(() => CurrencyService());
  sl.registerLazySingleton(() => TaxService());
  sl.registerLazySingleton(() => AIProductService(sl<AIGateway>()));
  sl.registerLazySingleton(() => InventoryUpdateService(sl()));
  sl.registerLazySingleton(() => FinanceJournalService(sl()));
  sl.registerLazySingleton(() => BillingFinanceService(sl()));
  sl.registerLazySingleton(() => BillingSyncService(sl()));
  sl.registerLazySingleton(() => DeliveryWorkflowService(sl()));
  sl.registerLazySingleton(() => PayrollProcessingService(sl()));
  sl.registerLazySingleton(() => AIContextService());
  sl.registerLazySingleton(() => RecipeDeductionService(sl(), sl<DatabaseService>().isar));
  sl.registerLazySingleton(() => KotEngine(sl(), sl<DatabaseService>().isar));
}

void _registerIntegrations() {
  sl.registerLazySingleton(() => UPIPaymentService());
  sl.registerLazySingleton(() => ThermalPrinterService());
  sl.registerLazySingleton(() => CommunicationService());
  sl.registerLazySingleton(() => LocationService());
  sl.registerLazySingleton(() => BiometricAuthService());
}

void _registerControllers() {
  sl.registerLazySingleton(() => AIController(sl()));
  sl.registerLazySingleton(() => ReportsController(sl()));
  sl.registerLazySingleton(() => FinanceController(sl()));
  sl.registerLazySingleton(() => StaffController(sl()));
  sl.registerLazySingleton(() => CustomerController(sl()));
  sl.registerLazySingleton(() => SupplierController(sl()));
  sl.registerLazySingleton(() => InventoryController(sl()));
  sl.registerLazySingleton(() => SalesController(sl()));
  sl.registerLazySingleton(() => DeliveryController(sl()));
  sl.registerLazySingleton(() => AdministrationController(sl()));
  sl.registerLazySingleton(() => StoreSetupController());
  sl.registerLazySingleton(() => AutomationController(sl()));
  sl.registerLazySingleton(() => GovernanceController(sl()));
}
