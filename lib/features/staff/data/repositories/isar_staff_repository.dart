import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/staff_collections.dart';
import '../../domain/repositories/i_staff_repository.dart';
import '../../domain/models/employee.dart';
import '../../domain/models/department.dart';
import '../../domain/models/attendance.dart';
import '../../domain/models/leave.dart';
import '../../domain/models/payroll_record.dart';
import 'package:isar/isar.dart';
import 'dart:convert';

class IsarStaffRepository implements IStaffRepository {
  final DatabaseService db;
  IsarStaffRepository(this.db);

  IsarCollection<EmployeeCollection> get empCol =>
      db.isar.collection<EmployeeCollection>();
  IsarCollection<AttendanceCollection> get attCol =>
      db.isar.collection<AttendanceCollection>();
  IsarCollection<DepartmentCollection> get deptCol =>
      db.isar.collection<DepartmentCollection>();
  IsarCollection<LeaveCollection> get leaveCol =>
      db.isar.collection<LeaveCollection>();
  IsarCollection<PayrollCollection> get payCol =>
      db.isar.collection<PayrollCollection>();

  @override
  Future<List<Employee>> getEmployees() async {
    final results = await empCol.where().findAll();
    return results.map((e) => _mapToDomain(e)).toList();
  }

  @override
  Future<void> saveEmployee(Employee employee) async {
    final existing = await empCol.filter().uuidEqualTo(employee.id).findFirst();

    final e = (existing ?? EmployeeCollection())
      ..uuid = employee.id
      ..employeeCode = employee.employeeCode
      ..firstName = employee.firstName
      ..lastName = employee.lastName
      ..companyId = employee.companyId
      ..branchId = employee.branchId
      ..departmentId = employee.departmentId
      ..designationId = employee.designationId
      ..managerId = employee.managerId
      ..userId = employee.userId
      ..photoUrl = employee.photoUrl
      ..dateOfBirth = employee.dateOfBirth
      ..gender = employee.gender.name
      ..maritalStatus = employee.maritalStatus.name
      ..bloodGroup = employee.bloodGroup
      ..email = employee.email
      ..phone = employee.phone
      ..whatsapp = employee.whatsapp
      ..emergencyContactName = employee.emergencyContactName
      ..emergencyContactPhone = employee.emergencyContactPhone
      ..addressLine1 = employee.addressLine1
      ..addressLine2 = employee.addressLine2
      ..city = employee.city
      ..state = employee.state
      ..zipCode = employee.zipCode
      ..country = employee.country
      ..dateOfJoining = employee.dateOfJoining
      ..employmentType = employee.employmentType
      ..workLocation = employee.workLocation
      ..shiftId = employee.shiftId
      ..salaryStructureId = employee.salaryStructureId
      ..bankAccountId = employee.bankAccountId
      ..status = employee.status.name
      ..skills = employee.skills
      ..aiInsightsJson = jsonEncode(employee.aiInsights)
      ..updatedAt = DateTime.now();

    await db.isar.writeTxn(() async {
      await empCol.put(e);
    });
  }

  @override
  Future<List<Department>> getDepartments() async {
    final results = await deptCol.where().findAll();
    return results
        .map((e) => Department(
              id: e.uuid,
              name: e.name,
            ))
        .toList();
  }

  @override
  Future<List<Attendance>> getAttendance(
      String employeeId, DateTime start, DateTime end) async {
    final results = await attCol
        .filter()
        .employeeIdEqualTo(employeeId)
        .and()
        .clockInBetween(start, end)
        .findAll();

    return results
        .map((e) => Attendance(
              id: e.id.toString(),
              employeeId: e.employeeId,
              clockIn: e.clockIn,
              clockOut: e.clockOut,
              source: AttendanceSource.values.firstWhere(
                  (s) => s.name == e.source,
                  orElse: () => AttendanceSource.web),
              latitude: e.latitude,
              longitude: e.longitude,
            ))
        .toList();
  }

  @override
  Future<void> recordClockIn(String employeeId, AttendanceSource source,
      {double? lat, double? lng}) async {
    final a = AttendanceCollection()
      ..employeeId = employeeId
      ..clockIn = DateTime.now()
      ..source = source.name
      ..latitude = lat
      ..longitude = lng
      ..isLate = false // Logic to be handled by engine
      ..isEarlyDeparture = false
      ..overtimeHours = 0.0;

    await db.isar.writeTxn(() async {
      await attCol.put(a);
    });
  }

