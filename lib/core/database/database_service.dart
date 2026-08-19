import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'collections/inventory_collections.dart';
import 'collections/crm_collections.dart';
import 'collections/transaction_collections.dart';
import 'collections/finance_collections.dart';
import 'collections/staff_collections.dart';
import 'collections/reports_collections.dart';
import 'collections/logistics_collections.dart';
import 'collections/admin_collections.dart';
import 'collections/ai_collections.dart';
import 'collections/fnb_collections.dart';
import 'collections/fnb_reservation_collection.dart';
import 'entities/product_entity.dart';
import '../sync/sync_action.dart';
import '../sync/sync_conflict.dart';
import '../sync/sync_audit_log.dart';

class DatabaseService {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        ProductCollectionSchema,
        CategoryCollectionSchema,
        BrandCollectionSchema,
        WarehouseCollectionSchema,
        StockItemCollectionSchema,
        CustomerCollectionSchema,
        CustomerGroupCollectionSchema,
        CustomerCategoryCollectionSchema,
        SalesTerritoryCollectionSchema,
        CustomerInteractionCollectionSchema,
        LeadCollectionSchema,
        ActivityCollectionSchema,
        CampaignCollectionSchema,
        TicketCollectionSchema,
        SupplierCollectionSchema,
        PurchaseOrderCollectionSchema,
        PurchaseRequisitionCollectionSchema,
        RFQCollectionSchema,
        SupplierQuotationCollectionSchema,
        GRNCollectionSchema,
        SalesOrderCollectionSchema,
        InvoiceCollectionSchema,
        QuotationCollectionSchema,
        OpportunityCollectionSchema,
        AccountCollectionSchema,
        JournalEntryCollectionSchema,
        EmployeeCollectionSchema,
        AttendanceCollectionSchema,
        PayrollCollectionSchema,
        LeaveCollectionSchema,
        DepartmentCollectionSchema,
        DesignationCollectionSchema,
        ShiftCollectionSchema,
        RecruitmentOpeningCollectionSchema,
        RecruitmentCandidateCollectionSchema,
        PerformanceReviewCollectionSchema,
        TrainingProgramCollectionSchema,
        EmployeeDocumentCollectionSchema,
        ReportDefinitionCollectionSchema,
        DashboardDefinitionCollectionSchema,
        ReportScheduleCollectionSchema,
        DeliveryOrderCollectionSchema,
        VehicleCollectionSchema,
        DriverCollectionSchema,
        CompanyCollectionSchema,
        BranchCollectionSchema,
        UserCollectionSchema,
        RoleCollectionSchema,
        BusinessSettingsCollectionSchema,
        AIModelCollectionSchema,
        AISessionCollectionSchema,
        AIUsageCollectionSchema,
        AIAutomationCollectionSchema,
        RestaurantFloorCollectionSchema,
        RestaurantTableCollectionSchema,
        KotCollectionSchema,
        FnbReservationCollectionSchema,
        ProductEntitySchema,
        SyncActionSchema,
        SyncConflictSchema,
        SyncAuditLogSchema,
      ],
      directory: dir.path,
      inspector: true,
    );
  }

  /// Global Transaction Wrapper
  Future<T> runTransaction<T>(Future<T> Function() callback) async {
    return await isar.writeTxn(callback);
  }

  /// Global Backup Framework
  Future<void> createBackup(String path) async {
    await isar.copyToFile(path);
  }
}
