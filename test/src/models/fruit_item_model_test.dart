import 'dart:convert';

import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data/fruit_item_mock.dart';

void main() {
  Map<String, dynamic> json = jsonDecode(mockFruitItemJson);

  group('FruitItem Model Tests', () {
    test('Should support value comparisons', () {
      expect(
        true,
        FruitItem.fromJson(json) == FruitItem.fromJson(json),
      );
    });

    test('Should parse json to a FruitItem model', () {
      expect(() {
        FruitItem.fromJson(json);
      }, returnsNormally);
    });

    test('Should be able to deserialize a FruitItem with correct properties.', () {
      FruitItem fruitItem = FruitItem.fromJson(json);
      expect(fruitItem.availableQuantity, 15);
      expect(fruitItem.collection, 'Recommended');
      expect(fruitItem.color, '#F1EFF6');
      expect(fruitItem.comboId, 'JEWPz');
      expect(fruitItem.currency, '\$');
      expect(fruitItem.imageUrl, [
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BloodOrangeAvocadoSalad.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/ApplePecanSalad.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BlueberryCantaloupeSalad.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/FruitWithPoppySeedDressing.png',
        'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/GlazedFruitMedley.png'
      ]);
      expect(fruitItem.introduction,
          'The simple citrus and poppy seed dressing in this fruit medley really dresses up the refreshing mix of berries and melon.');
      expect(fruitItem.isFavorite, false);
      expect(fruitItem.name, 'Blueberry Cantaloupe Salad');
      expect(fruitItem.nutrition,
          '76 calories, 1g fat (0 saturated fat), 1mg cholesterol, 24mg sodium, 17g carbohydrate (15g sugars, 1g fiber), 2g protein.');
      expect(fruitItem.price, 1400);
    });

    test('Should be able to serialize a FruitItem with correct properties.', () {
      var fruitItem = FruitItem.fromJson(json);
      expect(jsonEncode(fruitItem.toJson()),
          mockFruitItemJson.replaceAll(RegExp(r'\s+(?=([^"]*"[^"]*")*[^"]*$)'), ''));
    });
  });
}
