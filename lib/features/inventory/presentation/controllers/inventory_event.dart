import 'package:equatable/equatable.dart';
import 'package:zeno/core/database/entities/product_entity.dart';
import 'package:zeno/core/industry/industry_registry.dart';

abstract class InventoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeIndustry extends InventoryEvent {
  final IndustrySchema industry;
  ChangeIndustry(this.industry);
  @override
  List<Object?> get props => [industry];
}

class AddProduct extends InventoryEvent {
  final ProductEntity product;
  AddProduct(this.product);
  @override
  List<Object?> get props => [product];
}

class GenerateAIDescription extends InventoryEvent {
  final String productName;
  final Map<String, String> attributes;
  GenerateAIDescription({required this.productName, required this.attributes});
}
