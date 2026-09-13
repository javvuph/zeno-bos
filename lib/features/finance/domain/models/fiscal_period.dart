enum FiscalPeriodStatus { open, softClosed, hardClosed, locked }

class FiscalPeriod {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final FiscalPeriodStatus status;
  final bool isAdjustmentPeriod;

  const FiscalPeriod({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.status = FiscalPeriodStatus.open,
    this.isAdjustmentPeriod = false,
  });

  bool get isLocked =>
      status == FiscalPeriodStatus.locked ||
      status == FiscalPeriodStatus.hardClosed;
}
