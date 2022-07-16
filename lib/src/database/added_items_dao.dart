import 'package:flutter_fruit_hub/src/database/app_sql_query.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';
import 'package:sqflite/sqflite.dart';

class AddedItemsDao {
  static const TABLE_NAME = 'added_items';
  static const COLUMN_COMBO_ID = 'comboId';
  static const COLUMN_QUANTITY = 'quantity';

  final Database _database;

  AddedItemsDao(this._database);

  Future<List<ItemAddedBasketModel>> getAllAddedItems() async {
    List<ItemAddedBasketModel> result = [];

    final List<Map<String, dynamic>> dbData = await _database.query(TABLE_NAME);
    result = List.generate(dbData.length, (index) {
      return ItemAddedBasketModel(
          fruitItem: FruitItem.fromEntity(dbData[index]),
          quantity: dbData[index][COLUMN_QUANTITY]);
    });

    return result;
  }

  void saveAddedItem(ItemAddedBasketModel item) async {
    await _database.insert(TABLE_NAME, item.toEntity(),
        conflictAlgorithm: ConflictAlgorithm.abort);
  }

  void updateQuantityAddedItem(ItemAddedBasketModel item) async {
    await _database.rawUpdate(
        AppSqlQuery.UPDATE_QUANTITY_ADDED_ITEM, [item.quantity, item.fruitItem.comboId]);
  }

  void clearAllAddedItem() async {
    await _database.execute(AppSqlQuery.DELETE_ALL_RAW_ADDED_ITEM);
  }
}
