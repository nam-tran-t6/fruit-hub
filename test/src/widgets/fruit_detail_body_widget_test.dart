import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_detail_body_widget.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  FruitItem _fruitItem = FruitItem(
      availableQuantity: 3,
      collection: "Recommended",
      color: "#FFCC80",
      comboId: "3fHq5",
      currency: "\$",
      imageUrl: [
        "https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BloodOrangeAvocadoSalad.png",
        "https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/ApplePecanSalad.png",
        "https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BlueberryCantaloupeSalad.png",
        "https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/FruitWithPoppySeedDressing.png",
        "https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/GlazedFruitMedley.png"
      ],
      introduction: "The orange dressing on this salad complements the fresh fruit "
          "flavors beautifully. It's perfect for a spring or summer brunch.",
      isFavorite: true,
      name: "Glazed Fruit Medley",
      nutrition: "188 calories, 1g fat (0 saturated fat), 0 cholesterol, 7mg sodium,"
          " 47g carbohydrate (41g sugars, 2g fiber), 1g protein.",
      price: 1300);

  group('Test Fruit Detail Body Widget', () {
    testWidgets("Test Widget", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: FruitDetailBodyWidget(
        fruitItem: _fruitItem,
      )));

      expect(find.text('Glazed Fruit Medley'), findsOneWidget);

      expect(find.text('Glazed'), findsNothing);

      var gestureDetector = find.byType(GestureDetector);
      expect(gestureDetector, findsWidgets);

      var minus = find.byIcon(Icons.remove);
      expect(minus, findsOneWidget);

      await tester.tap(minus, pointer: 1);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('1'), findsOneWidget);

      var add = find.byIcon(Icons.add);
      expect(add, findsOneWidget);
      await tester.tap(add, pointer: 1);
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('2'), findsOneWidget);

      await tester.tap(add, pointer: 1);
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('3'), findsOneWidget);

      await tester.tap(minus, pointer: 1);
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('2'), findsOneWidget);

      var favorite = find.byIcon(Icons.favorite);
      expect(favorite, findsOneWidget);
      await tester.tap(favorite, pointer: 1);
      await tester.pump(const Duration(seconds: 5));
      expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    });

    testWidgets("Test gesture move down", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
          home: FruitDetailBodyWidget(
        fruitItem: _fruitItem,
      )));
      TestGesture gesture = await tester
          .startGesture(tester.getRect(find.byKey(Key('gesture_detector'))).center);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.longPress(find.byKey(Key('gesture_detector')), pointer: 2);
      await tester.pump(const Duration(seconds: 3));
      await gesture.moveBy(const Offset(0.0, 600.0), timeStamp: Duration(seconds: 3));
      await gesture.up();
      await tester.pump(const Duration(seconds: 1));
    });
  });
}
