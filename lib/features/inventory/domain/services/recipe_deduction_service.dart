import 'package:isar/isar.dart';
import '../../../../core/database/collections/inventory_collections.dart';
import '../models/stock_transaction.dart';
import '../repositories/i_inventory_repository.dart';

class RecipeDeductionService {
  final IInventoryRepository _inventoryRepository;
  final Isar _isar;

  RecipeDeductionService(this._inventoryRepository, this._isar);

  Future<void> deductIngredientsForSale(String productId, double quantitySold) async {
    final all = await _isar.collection<ProductCollection>().where().findAll();
    final product = all.firstWhere((p) => p.uuid == productId);
    
    if (product.recipeBOM == null || product.recipeBOM!.isEmpty) return;

    final List<StockTransaction> transactions = [];
    for (var ingredient in product.recipeBOM!) {
      final totalDeduction = (ingredient.quantity ?? 0) * quantitySold;
      
      transactions.add(StockTransaction(
        id: 'BOM-${DateTime.now().millisecondsSinceEpoch}-${ingredient.uuid}',
        stockItemId: ingredient.ingredientName ?? '', 
        quantityDelta: -totalDeduction,
        type: TransactionType.outSale,
        timestamp: DateTime.now(),
        userId: 'system',
        notes: 'Deducted via Recipe for $productId x $quantitySold',
      ));
    }
    
    await _inventoryRepository.recordTransactions(transactions);
  }
}
