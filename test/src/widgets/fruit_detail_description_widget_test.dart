import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list_detail/fruit_detail_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list_detail/fruit_list_detail_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list_detail/fruit_list_detail_state.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_detail_description_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFruitDetailBloc extends MockBloc<FruitDetailEvent, FruitDetailState>
    implements FruitDetailBloc {}

class FakeFruitDetailState extends Fake implements FruitDetailState {}
class FakeFruitDetailEvent extends Fake implements FruitDetailEvent {}

main() {
  late MockFruitDetailBloc mockFruitDetailBloc;

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

  setUpAll(() {
    registerFallbackValue<FruitDetailState>(FakeFruitDetailState());
    registerFallbackValue<FruitDetailEvent>(FakeFruitDetailEvent());

  });

  setUp(() {
    mockFruitDetailBloc = MockFruitDetailBloc();
    when(() => mockFruitDetailBloc.state)
        .thenAnswer((realInvocation) => FruitDetailInitialState());
  });

  testWidgets(
    'should find one error message when button click with phone field is empty',
        (WidgetTester tester) async {
          when(() => mockFruitDetailBloc.state)
              .thenReturn(FruitDetailAmountState(1) );
      await tester.pumpWidget(
        BlocProvider<FruitDetailBloc>(
          create: (context) => mockFruitDetailBloc,
          child: MaterialApp(
            home: Scaffold(
              body: FruitDetailDescriptionWidget(fruitItem: _fruitItem),
            ),
          ),
        ),
      );

      expect(find.text('Glazed Fruit Medley'), findsOneWidget);

      expect(find.text('Glazed'), findsNothing);

      var gestureDetector = find.byType(GestureDetector);
      expect(gestureDetector, findsWidgets);

      var minus = find.byIcon(Icons.remove);
      expect(minus, findsOneWidget);

      await tester.tap(minus, pointer: 1);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('1'), findsOneWidget);

          // when(() => mockFruitDetailBloc.state)
          //     .thenReturn(FruitDetailAmountState(2));

      // var add = find.byIcon(Icons.add);
      // expect(add, findsOneWidget);
      // await tester.tap(add, pointer: 1);
      // await tester.pump(const Duration(seconds: 3));
      // expect(find.text('2'), findsOneWidget);

      // await tester.tap(add, pointer: 1);
      // await tester.pump(const Duration(seconds: 3));
      // expect(find.text('3'), findsOneWidget);
      //
      // await tester.tap(add, pointer: 1);
      // await tester.pump(const Duration(seconds: 3));
      // expect(find.text('4'), findsNothing);
      //
      // await tester.tap(minus, pointer: 1);
      // await tester.pump(const Duration(seconds: 3));
      // expect(find.text('2'), findsOneWidget);
      //
      // var favorite = find.byIcon(Icons.favorite);
      // expect(favorite, findsOneWidget);
      // await tester.tap(favorite, pointer: 1);
      // await tester.pump(const Duration(seconds: 5));
      // expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    },
  );

  testWidgets(
    'should find one error message when button click with phone field is empty',
        (WidgetTester tester) async {
      // when(() => mockFruitDetailBloc.state)
      //     .thenReturn(FruitDetailAmountState(1) );
      await tester.pumpWidget(
        BlocProvider<FruitDetailBloc>(
          create: (context) => mockFruitDetailBloc,
          child: MaterialApp(
            home: Scaffold(
              body: FruitDetailDescriptionWidget(fruitItem: _fruitItem),
            ),
          ),
        ),
      );

      when(() => mockFruitDetailBloc.state)
          .thenReturn(FruitDetailAmountState(2));

      var add = find.byIcon(Icons.add);
      expect(add, findsOneWidget);
      await tester.tap(add, pointer: 1);
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('2'), findsOneWidget);

      // await tester.tap(add, pointer: 1);
      // await tester.pump(const Duration(seconds: 3));
      // expect(find.text('3'), findsOneWidget);
      //
      // await tester.tap(add, pointer: 1);
      // await tester.pump(const Duration(seconds: 3));
      // expect(find.text('4'), findsNothing);
      //
      // await tester.tap(minus, pointer: 1);
      // await tester.pump(const Duration(seconds: 3));
      // expect(find.text('2'), findsOneWidget);
      //
      // var favorite = find.byIcon(Icons.favorite);
      // expect(favorite, findsOneWidget);
      // await tester.tap(favorite, pointer: 1);
      // await tester.pump(const Duration(seconds: 5));
      // expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
    },
  );

}