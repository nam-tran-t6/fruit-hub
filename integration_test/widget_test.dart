import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_icons.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_detail_body_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/round_icon_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets("Test round icon button enable", (WidgetTester tester) async {
    bool roundButtonEvent = false;

    await tester.pumpWidget(MaterialApp(
        home: RoundIconButton(
      icon: AppIcons.minus,
      fillColor: AppColors.serenade,
      size: 32,
      borderColor: AppColors.serenade,
      iconColor: AppColors.texas_rose,
      onPressed: () {
        roundButtonEvent = !roundButtonEvent;
      },
    )));

    var gestureDetector = find.byType(InkWell);
    expect(gestureDetector, findsOneWidget);
    await tester.tap(gestureDetector, pointer: 1);
    expect(roundButtonEvent, equals(true));

    var icon = find.byType(Icon);
    expect(icon, findsOneWidget);
    var iconColorsDisable = ((tester.firstWidget(icon)) as Icon).color;
    expect(iconColorsDisable, AppColors.texas_rose);
  });

  testWidgets("Test round icon button disable", (WidgetTester tester) async {
    bool roundButtonEvent = false;

    await tester.pumpWidget(MaterialApp(
        home: RoundIconButton(
      icon: AppIcons.minus,
      fillColor: AppColors.serenade,
      size: 32,
      borderColor: AppColors.serenade,
      iconColor: AppColors.texas_rose,
      isDisable: true,
      onPressed: () {
        roundButtonEvent = !roundButtonEvent;
      },
    )));

    var inkWell = find.byType(InkWell);
    expect(inkWell, findsOneWidget);
    await tester.tap(inkWell, pointer: 1);
    expect(roundButtonEvent, equals(false));

    var icon = find.byType(Icon);
    expect(icon, findsOneWidget);
    var iconColorsDisable = ((tester.firstWidget(icon)) as Icon).color;
    expect(iconColorsDisable, AppColors.texas_rose.withOpacity(0.3));
  });

  testWidgets("Test Widget", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: FruitDetailBodyWidget(
      fruitItem: _fruitItem,
    )));

    expect(find.text('Glazed Fruit Medley'), findsOneWidget);

    expect(find.text('Glazed'), findsNothing);

    var gestureDetector = find.byType(GestureDetector);
    expect(gestureDetector, findsWidgets);

    // var minus = find.byIcon(Icons.remove);
    // expect(minus, findsOneWidget);
    //
    // await tester.tap(minus, pointer: 1);
    // await tester.pump(const Duration(seconds: 1));
    // expect(find.text('1'), findsOneWidget);
    //
    // var add = find.byIcon(Icons.add);
    // expect(add, findsOneWidget);
    // await tester.tap(add, pointer: 1);
    // await tester.pump(const Duration(seconds: 3));
    // expect(find.text('2'), findsOneWidget);

    // await tester.tap(add, pointer: 1);
    // await tester.pump(const Duration(seconds: 3));
    // expect(find.text('3'), findsOneWidget);

    // await tester.tap(minus, pointer: 1);
    // await tester.pump(const Duration(seconds: 3));
    // expect(find.text('2'), findsOneWidget);

    // var favorite = find.byIcon(Icons.favorite);
    // expect(favorite, findsOneWidget);
    // await tester.tap(favorite, pointer: 1);
    // await tester.pump(const Duration(seconds: 5));
    // expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
  });

  // testWidgets("Test gesture move down", (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //       home: FruitDetailBodyWidget(
  //     fruitItem: _fruitItem,
  //   )));
  //   TestGesture gesture = await tester
  //       .startGesture(tester.getRect(find.byKey(Key('gesture_detector'))).center);
  //   await tester.pump(const Duration(milliseconds: 100));
  //   await tester.longPress(find.byKey(Key('gesture_detector')), pointer: 2);
  //   await tester.pump(const Duration(seconds: 3));
  //   await gesture.moveBy(const Offset(0.0, 600.0), timeStamp: Duration(seconds: 3));
  //   await gesture.up();
  //   await tester.pump(const Duration(seconds: 1));
  // });
}
