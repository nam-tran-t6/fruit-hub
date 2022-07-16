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

class FruitDetailBodyWidget extends StatefulWidget {
  final FruitItem fruitItem;

  const FruitDetailBodyWidget({Key? key, required this.fruitItem}) : super(key: key);

  @override
  FruitDetailBodyWidgetState createState() => FruitDetailBodyWidgetState();
}

class FruitDetailBodyWidgetState extends State<FruitDetailBodyWidget>
    with SingleTickerProviderStateMixin {
  int posYContainer = 0;
  int posYPageView = 0;

  int posYCollapsed = 0;
  int posYExpanded = 0;

  int initialY = 0;
  int initialTouchY = 0;
  int stackSize = 0;

  double imageSizePrevious = 0;
  double imageSize = 0;
  int rangeDrag = 0;
  double percentDrag = 0;

  bool firstBuild = true;

  int quantityOrder = 1;
  bool favoriteState = false;

  bool longPressed = false;

  GlobalKey keyStack = GlobalKey();

  final PageController _pageController = PageController(initialPage: 0);
  late AnimationController _animationController;
  int _currentPage = 0;

  FruitDetailBloc _fruitDetailBloc = FruitDetailBloc();

  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reset();
        final int totalPage =
            (widget.fruitItem.imageUrl != null) ? widget.fruitItem.imageUrl!.length : 0;
        _currentPage++;
        if (_currentPage == totalPage) {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 200), curve: Curves.easeInSine);
      }
    });
    calculateStackSize();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fruitDetailBloc.close();
    super.dispose();
  }

  void calculateStackSize() => WidgetsBinding.instance!.addPostFrameCallback(
        (_) {
          final RenderBox box = keyStack.currentContext!.findRenderObject() as RenderBox;
          Size size = box.size;
          stackSize = size.height.toInt();
          firstBuild = false;
        },
      );

  void onTapDown(BuildContext context, TapDownDetails details) {
    firstBuild = false;
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    initialY = posYContainer;
    initialTouchY = localOffset.dy.toInt();
  }

  void onLongPressStart(LongPressStartDetails details) {
    setState(() {
      longPressed = true;
    });
  }

  void onLongPressMoveUpdate(BuildContext context, LongPressMoveUpdateDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      if (posYContainer >= posYExpanded && posYContainer <= posYCollapsed) {
        posYContainer = (initialY + (localOffset.dy - initialTouchY)).toInt();
        if (posYContainer < posYExpanded) {
          posYContainer = posYExpanded;
        }
        if (posYContainer > posYCollapsed) {
          posYContainer = posYCollapsed;
        }
        posYPageView = stackSize - posYContainer;
        calculateImageSize();
      }
    });
  }

  void onTapUp(BuildContext context) {
    initialY = 0;
    initialTouchY = 0;
    setState(() {
      longPressed = false;
    });
  }

  void calculateImageSize() {
    rangeDrag = posYCollapsed - posYExpanded;
    percentDrag = ((posYContainer - posYExpanded) * 100) / rangeDrag;
    imageSize = imageSizePrevious +
        (((MediaQuery.of(context).size.width - imageSizePrevious) * percentDrag) / 100) *
            0.9;
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();

    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    if (firstBuild) {
      posYContainer = (MediaQuery.of(context).size.height * 0.3).toInt();
      posYPageView = (MediaQuery.of(context).size.height * 0.6).toInt();
      posYExpanded = posYContainer;
      posYCollapsed = (heightScreen * 0.8).toInt();
      imageSizePrevious = (MediaQuery.of(context).size.height * 0.3) * 0.8;
      imageSize = imageSizePrevious;
    }
    favoriteState = widget.fruitItem.isFavorite!;
    return BlocProvider(
      create: (context) => _fruitDetailBloc,
      child: Stack(key: keyStack, fit: StackFit.expand, children: <Widget>[
        Positioned(
          child: Container(
            width: widthScreen,
            color: AppColors.texas_rose,
            child: PageView.builder(
              controller: _pageController,
              itemCount: (widget.fruitItem.imageUrl != null)
                  ? widget.fruitItem.imageUrl!.length
                  : 0,
              onPageChanged: (value) {
                print(_currentPage);
                _currentPage = value;
                _animationController.reset();
                _animationController.forward();
              },
              itemBuilder: (context, i) {
                return Center(
                    child: Container(
                  width: imageSize,
                  height: imageSize,
                  child: Image.network(
                    widget.fruitItem.imageUrl![i],
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ));
              },
            ),
          ),
          top: 0,
          left: 0,
          bottom: posYPageView.toDouble(),
        ),
        Positioned(
          child: GestureDetector(
            key: Key('gesture_detector'),
            onTapDown: (TapDownDetails details) => onTapDown(context, details),
            onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) =>
                onLongPressMoveUpdate(context, details),
            onLongPressUp: () => onTapUp(context),
            onLongPressStart: (details) => onLongPressStart(details),
            child: new Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                color: longPressed ? Colors.blue[50] : Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Container(
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
                            padding:
                                EdgeInsets.only(left: 24, right: 24, bottom: 15, top: 24),
                            child: Text(
                              '${widget.fruitItem.introduction!}',
                              style: AppTextStyles.kBoldPortGore16,
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
              ),
            ),
          ),
          top: posYContainer.toDouble(),
        )
      ]),
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
                                  _fruitDetailBloc.add(PressedDecrementItemEvent());
                                },
                              )
                            : RoundIconButton(
                                icon: AppIcons.minus,
                                fillColor: AppColors.serenade,
                                size: 32,
                                borderColor: AppColors.serenade,
                                iconColor: AppColors.texas_rose,
                                onPressed: () {
                                  _fruitDetailBloc.add(PressedDecrementItemEvent());
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
                                  _fruitDetailBloc.add(PressedIncrementItemEvent());
                                },
                              )
                            : RoundIconButton(
                                icon: AppIcons.add,
                                fillColor: AppColors.serenade,
                                size: 32,
                                borderColor: AppColors.serenade,
                                iconColor: AppColors.texas_rose,
                                onPressed: () {
                                  _fruitDetailBloc.add(PressedIncrementItemEvent());
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
      padding: EdgeInsets.only(left: 24, right: 24, bottom: 24),
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
                  _fruitDetailBloc.add(
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
                _fruitDetailBloc.add(PressedAddToBasketEvent(
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
