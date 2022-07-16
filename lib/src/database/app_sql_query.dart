import 'package:flutter_fruit_hub/src/database/added_items_dao.dart';

class AppSqlQuery {
  static const String CREATE_TABLE_ADDED_ITEM =
      'CREATE TABLE IF NOT EXISTS ${AddedItemsDao.TABLE_NAME} ('
      'availableQuantity INTEGER, '
      'collection TEXT, '
      'color TEXT, '
      '${AddedItemsDao.COLUMN_COMBO_ID} TEXT PRIMARY KEY, '
      'currency TEXT, '
      'imageUrl TEXT, '
      'introduction TEXT, '
      'isFavorite BOOLEAN, '
      'name TEXT, '
      'nutrition TEXT, '
      'price REAL, '
      '${AddedItemsDao.COLUMN_QUANTITY} INTEGER)';

  static const String DELETE_ALL_RAW_ADDED_ITEM =
      'DELETE FROM ${AddedItemsDao.TABLE_NAME}';

  static const String UPDATE_QUANTITY_ADDED_ITEM = '''UPDATE ${AddedItemsDao.TABLE_NAME} 
      SET ${AddedItemsDao.COLUMN_QUANTITY} = ? 
      WHERE ${AddedItemsDao.COLUMN_COMBO_ID} = ?''';
}
