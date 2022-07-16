import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/constants/app_constants.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/database/added_items_dao.dart';
import 'package:flutter_fruit_hub/src/database/database_helper.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_item_added_repository.dart';
import 'package:meta/meta.dart';

part 'my_basket_state.dart';

class MyBasketCubit extends Cubit<MyBasketState> {
  static final MyBasketCubit _singleton = MyBasketCubit._internal();
  List<ItemAddedBasketModel> itemList = [];

  late FruitItemAddedRepository fruitItemAddedRepository;

  factory MyBasketCubit() {
    return _singleton;
  }

  MyBasketCubit._internal() : super(MyBasketInitial(0));

  void addItemAddedFromDBToBasket() async {
    var db = await DatabaseHelper().db;
    fruitItemAddedRepository = FruitItemAddedRepository(AddedItemsDao(db));
    itemList = await fruitItemAddedRepository.getAllStorageAddedItems();
    emit(MyBasketLoadFromDb(_getTotalQuantityInBasket()));
  }

  AddToBasketResult addItemToBasket(ItemAddedBasketModel itemAdd) {
    if (itemAdd.quantity < ONE_ITEM) {
      return InvalidQuantity(
          itemAdd.fruitItem.availableQuantity ?? DEFAULT_AVAILABLE_QUANTITY_FRUIT);
    }

    AddToBasketResult result;
    var fruit = itemAdd.fruitItem;

    if (_getListComboIds().contains(fruit.comboId)) {
      if (_canAddToBasket(itemAdd)) {
        var item = itemList[_getIndexOfFruitItemByComboId(fruit.comboId)];
        item.quantity += itemAdd.quantity;
        fruitItemAddedRepository.updateQuantityAdded(item);
        result = AddSuccess();
      } else {
        result = OutOfAvailable(_getAvailableQuantityRemainOfItem(fruit));
      }
    } else {
      itemList.add(itemAdd);
      fruitItemAddedRepository.saveAddedItem(itemAdd);
      result = AddSuccess();
    }

    if (result is AddSuccess) {
      emit(MyBasketItemQuantity(_getTotalQuantityInBasket()));
    }
    return result;
  }

  bool _canAddToBasket(ItemAddedBasketModel itemAdd) {
    var remainItems = _getAvailableQuantityRemainOfItem(itemAdd.fruitItem);
    return remainItems >= itemAdd.quantity;
  }

  int _getAvailableQuantityRemainOfItem(FruitItem item) {
    if (item.availableQuantity == null) {
      item.availableQuantity = DEFAULT_AVAILABLE_QUANTITY_FRUIT;
    }
    return item.availableQuantity! -
        itemList[_getIndexOfFruitItemByComboId(item.comboId)].quantity;
  }

  Set<String> _getListComboIds() {
    Set<String> ids = new HashSet();
    itemList.forEach((element) {
      ids.add(element.fruitItem.comboId!);
    });
    return ids;
  }

  int _getIndexOfFruitItemByComboId(String? comboId) {
    var index = -1;
    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].fruitItem.comboId == comboId) {
        index = i;
        break;
      }
    }
    return index;
  }

  int _getTotalQuantityInBasket() {
    var total = 0;
    itemList.forEach((element) {
      total += element.quantity;
    });
    return total;
  }

  num calculateTotalPrice() {
    num _totalPrice = 0;
    for (var item in itemList) {
      _totalPrice = _totalPrice + (item.fruitItem.price! * item.quantity);
    }
    return _totalPrice;
  }

  String getCurrencySymbol() {
    if (itemList.isNotEmpty) {
      return itemList[0].fruitItem.currency ?? '';
    }
    return '';
  }

  void myBasketClicked() {
    emit(MyBasketIsClicked(_getTotalQuantityInBasket()));
  }

  void clearBasket() {
    itemList.clear();
    fruitItemAddedRepository.clearAllItemAdded();
    emit(MyBasketItemQuantity(itemList.length));
  }
}

abstract class AddToBasketResult {
  final String messageResult;

  AddToBasketResult(this.messageResult);
}

class AddSuccess extends AddToBasketResult {
  AddSuccess() : super(Strings.success);
}

class InvalidQuantity extends AddToBasketResult {
  final int max;

  InvalidQuantity(this.max) : super(Strings.the_quantity_should_in_range + '$max');
}

class OutOfAvailable extends AddToBasketResult {
  final int remain;

  OutOfAvailable(this.remain) : super(Strings.the_available_is_only + '$remain');
}
