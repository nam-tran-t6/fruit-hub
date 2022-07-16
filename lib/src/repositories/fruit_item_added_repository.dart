import 'package:flutter_fruit_hub/src/database/added_items_dao.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';

class FruitItemAddedRepository {
  late AddedItemsDao _addedItemsDao;

  FruitItemAddedRepository(this._addedItemsDao);

  Future<List<ItemAddedBasketModel>> getAllStorageAddedItems() async {
    var fruits = await _addedItemsDao.getAllAddedItems();
    return fruits;
  }

  void saveAddedItem(ItemAddedBasketModel item) {
    _addedItemsDao.saveAddedItem(item);
  }

  void updateQuantityAdded(ItemAddedBasketModel item) {
    _addedItemsDao.updateQuantityAddedItem(item);
  }

  void clearAllItemAdded() {
    _addedItemsDao.clearAllAddedItem();
  }
}
