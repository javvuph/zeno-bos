enum ReplicationDirection { hqToBranch, branchToHq, bidirectional }

class ReplicationRule {
  final String collectionName;
  final ReplicationDirection direction;
  final bool isSelective; // True if filtering by branchId is required

  const ReplicationRule({
    required this.collectionName,
    required this.direction,
    this.isSelective = true,
  });
}

class ReplicationRegistry {
  static const List<ReplicationRule> rules = [
    // Global Master Data (HQ -> All Branches)
    ReplicationRule(
        collectionName: 'ProductCollection',
        direction: ReplicationDirection.hqToBranch,
        isSelective: false),
    ReplicationRule(
        collectionName: 'CategoryCollection',
        direction: ReplicationDirection.hqToBranch,
        isSelective: false),
    ReplicationRule(
        collectionName: 'RoleCollection',
        direction: ReplicationDirection.hqToBranch,
        isSelective: false),

    // Transactional Data (Branch -> HQ)
    ReplicationRule(
        collectionName: 'InvoiceCollection',
        direction: ReplicationDirection.branchToHq),
    ReplicationRule(
        collectionName: 'SalesOrderCollection',
        direction: ReplicationDirection.branchToHq),
    ReplicationRule(
        collectionName: 'AttendanceCollection',
        direction: ReplicationDirection.branchToHq),

    // Inventory (Bidirectional - Local levels up, HQ transfers down)
    ReplicationRule(
        collectionName: 'StockItemCollection',
        direction: ReplicationDirection.bidirectional),
  ];
}
