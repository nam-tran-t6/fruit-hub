import 'dart:convert';

import 'package:flutter_fruit_hub/src/models/collection_fruit_model.dart';
import 'package:flutter_fruit_hub/src/services/base_service/base_api_service.dart';

class CollectionMenuApiService extends BaseApiService {
  static const END_POINT = '/dev/fruit-hub/options';

  Future<List<CollectionFruitMenu>> fetchListMenu() async {
    var dataStr = await executeGetRequest();
    Map<String, dynamic> dataJson = json.decode(dataStr);
    var menuNames = List<String>.from(dataJson['options']);
    List<CollectionFruitMenu> menus = [];
    menuNames.forEach(
      (name) {
        menus.add(CollectionFruitMenu(name));
      },
    );
    return menus;
  }

  @override
  String getEndpoint() {
    return END_POINT;
  }

  @override
  Map<String, dynamic>? getParams() {
    return null;
  }
}
