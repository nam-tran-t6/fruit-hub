part of 'my_basket_cubit.dart';

@immutable
abstract class MyBasketState {
  final int _totalItem;

  MyBasketState(this._totalItem);

  int get getTotalItem => this._totalItem;
}

class MyBasketInitial extends MyBasketState {
  MyBasketInitial(int totalItem) : super(totalItem);
}

class MyBasketLoadFromDb extends MyBasketState {
  MyBasketLoadFromDb(int totalItem) : super(totalItem);
}

class MyBasketItemQuantity extends MyBasketState {
  MyBasketItemQuantity(int totalItem) : super(totalItem);
}

class MyBasketIsClicked extends MyBasketState {
  MyBasketIsClicked(int totalItem) : super(totalItem);
}

class MyBasketListAddedItem extends MyBasketState {
  final List<ItemAddedBasketModel> list;

  MyBasketListAddedItem(this.list) : super(0);
}