  @override
  Future<void> recordClockOut(String employeeId) async {
    final active = await attCol
        .filter()
        .employeeIdEqualTo(employeeId)
        .and()
        .clockOutIsNull()
        .sortByClockInDesc()
        .findFirst();

    if (active != null) {
      active.clockOut = DateTime.now();
      await db.isar.writeTxn(() async {
        await attCol.put(active);
      });
    }
  }

  @override
  Future<List<LeaveRequest>> getLeaveRequests() async {
    final results = await leaveCol.where().findAll();
    return results
        .map((e) => LeaveRequest(
              id: e.uuid,
              employeeId: e.employeeId,
              type: e.type,
              startDate: e.startDate,
              endDate: e.endDate,
              reason: e.reason,
              status: LeaveStatus.values.firstWhere((s) => s.name == e.status,
                  orElse: () => LeaveStatus.pending),
              approvedById: e.approvedById,
            ))
        .toList();
  }

  @override
  Future<void> submitLeave(LeaveRequest request) async {
    final l = LeaveCollection()
      ..uuid = request.id
      ..employeeId = request.employeeId
      ..type = request.type
      ..startDate = request.startDate
      ..endDate = request.endDate
      ..status = request.status.name
      ..reason = request.reason
      ..approvedById = request.approvedById;

    await db.isar.writeTxn(() async {
      await leaveCol.put(l);
    });
  }

  @override
  Future<List<PayrollRecord>> getPayrollHistory(String employeeId) async {
    final results =
        await payCol.filter().employeeIdEqualTo(employeeId).findAll();
    return results
        .map((e) => PayrollRecord(
              id: e.uuid,
              employeeId: e.employeeId,
              month: e.month,
              grossAmount: e.basicSalary + e.hra + e.allowances + e.bonuses + e.overtimePay,
              netAmount: e.netAmount,
              taxes: e.statutoryTaxes,
              isPaid: e.isPaid,
              paymentDate: e.paymentDate,
            ))
        .toList();
  }

  @override
  Future<void> savePayrollRecord(PayrollRecord record) async {
    final p = PayrollCollection()
      ..uuid = record.id
      ..employeeId = record.employeeId
      ..month = record.month
      ..basicSalary = record.grossAmount * 0.5 // Mock split
      ..hra = record.grossAmount * 0.2
      ..allowances = record.grossAmount * 0.3
      ..bonuses = 0.0
      ..overtimePay = 0.0
      ..deductions = record.grossAmount - record.netAmount - record.taxes
      ..statutoryTaxes = record.taxes
      ..netAmount = record.netAmount
      ..isPaid = record.isPaid
      ..paymentDate = record.paymentDate;

    await db.isar.writeTxn(() async {
      await payCol.put(p);
    });
  }

  Employee _mapToDomain(EmployeeCollection e) {
    return Employee(
      id: e.uuid,
      employeeCode: e.employeeCode,
      firstName: e.firstName,
      lastName: e.lastName,
      companyId: e.companyId,
      branchId: e.branchId,
      departmentId: e.departmentId,
      designationId: e.designationId,
      managerId: e.managerId,
      userId: e.userId,
      photoUrl: e.photoUrl,
      dateOfBirth: e.dateOfBirth,
      gender: Gender.values.firstWhere((g) => g.name == e.gender,
          orElse: () => Gender.undisclosed),
      maritalStatus: MaritalStatus.values.firstWhere(
          (m) => m.name == e.maritalStatus,
          orElse: () => MaritalStatus.single),
      bloodGroup: e.bloodGroup,
      email: e.email,
      phone: e.phone,
      whatsapp: e.whatsapp,
      emergencyContactName: e.emergencyContactName,
      emergencyContactPhone: e.emergencyContactPhone,
      addressLine1: e.addressLine1,
      addressLine2: e.addressLine2,
      city: e.city,
      state: e.state,
      zipCode: e.zipCode,
      country: e.country,
      dateOfJoining: e.dateOfJoining,
      employmentType: e.employmentType,
      workLocation: e.workLocation,
      shiftId: e.shiftId,
      salaryStructureId: e.salaryStructureId,
      bankAccountId: e.bankAccountId,
      status: EmployeeStatus.values.firstWhere((s) => s.name == e.status,
          orElse: () => EmployeeStatus.active),
      skills: e.skills,
      aiInsights: e.aiInsightsJson != null ? jsonDecode(e.aiInsightsJson!) : {},
      createdAt: e.createdAt,
      updatedAt: e.updatedAt,
    );
  }
}
