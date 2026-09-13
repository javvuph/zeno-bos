import 'package:isar/isar.dart';

part 'staff_collections.g.dart';

@collection
class EmployeeCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(unique: true)
  late String employeeCode;

  @Index(caseSensitive: false)
  late String firstName;

  @Index(caseSensitive: false)
  late String lastName;

  @Index()
  late String companyId;

  @Index()
  late String branchId;

  @Index()
  late String departmentId;

  @Index()
  late String designationId;

  String? managerId;
  String? userId;
  String? photoUrl;
  DateTime? dateOfBirth;
  late String gender;
  late String maritalStatus;
  String? bloodGroup;

  late String email;
  late String phone;
  String? whatsapp;
  String? emergencyContactName;
  String? emergencyContactPhone;

  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? zipCode;
  String? country;

  late DateTime dateOfJoining;
  late String employmentType;
  String? workLocation;
  String? shiftId;
  String? salaryStructureId;
  String? bankAccountId;

  @Index()
  late String status; // active, probation, onLeave, terminated

  List<String> skills = [];
  String? aiInsightsJson;

  bool isDeleted = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  String get name => '$firstName $lastName';
}

@collection
class AttendanceCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String employeeId;

  @Index()
  late DateTime clockIn;

  DateTime? clockOut;

  late String source; // manual, biometric, geofence, web
  double? latitude;
  double? longitude;
  String? shiftId;
  late bool isLate;
  late bool isEarlyDeparture;
  late double overtimeHours;
}

@collection
class PayrollCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String employeeId;

  @Index()
  late String month; // YYYY-MM

  late double basicSalary;
  late double hra;
  late double allowances;
  late double bonuses;
  late double overtimePay;
  late double deductions;
  late double statutoryTaxes;
  late double netAmount;

  @Index()
  bool isPaid = false;
  DateTime? paymentDate;
  String? bankReference;
  String? glTransactionId;
}

@collection
class LeaveCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String employeeId;

  late String type; // annual, sick, etc.
  late DateTime startDate;
  late DateTime endDate;

  @Index()
  late String status; // pending, approved, rejected

  String? approvedById;
  late String reason;
}

@collection
class DepartmentCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;

  late String companyId;
}

@collection
class DesignationCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index(caseSensitive: false)
  late String name;
}

@collection
class ShiftCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String name;
  late int startHour;
  late int startMinute;
  late int endHour;
  late int endMinute;
  late int graceMinutes;
}

@collection
class RecruitmentOpeningCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String jobTitle;
  late String departmentId;
  late String description;
  late String status; // open, closed, onHold
  late DateTime postedDate;
  DateTime? closingDate;
}

@collection
class RecruitmentCandidateCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String openingId;
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String status; // applied, screening, interview, hired, rejected
  late double score;
  String? resumeUrl;
}

@collection
class PerformanceReviewCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String employeeId;

  late DateTime reviewDate;
  late String reviewerId;
  late double rating; // 1-5
  late String feedback;
  late String nextSteps;
}

@collection
class TrainingProgramCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  late String title;
  late String description;
  late DateTime startDate;
  late DateTime endDate;
  List<String> assignedEmployeeIds = [];
}

@collection
class EmployeeDocumentCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid;

  @Index()
  late String employeeId;

  late String fileName;
  late String documentType; // passport, contract, certificate
  late String fileUrl;
  DateTime? expiryDate;
  late String status; // valid, expired, pending
}
