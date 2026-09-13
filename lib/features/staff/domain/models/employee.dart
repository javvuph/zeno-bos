enum EmployeeStatus {
  active,
  probation,
  onLeave,
  suspended,
  resigned,
  terminated,
  retired
}

enum Gender { male, female, other, undisclosed }

enum MaritalStatus { single, married, divorced, widowed }

class Employee {
  final String id;
  final String employeeCode;
  final String companyId;
  final String branchId;
  final String departmentId;
  final String designationId;
  final String? managerId;
  final String? userId; // Linked to system User Account
  final String? photoUrl;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final Gender gender;
  final MaritalStatus maritalStatus;
  final String? bloodGroup;
  final String email;
  final String phone;
  final String? whatsapp;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final DateTime dateOfJoining;
  final String employmentType; // Full-time, Part-time, Contract, etc.
  final String? workLocation;
  final String? shiftId;
  final String? salaryStructureId;
  final String? bankAccountId;
  final EmployeeStatus status;
  final List<String> skills;
  final Map<String, dynamic> aiInsights; // For Sentiment and Retention
  final DateTime createdAt;
  final DateTime updatedAt;

  const Employee({
    required this.id,
    required this.employeeCode,
    required this.companyId,
    required this.branchId,
    required this.departmentId,
    required this.designationId,
    this.managerId,
    this.userId,
    this.photoUrl,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.gender = Gender.undisclosed,
    this.maritalStatus = MaritalStatus.single,
    this.bloodGroup,
    required this.email,
    required this.phone,
    this.whatsapp,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    required this.dateOfJoining,
    this.employmentType = 'Full-time',
    this.workLocation,
    this.shiftId,
    this.salaryStructureId,
    this.bankAccountId,
    this.status = EmployeeStatus.active,
    this.skills = const [],
    this.aiInsights = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  String get name => '$firstName $lastName';

  Employee copyWith({
    String? firstName,
    String? lastName,
    String? departmentId,
    String? designationId,
    String? managerId,
    EmployeeStatus? status,
    String? photoUrl,
    List<String>? skills,
    Map<String, dynamic>? aiInsights,
    DateTime? updatedAt,
  }) {
    return Employee(
      id: id,
      employeeCode: employeeCode,
      companyId: companyId,
      branchId: branchId,
      departmentId: departmentId ?? this.departmentId,
      designationId: designationId ?? this.designationId,
      managerId: managerId ?? this.managerId,
      userId: userId,
      photoUrl: photoUrl ?? this.photoUrl,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      maritalStatus: maritalStatus,
      bloodGroup: bloodGroup,
      email: email,
      phone: phone,
      whatsapp: whatsapp,
      emergencyContactName: emergencyContactName,
      emergencyContactPhone: emergencyContactPhone,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      city: city,
      state: state,
      zipCode: zipCode,
      country: country,
      dateOfJoining: dateOfJoining,
      employmentType: employmentType,
      workLocation: workLocation,
      shiftId: shiftId,
      salaryStructureId: salaryStructureId,
      bankAccountId: bankAccountId,
      status: status ?? this.status,
      skills: skills ?? this.skills,
      aiInsights: aiInsights ?? this.aiInsights,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
