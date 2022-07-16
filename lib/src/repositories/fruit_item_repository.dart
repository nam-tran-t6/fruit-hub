import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/services/fruit_item_service.dart';

class FruitItemRepository {
  FruitItemApiService fruitItemApiService;

  FruitItemRepository(this.fruitItemApiService);

  Future<FruitItem> fetchFruitItem(String id) async {
    var fruitItemDetail = await fruitItemApiService.fetchFruitItem(id);
    return fruitItemDetail;
  }
}
