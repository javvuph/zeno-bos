class WarehouseStock {
  final String warehouse;
  int onHand;
  int available;
  int reserved;

  WarehouseStock({
    required this.warehouse,
    required this.onHand,
    required this.available,
    required this.reserved,
  });
}
