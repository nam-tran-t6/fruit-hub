import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_item/fruit_item_state.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/num_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/string_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_box_decoration_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_images_path.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';
import 'package:flutter_fruit_hub/src/repositories/fruit_item_repository.dart';
import 'package:flutter_fruit_hub/src/screens/add_to_basket_screen.dart';
import 'package:flutter_fruit_hub/src/services/fruit_item_service.dart';

class FruitItemWidget extends StatelessWidget {
  final double width;
  final double height;
  final FruitItem fruitItem;
  final Widget favoriteButton;

  FruitItemWidget(
      {required this.width,
      required this.height,
      required this.fruitItem,
      this.favoriteButton = const SizedBox()});

  @override
  Widget build(BuildContext widgetContext) {
    return BlocProvider(
      create: (context) => FruitItemBloc(FruitItemRepository(FruitItemApiService())),
      child: BlocConsumer<FruitItemBloc, FruitItemState>(
        listener: (context, state) {
          if (state is FruitItemLoaded) {
            Navigator.pushNamed(
              widgetContext,
              AddToBasketScreen.TAG,
              arguments: state.fruitItemDetail,
            );
          }
        },
        builder: (context, state) {
          if (state is FruitItemInitial ||
              state is FruitItemLoading ||
              state is FruitItemLoaded) {
            return GestureDetector(
              onTap: () {
                if (!state.getLoadingState)
                  BlocProvider.of<FruitItemBloc>(context)
                      .add(FruitItemFetchRequest(id: fruitItem.comboId));
              },
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: AppBoxDecorStyles.kShadowMineShaft005Radius16.copyWith(
                      color: Color(
                        fruitItem.color!.toHexColor(),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          top: 5,
                          child: favoriteButton,
                        ),
                        Positioned(
                          left: 36,
                          right: 36,
                          top: 22,
                          child: Container(
                            width: 90,
                            height: 90,
                            child: Center(
                              child: Image.network(fruitItem.imageUrl![0]),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 110,
                          left: 16,
                          right: 20,
                          child: Text(
                            fruitItem.name!,
                            textAlign: TextAlign.left,
                            maxLines: 1,
                            style: AppTextStyles.kNormalPortGore14,
                          ),
                        ),
                        Positioned(
                          top: 137,
                          left: 17,
                          child: Row(
                            children: [
                              Text(
                                fruitItem.currency!,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.carrot_orange,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                fruitItem.price == 0
                                    ? ''
                                    : fruitItem.price!.toCurrencyFormat(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: AppTextStyles.kNormalPortGore14,
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<FruitItemBloc>(context).add(
                                    FruitItemEventAddToBasket(
                                      context,
                                      ItemAddedBasketModel(
                                        fruitItem: fruitItem,
                                        quantity: 1,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  AppImagePath.add_icon,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.getLoadingState)
                    Container(
                      width: width,
                      height: height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      decoration: AppBoxDecorStyles.kShadowMineShaft005Radius16.copyWith(
                        color: AppColors.white.withOpacity(0.5),
                      ),
                    ),
                ],
              ),
            );
          }
          if (state is FruitItemLoadError) {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<FruitItemBloc>(context)
                    .add(FruitItemFetchRequest(id: fruitItem.comboId));
              },
              child: Container(
                width: width,
                height: height,
                decoration: AppBoxDecorStyles.kShadowMineShaft005Radius16.copyWith(
                  color: Color(fruitItem.color!.toHexColor()),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    state.errorMessage,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.kNormalCinnabar14,
                  ),
                ),
              ),
            );
          }
          return Container(
            width: width,
            height: height,
            decoration: AppBoxDecorStyles.kShadowMineShaft005Radius16.copyWith(
              color: Color(fruitItem.color!.toHexColor()),
            ),
          );
        },
      ),
    );
  }
}
