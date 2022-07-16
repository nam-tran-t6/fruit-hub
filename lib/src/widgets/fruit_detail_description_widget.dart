import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list_detail/fruit_detail_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list_detail/fruit_list_detail_event.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list_detail/fruit_list_detail_state.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/extension/num_extension.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_icons.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/models/item_added_basket_model.dart';
import 'package:flutter_fruit_hub/src/widgets/app_button.dart';
import 'package:flutter_fruit_hub/src/widgets/round_icon_button.dart';

class FruitDetailDescriptionWidget extends StatefulWidget {
  final FruitItem fruitItem;

  const FruitDetailDescriptionWidget({Key? key, required this.fruitItem})
      : super(key: key);

  @override
  _FruitDetailDescriptionWidgetState createState() =>
      _FruitDetailDescriptionWidgetState();
}

class _FruitDetailDescriptionWidgetState extends State<FruitDetailDescriptionWidget> {
  int quantityOrder = 1;
  bool favoriteState = false;

  @override
  Widget build(BuildContext context) {
    favoriteState = widget.fruitItem.isFavorite!;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          initOrderQuantityControlWidget(),
          Divider(
            height: 1,
            color: AppColors.concrete,
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 0, // space between underline and text
            ),
            margin: EdgeInsets.only(left: 24, right: 24),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.texas_rose,
                  // Text colour here
                  width: 1.0, // Underline width
                ),
              ),
            ),
            child: Text(
              Strings.one_pack_contains,
              style: AppTextStyles.kNormalPortGore20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.fruitItem.nutrition!}',
                        style: AppTextStyles.kBoldPortGore16,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  color: AppColors.concrete,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 15, top: 24),
                  child: Text(
                    '${widget.fruitItem.introduction!}',
                    style: AppTextStyles.kNormalBlack16,
                  ),
                ),
              ],
            ),
          )),
          SizedBox(
            height: 15,
          ),
          initButtonAddBasketWidget()
        ],
      ),
    );
  }

  Widget initOrderQuantityControlWidget() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 25, top: 30),
      child: BlocBuilder<FruitDetailBloc, FruitDetailState>(
        builder: (context, state) {
          if (state is FruitDetailAmountState) {
            quantityOrder = state.quantityOrder;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.fruitItem.name!,
                style: AppTextStyles.kBoldPortGore32,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (quantityOrder == 1)
                            ? RoundIconButton(
                                icon: AppIcons.minus,
                                fillColor: AppColors.accent,
                                size: 32,
                                borderColor: AppColors.port_gore,
                                isDisable: true,
                                onPressed: () {
                                  BlocProvider.of<FruitDetailBloc>(context)
                                      .add(PressedDecrementItemEvent());
                                },
                              )
                            : RoundIconButton(
                                icon: AppIcons.minus,
                                fillColor: AppColors.serenade,
                                size: 32,
                                borderColor: AppColors.serenade,
                                iconColor: AppColors.texas_rose,
                                onPressed: () {
                                  BlocProvider.of<FruitDetailBloc>(context)
                                      .add(PressedDecrementItemEvent());
                                },
                              ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '$quantityOrder',
                          style: AppTextStyles.kNormalPortGore24,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        (quantityOrder == widget.fruitItem.availableQuantity! ||
                                widget.fruitItem.availableQuantity! == 0)
                            ? RoundIconButton(
                                icon: AppIcons.add,
                                fillColor: AppColors.accent,
                                size: 32,
                                borderColor: AppColors.port_gore,
                                isDisable: true,
                                onPressed: () {
                                  BlocProvider.of<FruitDetailBloc>(context)
                                      .add(PressedIncrementItemEvent());
                                },
                              )
                            : RoundIconButton(
                                icon: AppIcons.add,
                                fillColor: AppColors.serenade,
                                size: 32,
                                borderColor: AppColors.serenade,
                                iconColor: AppColors.texas_rose,
                                onPressed: () {
                                  BlocProvider.of<FruitDetailBloc>(context)
                                      .add(PressedIncrementItemEvent());
                                },
                              )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.fruitItem.currency!,
                          style: AppTextStyles.kNormalPortGore24,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${(quantityOrder * widget.fruitItem.price!).toCurrencyFormat()}',
                          style: AppTextStyles.kNormalPortGore24,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget initButtonAddBasketWidget() {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, bottom: (24 + MediaQuery.of(context).size.height * 0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<FruitDetailBloc, FruitDetailState>(
            builder: (context, state) {
              if (state is FruitItemCurrentFavoriteState) {
                favoriteState = state.isFavorite;
              }
              return RoundIconButton(
                icon: favoriteState ? AppIcons.favorite : AppIcons.favorite_outline,
                fillColor: AppColors.seashell_peach,
                size: 48,
                borderColor: AppColors.seashell_peach,
                iconColor: AppColors.texas_rose,
                onPressed: () {
                  BlocProvider.of<FruitDetailBloc>(context).add(
                      ToggleFruitItemFavoriteEvent(currentFavoriteState: favoriteState));
                },
              );
            },
          ),
          BlocListener<FruitDetailBloc, FruitDetailState>(
            listener: (context, state) {
              if (state is ShouldBackToHomeScreen) {
                Navigator.pop(context);
              }
            },
            child: AppButton(
              isPrimary: true,
              width: 219,
              height: 56,
              buttonText: Strings.add_to_basket,
              onPressed: () {
                BlocProvider.of<FruitDetailBloc>(context).add(PressedAddToBasketEvent(
                    context: context,
                    itemAddedBasketModel: ItemAddedBasketModel(
                        fruitItem: widget.fruitItem, quantity: quantityOrder)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
