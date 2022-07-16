import 'package:flutter/cupertino.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';

abstract class FruitDetailEvent {}

class PressedIncrementItemEvent extends FruitDetailEvent {}

class PressedDecrementItemEvent extends FruitDetailEvent {}

class ToggleFruitItemFavoriteEvent extends FruitDetailEvent {
  final bool currentFavoriteState;

  ToggleFruitItemFavoriteEvent({required this.currentFavoriteState});
}

class PressedAddToBasketEvent extends FruitDetailEvent {
  final BuildContext context;
  final ItemAddedBasketModel itemAddedBasketModel;

  PressedAddToBasketEvent({required this.itemAddedBasketModel, required this.context});
}
