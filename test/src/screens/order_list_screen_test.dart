import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';
import 'package:flutter_fruit_hub/src/screens/order_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mock_image_http.dart';

class MockBasketCubit extends MockCubit<MyBasketState>
    implements MyBasketCubit {}

class FakeMyBasketState extends Fake implements MyBasketState {}

late List<ItemAddedBasketModel> fakeList;

void main() {
  late MyBasketCubit mockBasketCubit;

  setUpAll(() {
    registerFallbackValue<FakeMyBasketState>(FakeMyBasketState());
    registerFallbackValue<Uri>(Uri());
  });

  setUp(() {
    mockBasketCubit = MockBasketCubit();
    when(() => mockBasketCubit.itemList)
        .thenAnswer((realInvocation) => fakeList);
    when(() => mockBasketCubit.getCurrencySymbol())
        .thenAnswer((invocation) => '\$');
    when(() => mockBasketCubit.calculateTotalPrice())
        .thenAnswer((invocation) => 100000);
  });

  tearDown(() {
    mockBasketCubit.close();
  });

  group("ScrollTestingWidget", () {
    testWidgets(
      'Should not scroll with less items',
      (WidgetTester tester) async {
        generateFakeList(3);
        await HttpOverrides.runZoned<Future<void>>(() async {
          await tester.pumpWidget(
            BlocProvider(
              create: (context) {
                return mockBasketCubit;
              },
              child: MaterialApp(
                home: OrderListScreen(),
              ),
            ),
          );
          await tester.drag(find.byType(ListView), const Offset(0, -300));
          await tester.pump();
          final firstItemFinder = find.text('Item 0');
          expect(firstItemFinder, findsOneWidget);
        }, createHttpClient: createMockImageHttpClient);
      },
    );
    testWidgets(
      'should scroll with a lot of items',
      (WidgetTester tester) async {
        generateFakeList(6);
        await HttpOverrides.runZoned<Future<void>>(() async {
          await tester.pumpWidget(
            BlocProvider(
              create: (context) {
                return mockBasketCubit;
              },
              child: MaterialApp(
                home: OrderListScreen(),
              ),
            ),
          );
          await tester.drag(find.byType(ListView), const Offset(0, -300));
          await tester.pump();
          final firstItemFinder = find.text('Item 0');
          final sevenItemFinder = find.text('Item 5');

          expect(firstItemFinder, findsNothing);
          expect(sevenItemFinder, findsOneWidget);
        }, createHttpClient: createMockImageHttpClient);
      },
    );
    testWidgets(
      'should find center empty message when the list is empty',
          (WidgetTester tester) async {
        generateFakeList(0);
        await HttpOverrides.runZoned<Future<void>>(() async {
          await tester.pumpWidget(
            BlocProvider(
              create: (context) {
                return mockBasketCubit;
              },
              child: MaterialApp(
                home: OrderListScreen(),
              ),
            ),
          );
          final emptyMess = find.text(Strings.my_basket_title);
          expect(emptyMess, findsOneWidget);
        }, createHttpClient: createMockImageHttpClient);
      },
    );
  });
}

void generateFakeList(int numberOfItem) {
  fakeList = List.generate(
    numberOfItem,
    (index) => ItemAddedBasketModel(
        fruitItem: FruitItem(
          comboId: index.toString(),
          name: 'Item $index',
          currency: 'dol',
          price: 20000,
          collection: 'dd',
          nutrition: 'ddd',
          introduction: 'dd',
          imageUrl: [
            'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BloodOrangeAvocadoSalad.png',
            'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/ApplePecanSalad.png',
            'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/BlueberryCantaloupeSalad.png',
            'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/FruitWithPoppySeedDressing.png',
            'https://fruit-hub.s3-us-west-2.amazonaws.com/Combo/GlazedFruitMedley.png'
          ],
          availableQuantity: 23,
          color: 'red',
          isFavorite: true,
        ),
        quantity: 10),
  );
}
