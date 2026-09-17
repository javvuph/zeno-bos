import 'package:flutter/material.dart';
import '../../domain/models/employee.dart';
import '../../domain/models/attendance.dart';
import '../../domain/models/leave.dart';
import '../../domain/models/payroll_record.dart';
import '../../domain/repositories/i_staff_repository.dart';
import '../../domain/services/staff_master_data_service.dart';

class StaffController extends ChangeNotifier {
  final IStaffRepository _repository;
  final StaffMasterDataService _masterData = StaffMasterDataService();

  StaffController(this._repository) {
    loadStaffData();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Employee> _employees = [];
  List<Employee> get employees => _employees.isEmpty ? _masterData.getMockEmployees() : _employees;

  List<LeaveRequest> _leaveRequests = [];
  List<LeaveRequest> get leaveRequests => _leaveRequests.isEmpty ? _masterData.getMockLeaveRequests() : _leaveRequests;

  List<Attendance> _dailyAttendance = [];
  List<Attendance> get dailyAttendance => _dailyAttendance.isEmpty ? _masterData.getMockAttendance() : _dailyAttendance;

  final List<PayrollRecord> _payrollHistory = [];
  List<PayrollRecord> get payrollHistory => _payrollHistory.isEmpty ? _masterData.getMockPayroll() : _payrollHistory;

  Future<void> loadStaffData() async {
    _isLoading = true;
    notifyListeners();
    try {
      _employees = await _repository.getEmployees();
      _leaveRequests = await _repository.getLeaveRequests();
      if (_employees.isNotEmpty) {
        _dailyAttendance = await _repository.getAttendance(
          _employees.first.id, 
          DateTime.now().subtract(const Duration(days: 1)), 
          DateTime.now()
        );
      }
    } catch (e) {
      debugPrint("Error loading staff data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveEmployee(Employee employee) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.saveEmployee(employee);
      await loadStaffData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Attendance Methods
  int get currentlyClockedIn => 42; // Logic to check current status
  List<Attendance> get recentAttendance => dailyAttendance;

  Future<void> recordClockIn(String employeeId, AttendanceSource source) async {
    await _repository.recordClockIn(employeeId, source);
    await loadStaffData();
  }

  Future<void> recordClockOut(String employeeId) async {
    await _repository.recordClockOut(employeeId);
    await loadStaffData();
  }

  // Payroll Methods
  Future<void> runPayroll(String month) async {
    // Logic to calculate and save payroll for current month
  }

  // Master Data
  List<dynamic> get departments => _masterData.getDepartments();

  // Dashboard Stats
  int get activeStaffCount => employees.where((e) => e.status == EmployeeStatus.active).length;
  int get presentTodayCount => dailyAttendance.length; 
  int get pendingLeaveCount => leaveRequests.where((l) => l.status == LeaveStatus.pending).length;
  double get monthlyPayrollAmount => 0.0; 
}
