import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';

abstract class FruitListState {}

class FruitListInitial extends FruitListState {}

class FruitListLoading extends FruitListState {}

class FruitListLoaded extends FruitListState {
  final FruitList fruitListData;

  FruitListLoaded({required this.fruitListData});
}

class FruitListLoadError extends FruitListState {
  final String errorMessage;

  FruitListLoadError(this.errorMessage);
}
