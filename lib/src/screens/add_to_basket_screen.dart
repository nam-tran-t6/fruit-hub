import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/fruit_list_detail/fruit_detail_bloc.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/models/fruit_item_model.dart';
import 'package:flutter_fruit_hub/src/widgets/app_bar_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_detail_banner_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/fruit_detail_description_widget.dart';

class AddToBasketScreen extends StatefulWidget {
  static const String TAG = 'add_to_basket_screen';

  @override
  _AddToBasketScreenState createState() => _AddToBasketScreenState();
}

class _AddToBasketScreenState extends State<AddToBasketScreen> {
  int posYContainer = 0;
  int posYPageView = 0;

  int posYCollapsed = 0;
  int posYExpanded = 0;
  int centerCollapsed = 0;

  int initialY = 0;
  int initialTouchY = 0;
  int stackSize = 0;

  double imageMinSize = 0;
  double imageMaxSize = 0;
  double imageSize = 0;
  int rangeDrag = 0;
  double percentDrag = 0;

  bool firstBuild = true;

  int quantityOrder = 1;
  bool favoriteState = false;

  bool isLongPressed = false;

  GlobalKey keyStack = GlobalKey();

  FruitDetailBloc _fruitDetailBloc = FruitDetailBloc();

  @override
  void initState() {
    super.initState();
    calculateStackSize();
  }

  @override
  void dispose() {
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
      isLongPressed = true;
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
    if (posYContainer != posYExpanded && posYContainer < centerCollapsed) {
      posYContainer = posYExpanded;
    } else {
      posYContainer = posYCollapsed;
    }
    posYPageView = stackSize - posYContainer;
    setState(() {
      isLongPressed = false;
    });
  }

  void calculateImageSize() {
    rangeDrag = posYCollapsed - posYExpanded;
    percentDrag = ((posYContainer - posYExpanded) * 100) / rangeDrag;
    imageSize = imageMinSize + (((imageMaxSize - imageMinSize) * percentDrag) / 100);
  }

  @override
  Widget build(BuildContext context) {
    final fruitItem = ModalRoute.of(context)!.settings.arguments as FruitItem;

    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;
    if (firstBuild) {
      posYContainer = (MediaQuery.of(context).size.height * 0.3).toInt();
      posYPageView = (MediaQuery.of(context).size.height * 0.6).toInt();
      posYExpanded = posYContainer;
      posYCollapsed = (heightScreen * 0.8).toInt();
      centerCollapsed = (((posYCollapsed - posYExpanded) / 2) + posYExpanded).toInt();
      imageMinSize = (MediaQuery.of(context).size.height * 0.3) * 0.8;
      imageMaxSize = MediaQuery.of(context).size.width * 0.9;
      imageSize = imageMinSize;
    }
    favoriteState = fruitItem.isFavorite!;

    return Scaffold(
      backgroundColor: AppColors.texas_rose,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppBarWidget(
              actionBackPress: () => Navigator.pop(context),
              percentageHeight: 0.1,
            ),
            Expanded(
                child: BlocProvider(
              create: (context) => _fruitDetailBloc,
              child: Stack(key: keyStack, fit: StackFit.expand, children: <Widget>[
                AnimatedPositioned(
                  child: Container(
                    width: widthScreen,
                    color: AppColors.texas_rose,
                    child: FruitDetailBannerWidget(
                        fruitItem: fruitItem,
                        imageSize: imageSize,
                        imageMaxSize: imageMaxSize,
                        imageMinSize: imageMinSize,
                        isLongPressed: isLongPressed),
                  ),
                  top: 0,
                  left: 0,
                  bottom: posYPageView.toDouble(),
                  duration:
                      isLongPressed ? Duration(seconds: 0) : Duration(milliseconds: 150),
                  onEnd: () {
                    calculateImageSize();
                  },
                ),
                AnimatedPositioned(
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
                        color: isLongPressed ? Colors.blue[50] : Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: FruitDetailDescriptionWidget(
                        fruitItem: fruitItem,
                      ),
                    ),
                  ),
                  top: posYContainer.toDouble(),
                  curve: Curves.elasticOut,
                  duration:
                      isLongPressed ? Duration(seconds: 0) : Duration(milliseconds: 500),
                )
              ]),
            )),
          ],
        ),
      ),
    );
  }
}
