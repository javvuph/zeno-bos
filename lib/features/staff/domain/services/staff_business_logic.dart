import '../models/employee.dart';
import '../models/attendance.dart';
import '../models/salary_structure.dart';
import '../models/payroll_record.dart';
import '../models/shift.dart';
import 'package:flutter/material.dart';

class StaffBusinessLogic {
  /// Calculates attendance duration in hours
  double calculateAttendanceHours(Attendance attendance) {
    if (attendance.clockOut == null) return 0.0;
    return attendance.clockOut!.difference(attendance.clockIn).inMinutes / 60.0;
  }

  /// Determines if an attendance log is considered "Late" based on shift grace minutes
  bool isLate(Attendance attendance, Shift shift) {
    final clockInTime = TimeOfDay.fromDateTime(attendance.clockIn);
    final shiftStartInMinutes =
        shift.startTime.hour * 60 + shift.startTime.minute;
    final clockInInMinutes = clockInTime.hour * 60 + clockInTime.minute;

    return clockInInMinutes > (shiftStartInMinutes + shift.graceMinutes);
  }

  /// Calculates Payroll for a month based on attendance and salary structure
  PayrollRecord generateMonthlyPayroll({
    required Employee employee,
    required SalaryStructure structure,
    required List<Attendance> attendanceLogs,
    required String month,
    double taxRate = 0.1,
  }) {
    double totalHours = 0;
    for (var log in attendanceLogs) {
      totalHours += calculateAttendanceHours(log);
    }

    // Basic logic: if total hours < 160, prorate (simplified for example)
    double gross = structure.monthlyGross;
    if (totalHours < 160 && totalHours > 0) {
      gross = (structure.monthlyGross / 160) * totalHours;
    }

    double taxes = gross * taxRate;
    double net = gross - taxes - structure.deductions;

    return PayrollRecord(
      id: 'PAY-${employee.id}-$month',
      employeeId: employee.id,
      month: month,
      grossAmount: gross,
      netAmount: net,
      taxes: taxes,
    );
  }

  /// Calculates employee readiness score (0.0 to 1.0)
  double calculateEmployeeReadiness(Employee employee) {
    int points = 0;
    int total = 100;

    if (employee.email.isNotEmpty) points += 20;
    if (employee.phone.isNotEmpty) points += 20;
    if (employee.userId != null) points += 30;
    if (employee.departmentId.isNotEmpty) points += 30;

    return points / total;
  }

  /// Calculates HR KPIs: Headcount, Attendance Rate
  Map<String, dynamic> calculateHRKPIs(
      List<Employee> employees, List<Attendance> recentAttendance) {
    int activeCount =
        employees.where((e) => e.status == EmployeeStatus.active).length;
    int clockedInCount =
        recentAttendance.where((a) => a.clockOut == null).length;

    return {
      'total_personnel': employees.length,
      'active_count': activeCount,
      'clocked_in_today': clockedInCount,
      'attendance_rate':
          employees.isNotEmpty ? clockedInCount / employees.length : 0.0,
    };
  }

  /// Formats an audit trail entry for HR events
  String formatHRAudit(String employeeId, String action, String userId) {
    return "[HR] EMP-$employeeId | ACTION: $action | USER: $userId | TIMESTAMP: ${DateTime.now().toIso8601String()}";
  }
}
