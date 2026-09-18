import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/inventory/domain/models/product.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_controller.dart';

class BillingProductBrowser extends StatefulWidget {
  const BillingProductBrowser({super.key});
  @override State<BillingProductBrowser> createState() => _BillingProductBrowserState();
}

class _BillingProductBrowserState extends State<BillingProductBrowser> {
  late final ProductController _products;
  final _search = TextEditingController();
  bool _grid = true;
  String _category = 'ALL';

  @override void initState() {
    super.initState();
    _products = sl<ProductController>()..addListener(_refresh);
    if (_products.allProducts.isEmpty) _products.refreshProducts();
  }
  @override void dispose() {
    _products.removeListener(_refresh); _search.dispose(); super.dispose();
  }
  void _refresh() { if (mounted) setState(() {}); }

  List<Product> get _visible {
    final q = _search.text.trim().toLowerCase();
    return _products.allProducts.where((p) {
      final cat = p.category?.name ?? 'Uncategorized';
      return (_category == 'ALL' || cat == _category) &&
          (q.isEmpty || p.name.toLowerCase().contains(q) ||
           p.sku.value.toLowerCase().contains(q) ||
           (p.barcode?.value.toLowerCase().contains(q) ?? false));
    }).toList();
  }
  List<String> get _categories {
    final values = _products.allProducts.map((p) => p.category?.name ?? 'Uncategorized').toSet().toList()..sort();
    return ['ALL', ...values];
  }
  void _add(Product p) {
    if (p.sku.value.isEmpty) return;
    context.read<BillingStudioController>().add(AddItemRequested(p.sku.value));
  }

  @override Widget build(BuildContext context) {
    final c = Theme.of(context).extension<ZenoSemanticColors>()!;
    final items = _visible;
    return Container(
      decoration: BoxDecoration(color: Colors.white.withValues(alpha: .78), border: Border.all(color: c.borderSubtle), borderRadius: BorderRadius.circular(10)),
      child: Column(children: [_header(c, items.length), _categories(c), Expanded(
        child: items.isEmpty ? Center(child: Text(_products.isLoading ? 'Loading inventory…' : 'No products found', style: TextStyle(color: c.textSecondary, fontSize: 11)))
        : (_grid ? _gridView(c, items) : _listView(c, items)),
      )]),
    );
  }

  Widget _header(ZenoSemanticColors c, int count) => Padding(
    padding: const EdgeInsets.fromLTRB(10, 9, 10, 7),
    child: Row(children: [
      Text('PRODUCTS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1, color: c.textPrimary)),
      const SizedBox(width: 7), Text('$' + 'count', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: c.accentPrimary)),
      const SizedBox(width: 12), Expanded(child: Container(height: 34, padding: const EdgeInsets.symmetric(horizontal: 9), decoration: BoxDecoration(color: c.bgTier1, borderRadius: BorderRadius.circular(7), border: Border.all(color: c.borderSubtle)), child: TextField(
        controller: _search, onChanged: (_) => setState(() {}), decoration: InputDecoration(icon: Icon(Icons.search_rounded, size: 15, color: c.textSecondary), hintText: 'Search product, SKU or barcode…', hintStyle: TextStyle(fontSize: 10, color: c.textSecondary), border: InputBorder.none, isDense: true), style: TextStyle(fontSize: 10, color: c.textPrimary),
      ))), const SizedBox(width: 8), _viewButton(Icons.view_list_rounded, !_grid, c), _viewButton(Icons.grid_view_rounded, _grid, c),
    ]),
  );

  Widget _viewButton(IconData icon, bool active, ZenoSemanticColors c) => InkWell(
    onTap: () => setState(() => _grid = icon == Icons.grid_view_rounded), borderRadius: BorderRadius.circular(6),
    child: Container(width: 30, height: 30, decoration: BoxDecoration(color: active ? c.accentPrimary.withValues(alpha: .10) : Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: active ? c.accentPrimary : c.borderSubtle)), child: Icon(icon, size: 15, color: active ? c.accentPrimary : c.textSecondary)),
  );

  Widget _categories(ZenoSemanticColors c) => SizedBox(height: 36, child: ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: 10), scrollDirection: Axis.horizontal, itemCount: _categories.length, separatorBuilder: (_, __) => const SizedBox(width: 5),
    itemBuilder: (_, i) { final v = _categories[i]; final active = v == _category; return InkWell(onTap: () => setState(() => _category = v), borderRadius: BorderRadius.circular(6), child: Container(padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7), decoration: BoxDecoration(color: active ? c.accentPrimary.withValues(alpha: .10) : Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: active ? c.accentPrimary : c.borderSubtle)), child: Text(v, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: active ? c.accentPrimary : c.textSecondary)))); },
  ));

  Widget _gridView(ZenoSemanticColors c, List<Product> items) => GridView.builder(
    padding: const EdgeInsets.all(10), gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 190, mainAxisExtent: 150, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: items.length,
    itemBuilder: (_, i) => _ProductCard(product: items[i], colors: c, onAdd: () => _add(items[i])),
  );
  Widget _listView(ZenoSemanticColors c, List<Product> items) => ListView.separated(
    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10), itemCount: items.length, separatorBuilder: (_, __) => Divider(height: 1, color: c.borderSubtle),
    itemBuilder: (_, i) => _ProductRow(product: items[i], colors: c, onAdd: () => _add(items[i])),
  );
}

class _ProductCard extends StatelessWidget {
  final Product product; final ZenoSemanticColors colors; final VoidCallback onAdd;
  const _ProductCard({required this.product, required this.colors, required this.onAdd});
  @override Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Container(width: double.infinity, decoration: BoxDecoration(color: colors.bgTier1, borderRadius: BorderRadius.circular(6)), child: Icon(Icons.image_outlined, color: colors.textDisabled, size: 26))), const SizedBox(height: 7),
      Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: colors.textPrimary)), const Spacer(),
      Row(children: [Expanded(child: Text('₹' + product.basePrice.toStringAsFixed(2), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.accentPrimary))), SizedBox(height: 25, child: OutlinedButton(onPressed: onAdd, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 9), side: BorderSide(color: colors.accentPrimary.withValues(alpha: .35)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('ADD', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))))]),
    ]),
  );
}

class _ProductRow extends StatelessWidget {
  final Product product; final ZenoSemanticColors colors; final VoidCallback onAdd;
  const _ProductRow({required this.product, required this.colors, required this.onAdd});
  @override Widget build(BuildContext context) => SizedBox(height: 48, child: Row(children: [
    Container(width: 34, height: 34, decoration: BoxDecoration(color: colors.bgTier1, borderRadius: BorderRadius.circular(6)), child: Icon(Icons.image_outlined, size: 17, color: colors.textDisabled)), const SizedBox(width: 9),
    Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: colors.textPrimary)), Text(product.sku.value + ' • Stock ' + product.stockLevel.round().toString(), style: TextStyle(fontSize: 8, color: colors.textSecondary))])),
    Text('₹' + product.basePrice.toStringAsFixed(2), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: colors.textPrimary)), const SizedBox(width: 8), SizedBox(height: 28, child: OutlinedButton(onPressed: onAdd, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10), side: BorderSide(color: colors.accentPrimary.withValues(alpha: .35)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), child: const Text('ADD', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900))))
  ]));
}