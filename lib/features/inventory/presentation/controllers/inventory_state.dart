import 'package:equatable/equatable.dart';
import 'package:zeno/core/database/entities/product_entity.dart';
import 'package:zeno/core/industry/industry_registry.dart';

enum InventoryStatus { initial, loading, success, failure }

class InventoryState extends Equatable {
  final InventoryStatus status;
  final IndustrySchema currentIndustry;
  final List<ProductEntity> products;
  final String? aiGeneratedDescription;

  const InventoryState({
    this.status = InventoryStatus.initial,
    required this.currentIndustry,
    this.products = const [],
    this.aiGeneratedDescription,
  });

  InventoryState copyWith({
    InventoryStatus? status,
    IndustrySchema? currentIndustry,
    List<ProductEntity>? products,
    String? aiGeneratedDescription,
  }) {
    return InventoryState(
      status: status ?? this.status,
      currentIndustry: currentIndustry ?? this.currentIndustry,
      products: products ?? this.products,
      aiGeneratedDescription:
          aiGeneratedDescription ?? this.aiGeneratedDescription,
    );
  }

  @override
  List<Object?> get props =>
      [status, currentIndustry, products, aiGeneratedDescription];
}
