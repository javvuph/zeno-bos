class SalesTerritory {
  final String id;
  final String code;
  final String name;
  final String region;
  final String? parentId;

  const SalesTerritory({
    required this.id,
    required this.code,
    required this.name,
    required this.region,
    this.parentId,
  });
}
