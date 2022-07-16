import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_basket/my_basket_cubit.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('My Basket Cubit', () {
    late MyBasketCubit myBasketCubit;
    late List<FruitItem> fruitItem;
    setUp(() {
      myBasketCubit = MyBasketCubit();
      fruitItem = [
        FruitItem(
          availableQuantity: 10,
          comboId: '1',
          name: 'apple',
          price: 20000,
        ),
        FruitItem(
          availableQuantity: 10,
          comboId: '2',
          name: 'salad',
          price: 20000,
        ),
        FruitItem(
          availableQuantity: 10,
          comboId: '3',
          name: 'avocado',
          price: 20000,
        ),
        FruitItem(
          availableQuantity: 10,
          comboId: '4',
          name: 'strawberry',
          price: 20000,
        ),
        FruitItem(
          availableQuantity: 10,
          comboId: '5',
          name: 'watermelon',
          price: 20000,
        ),
      ];
    });

    tearDown(() {
      myBasketCubit.close();
    });

    blocTest<MyBasketCubit, MyBasketState>(
      'test total quantity in the basket',
      build: () {
        myBasketCubit.addItemToBasket(
          ItemAddedBasketModel(fruitItem: fruitItem[0], quantity: 3),
        );
        myBasketCubit.addItemToBasket(
          ItemAddedBasketModel(fruitItem: fruitItem[1], quantity: 3),
        );
        myBasketCubit.addItemToBasket(
          ItemAddedBasketModel(fruitItem: fruitItem[1], quantity: 3),
        );
        return myBasketCubit;
      },
      act: (cubit) {
        myBasketCubit.myBasketClicked();
      },
      expect: () => [
        isA<MyBasketState>()
            .having((total) => total.getTotalItem, 'total added item', 9),
      ],
    );

    test(
      'test add to basket success',
      () {
        AddToBasketResult addToBasketResult =
            myBasketCubit.addItemToBasket(ItemAddedBasketModel(
          fruitItem: fruitItem[0],
          quantity: 1,
        ));
        expect(addToBasketResult, isA<AddSuccess>());
      },
    );

    test(
      'test add to basket InvalidQuantity ',
      () {
        AddToBasketResult addToBasketResult =
            myBasketCubit.addItemToBasket(ItemAddedBasketModel(
          fruitItem: fruitItem[0],
          quantity: -1,
        ));
        expect(addToBasketResult, isA<InvalidQuantity>());
      },
    );

    test(
      'test add to basket OutOfAvailable',
      () {
        AddToBasketResult addToBasketResult =
            myBasketCubit.addItemToBasket(ItemAddedBasketModel(
          fruitItem: fruitItem[0],
          quantity: 30,
        ));
        expect(addToBasketResult, isA<OutOfAvailable>());
      },
    );

    test(
      'test total price',
      () {
        expect(myBasketCubit.calculateTotalPrice(), 20000 * 9 + 20000);
      },
    );
  });
}
