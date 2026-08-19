import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/core/database/entities/product_entity.dart';
import 'package:zeno/core/industry/industry_registry.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_event.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_state.dart';
import 'package:zeno/features/inventory/data/services/ai_product_service.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final AIProductService _aiService;

  InventoryBloc(this._aiService)
      : super(InventoryState(currentIndustry: IndustryRegistry.all.first)) {
    on<ChangeIndustry>(_onChangeIndustry);
    on<AddProduct>(_onAddProduct);
    on<GenerateAIDescription>(_onGenerateAIDescription);
  }

  void _onChangeIndustry(ChangeIndustry event, Emitter<InventoryState> emit) {
    emit(state.copyWith(
        currentIndustry: event.industry, aiGeneratedDescription: null));
  }

  void _onAddProduct(AddProduct event, Emitter<InventoryState> emit) {
    final updatedProducts = List<ProductEntity>.from(state.products)
      ..add(event.product);
    emit(state.copyWith(products: updatedProducts));
  }

  Future<void> _onGenerateAIDescription(
      GenerateAIDescription event, Emitter<InventoryState> emit) async {
    emit(state.copyWith(status: InventoryStatus.loading));
    try {
      final description = await _aiService.generateDescription(
        productName: event.productName,
        industry: state.currentIndustry,
        attributes: event.attributes,
      );
      emit(state.copyWith(
          status: InventoryStatus.success,
          aiGeneratedDescription: description));
    } catch (_) {
      emit(state.copyWith(status: InventoryStatus.failure));
    }
  }
}
