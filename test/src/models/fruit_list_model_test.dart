import 'dart:convert';

import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data/fruit_list_mock.dart';

void main() {
  Map<String, dynamic> json = jsonDecode(mockFruitListJson);

  group('fruitList Model Tests', () {
    test('Should support value comparisons', () {
      expect(
        true,
        FruitList.fromJson(json) == FruitList.fromJson(json),
      );
    });

    test('Should parse json to a FruitList model', () {
      expect(() {
        FruitList.fromJson(json);
      }, returnsNormally);
    });

    test('Should return correct number of fruit items in the list', () {
      expect(10, FruitList.fromJson(json).list.length);
    });

    test('Should be able to deserialize a FruitList with correct properties.', () {
      FruitList fruitList = FruitList.fromJson(json);
      expect(fruitList.list[0].availableQuantity, 15);
      expect(fruitList.list[0].collection, 'Recommended');
      expect(fruitList.list[0].color, '#FEF0F0');
      expect(fruitList.list[0].comboId, 'UZOab');
      expect(fruitList.list[0].currency, '\$');
      expect(fruitList.list[0].imageUrl, [
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BloodOrangeAvocadoSalad.png'
      ]);
      expect(fruitList.list[0].introduction, null);
      expect(fruitList.list[0].isFavorite, false);
      expect(fruitList.list[0].name, 'Blood Orange Avocado Salad');
      expect(fruitList.list[0].nutrition, null);
      expect(fruitList.list[0].price, 1100);
    });

    test('Should be able to serialize a FruitList with correct properties.', () {
      var fruitList = FruitList.fromJson(json);

      expect(jsonEncode(fruitList.toJson()),
          mockFruitListJson.replaceAll(RegExp(r'\s+(?=([^"]*"[^"]*")*[^"]*$)'), ''));
    });
  });
}
