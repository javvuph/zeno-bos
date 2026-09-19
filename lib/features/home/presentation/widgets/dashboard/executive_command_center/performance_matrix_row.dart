import 'package:flutter/material.dart';
import 'package:zeno/core/database/database_service.dart';
import 'package:zeno/core/database/collections/transaction_collections.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:isar/isar.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';
import 'package:zeno/core/widgets/zeno_table.dart';

part 'parts/performance_matrix_tiles.part.dart';

class PerformanceMatrixRow extends StatelessWidget {
  const PerformanceMatrixRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 360,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _BusinessHealthMatrix(),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _ProductLeaderboard(),
          ),
        ],
      ),
    );
  }
}

class _BusinessHealthMatrix extends StatelessWidget {
  const _BusinessHealthMatrix();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final scores = BIMockData.getBusinessHealthScores();
    if (scores.isEmpty) return const SizedBox.shrink();
    final entries = scores.entries.toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DEPARTMENT HEALTH MATRIX",
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 88,
              ),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                if (index >= entries.length) return const SizedBox.shrink();
                final key = entries[index].key;
                final value = entries[index].value;
                return _HealthTile(label: key, score: value, colors: colors);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductLeaderboard extends StatefulWidget {
  const _ProductLeaderboard();

  @override
  State<_ProductLeaderboard> createState() => _ProductLeaderboardState();
}

class _ProductLeaderboardState extends State<_ProductLeaderboard> {
  List<Map<String, dynamic>> topProducts = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final orders = await sl<DatabaseService>().isar
        .collection<SalesOrderCollection>()
        .filter()
        .statusEqualTo('completed')
        .findAll();

    final totals = <String, double>{};
    final names = <String, String>{};
    for (final order in orders) {
      for (final item in order.items ?? const <TransactionItem>[]) {
        final key = item.productId;
        totals[key] = (totals[key] ?? 0) + item.subtotal;
        names[key] = item.description;
      }
    }

    final rows = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final result = rows.take(8).map((e) => {
      'sku': e.key,
      'name': names[e.key] ?? e.key,
      'revenue': e.value,
    }).toList();

    if (mounted) setState(() => topProducts = result);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier4,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TOP PRODUCT LEADERBOARD",
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: topProducts.isEmpty
                ? Center(
                    child: Text(
                      "No product data available",
                      style: TextStyle(fontSize: 11, color: colors.textDisabled),
                    ),
                  )
                : ZenoTable<Map<String, dynamic>>(
                    items: topProducts,
                    columns: [
                      ZenoTableColumn(
                        label: "SKU",
                        width: 80,
                        builder: (p) => Text(p['sku'],
                            style:
                                TextStyle(fontSize: 11, color: colors.textSecondary)),
                      ),
                      ZenoTableColumn(
                        label: "PRODUCT NAME",
                        builder: (p) => Text(p['name'],
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
