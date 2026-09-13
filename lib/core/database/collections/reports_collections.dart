import 'package:isar/isar.dart';

part 'reports_collections.g.dart';

@collection
class ReportDefinitionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  late String description;

  @Index()
  late String module; // sales, inventory, finance, etc.

  late String dataSource; // Collection name or specialized view

  late String reportType; // table, pivot, barChart, lineChart, etc.

  List<String> selectedFields = [];

  String? groupByField;

  String? sortByField;
  bool sortDescending = true;

  String? aggregationJson; // JSON string for Sum/Avg/Count logic

  String? filtersJson; // JSON string for custom filter conditions

  String? visualSettingsJson; // Colors, labels, etc.

  @Index()
  late String ownerId;

  List<String> sharedWithRoleIds = [];

  bool isPredefined = false;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}

@collection
class DashboardDefinitionCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String title;

  @Index()
  late String scope; // global, personal, department

  String? layoutJson; // Widget positions and sizes

  @Index()
  late String ownerId;

  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
}

@collection
class ReportScheduleCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String reportId;

  late String frequency; // daily, weekly, monthly

  late String deliveryChannel; // inApp, email, push

  List<String> recipientEmails = [];

  late DateTime nextRun;

  bool isActive = true;

  DateTime createdAt = DateTime.now();
}
