import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/screens/add_to_basket_screen.dart';
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
      introduction:
          "The orange dressing on this salad complements the fresh fruit "
          "flavors beautifully. It's perfect for a spring or summer brunch.",
      isFavorite: true,
      name: "Glazed Fruit Medley",
      nutrition:
          "188 calories, 1g fat (0 saturated fat), 0 cholesterol, 7mg sodium,"
          " 47g carbohydrate (41g sugars, 2g fiber), 1g protein.",
      price: 1300);

  group("Test add to basket screen", () {
    testWidgets("Test long press and move down", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Navigator(
        onGenerateRoute: (_) {
          return MaterialPageRoute<Widget>(
            builder: (_) => AddToBasketScreen(),
            settings: RouteSettings(arguments: _fruitItem),
          );
        },
      )));
      TestGesture gesture = await tester.startGesture(
          tester.getRect(find.byKey(Key('gesture_detector'))).topCenter);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.longPress(find.byKey(Key('gesture_detector')), pointer: 3);
      await tester.pump(const Duration(seconds: 3));
      await gesture.moveBy(const Offset(0.0, 50.0),
          timeStamp: Duration(seconds: 3));
      await gesture.up();
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets("Test long press and move up", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Navigator(
        onGenerateRoute: (_) {
          return MaterialPageRoute<Widget>(
            builder: (_) => AddToBasketScreen(),
            settings: RouteSettings(arguments: _fruitItem),
          );
        },
      )));
      TestGesture gesture = await tester.startGesture(
          tester.getRect(find.byKey(Key('gesture_detector'))).topCenter);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.longPress(find.byKey(Key('gesture_detector')), pointer: 3);
      await tester.pump(const Duration(seconds: 3));
      await gesture.moveBy(const Offset(0.0, 0.0),
          timeStamp: Duration(seconds: 3));
      await gesture.up();
      await tester.pump(const Duration(seconds: 5));
    });
  });
}
