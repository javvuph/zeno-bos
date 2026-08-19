import '../models/employee.dart';
import '../models/department.dart';
import '../models/attendance.dart';
import '../models/leave.dart';
import '../models/payroll_record.dart';

abstract class IStaffRepository {
  Future<List<Employee>> getEmployees();
  Future<void> saveEmployee(Employee employee);
  Future<List<Department>> getDepartments();

  // Attendance
  Future<List<Attendance>> getAttendance(
      String employeeId, DateTime start, DateTime end);
  Future<void> recordClockIn(String employeeId, AttendanceSource source,
      {double? lat, double? lng});
  Future<void> recordClockOut(String employeeId);

  // Leave
  Future<List<LeaveRequest>> getLeaveRequests();
  Future<void> submitLeave(LeaveRequest request);

  // Payroll
  Future<List<PayrollRecord>> getPayrollHistory(String employeeId);
  Future<void> savePayrollRecord(PayrollRecord record);

  // Recruitment
  // Future<List<RecruitmentOpening>> getOpenings();
  // Future<void> saveOpening(RecruitmentOpening opening);
  // Future<List<RecruitmentCandidate>> getCandidates(String openingId);
  // Future<void> saveCandidate(RecruitmentCandidate candidate);

  // Performance
  // Future<List<PerformanceReview>> getReviews(String employeeId);
  // Future<void> saveReview(PerformanceReview review);

  // Training
  // Future<List<TrainingProgram>> getTrainingPrograms();
  // Future<void> saveTrainingProgram(TrainingProgram program);

  // Documents
  // Future<List<EmployeeDocument>> getDocuments(String employeeId);
  // Future<void> saveDocument(EmployeeDocument document);
}
