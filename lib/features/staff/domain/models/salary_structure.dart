class SalaryStructure {
  final String employeeId;
  final double basic;
  final double hra;
  final double allowances;
  final double deductions;
  final String currency;

  const SalaryStructure({
    required this.employeeId,
    required this.basic,
    this.hra = 0.0,
    this.allowances = 0.0,
    this.deductions = 0.0,
    this.currency = 'USD',
  });

  double get monthlyGross => basic + hra + allowances;
  double get monthlyNet => monthlyGross - deductions;
}
