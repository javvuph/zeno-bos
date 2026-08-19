import '../models/employee.dart';
import '../models/department.dart';
import '../models/attendance.dart';
import '../models/leave.dart';
import '../models/payroll_record.dart';
import '../models/salary_structure.dart';

class StaffMasterDataService {
  List<Employee> getMockEmployees() => [
        Employee(
          id: 'EMP-001',
          employeeCode: 'ZEN-1001',
          companyId: 'ZEN-CORP',
          branchId: 'B-NORTH',
          departmentId: 'DEPT-ENG',
          designationId: 'DES-SSE',
          firstName: 'Rahul',
          lastName: 'Sharma',
          email: 'rahul.s@zeno.com',
          phone: '+91 98765 43210',
          dateOfJoining: DateTime(2023, 1, 15),
          status: EmployeeStatus.active,
          createdAt: DateTime(2023, 1, 15),
          updatedAt: DateTime.now(),
        ),
        Employee(
          id: 'EMP-002',
          employeeCode: 'ZEN-1002',
          companyId: 'ZEN-CORP',
          branchId: 'B-NORTH',
          departmentId: 'DEPT-HR',
          designationId: 'DES-HRM',
          firstName: 'Priya',
          lastName: 'Verma',
          email: 'priya.v@zeno.com',
          phone: '+91 99999 88888',
          dateOfJoining: DateTime(2023, 6, 1),
          status: EmployeeStatus.active,
          createdAt: DateTime(2023, 6, 1),
          updatedAt: DateTime.now(),
        ),
      ];

  List<Department> getDepartments() => [
        const Department(id: 'DEPT-ENG', name: 'Engineering'),
        const Department(id: 'DEPT-HR', name: 'Human Resources'),
        const Department(id: 'DEPT-SALES', name: 'Sales & Marketing'),
      ];

  List<SalaryStructure> getSalaryStructures() => [
        const SalaryStructure(
          employeeId: 'EMP-001',
          basic: 45000,
          hra: 18000,
          allowances: 12000,
          deductions: 5000,
          currency: 'INR',
        ),
      ];

  List<LeaveRequest> getMockLeaveRequests() => [
        LeaveRequest(
          id: 'LV-101',
          employeeId: 'EMP-001',
          type: 'Annual Leave',
          startDate: DateTime.now().add(const Duration(days: 5)),
          endDate: DateTime.now().add(const Duration(days: 7)),
          reason: 'Family wedding',
          status: LeaveStatus.pending,
        ),
      ];

  List<Attendance> getMockAttendance() => [
        Attendance(
          id: 'ATT-001',
          employeeId: 'EMP-001',
          clockIn: DateTime.now().subtract(const Duration(hours: 8)),
          clockOut: DateTime.now().subtract(const Duration(minutes: 15)),
          source: AttendanceSource.web,
        ),
      ];

  List<PayrollRecord> getMockPayroll() => [
        PayrollRecord(
          id: 'PAY-1001',
          employeeId: 'EMP-001',
          month: '2026-07',
          grossAmount: 75000,
          netAmount: 68000,
          taxes: 7000,
          isPaid: true,
          paymentDate: DateTime(2026, 8, 1),
        ),
      ];
}
