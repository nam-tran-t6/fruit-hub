import 'package:equatable/equatable.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';

abstract class FruitItemState extends Equatable {
  final bool _isLoading;

  FruitItemState(this._isLoading);

  bool get getLoadingState => this._isLoading;
}

class FruitItemInitial extends FruitItemState {
  FruitItemInitial() : super(false);

  @override
  List<Object?> get props => [];
}

class FruitItemLoading extends FruitItemState {
  FruitItemLoading() : super(true);

  @override
  List<Object?> get props => [];
}

class FruitItemLoaded extends FruitItemState {
  final FruitItem fruitItemDetail;

  FruitItemLoaded({required this.fruitItemDetail}) : super(false);

  @override
  List<Object?> get props => [fruitItemDetail];
}

class FruitItemLoadError extends FruitItemState {
  final String errorMessage;

  FruitItemLoadError(this.errorMessage) : super(false);

  @override
  List<Object?> get props => [errorMessage];
}
