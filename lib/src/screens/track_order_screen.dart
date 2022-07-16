import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/track_order/track_order_bloc.dart';
import 'package:flutter_fruit_hub/src/constants/app_constants.dart';
import 'package:flutter_fruit_hub/src/constants/enum/track_order_status.dart';
import 'package:flutter_fruit_hub/src/constants/strings.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_colors.dart';
import 'package:flutter_fruit_hub/src/helpers/styles/app_text_styles.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_animation_path.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_images_path.dart';
import 'package:flutter_fruit_hub/src/helpers/utils/app_ratio.dart';
import 'package:flutter_fruit_hub/src/widgets/app_bar_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/app_google_map_widget.dart';
import 'package:flutter_fruit_hub/src/widgets/dashed_line_vertical_painter.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackOrderScreen extends StatefulWidget {
  static const String TAG = 'track_order_screen';

  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  TrackOrderBloc _trackOrderBloc = TrackOrderBloc();

  int currentStage = TRACK_ORDER_STAGE_ORDER_TAKEN;

  late TrackOrderStatus orderTakenStatus,
      orderPreparedStatus,
      orderDeliveredStatus,
      orderReceivedStatus;

  late Widget completeAnimation;
  late AppGoogleMapWidget? _mapWidget;

  @override
  void initState() {
    super.initState();
    completeAnimation = Lottie.asset(AppAnimationPath.lottie_complete,
        width: 32, height: 32, fit: BoxFit.fill, repeat: false, frameRate: FrameRate.max);

    orderTakenStatus = TrackOrderStatus.waiting;
    orderPreparedStatus = TrackOrderStatus.waiting;
    orderDeliveredStatus = TrackOrderStatus.waiting;
    orderReceivedStatus = TrackOrderStatus.waiting;

    _trackOrderBloc.add(TrackOrderReceivedOrder());
  }

  @override
  Widget build(BuildContext context) {
    _mapWidget = AppGoogleMapWidget();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppBarWidget(
              actionBackPress: () => Navigator.pop(context),
              title: Strings.delivery_status,
            ),
            Expanded(
              child: BlocProvider(
                create: (context) => _trackOrderBloc,
                child: _buildTrackOrderBodyWidget(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackOrderBodyWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        top: 40,
        right: 24,
      ),
      child: BlocBuilder<TrackOrderBloc, TrackOrderState>(
        builder: (context, state) {
          if (state is TrackOrderProcessOrder) {
            currentStage = state.trackOrderStage;
            if (currentStage == TRACK_ORDER_STAGE_ORDER_DELIVERED) {
              _mapWidget?.startShipper();
            }
            _handleStage(currentStage);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderStatusItemWidget(
                  AppImagePath.order_taken, Strings.order_taken, orderTakenStatus),
              Padding(
                padding: EdgeInsets.only(
                  left: 32,
                ),
                child: CustomPaint(
                  size: Size(1, 48),
                  painter: DashedLineVerticalPainter(
                    lineColors: AppColors.texas_rose,
                    dashSpace: 5,
                  ),
                ),
              ),
              _buildOrderStatusItemWidget(AppImagePath.order_is_being_prepared,
                  Strings.order_is_being_prepared, orderPreparedStatus),
              Padding(
                padding: EdgeInsets.only(
                  left: 32,
                ),
                child: CustomPaint(
                  size: Size(
                    1,
                    48,
                  ),
                  painter: DashedLineVerticalPainter(
                    lineColors: AppColors.texas_rose,
                    dashSpace: 5,
                  ),
                ),
              ),
              _buildOrderIsBeingDeliveredWidget(
                AppImagePath.order_is_being_delivered,
                Strings.order_is_being_delivered,
                Strings.your_delivery_agent_is_coming,
                orderDeliveredStatus,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 32,
                ),
                child: CustomPaint(
                  size: Size(
                    1,
                    48,
                  ),
                  painter: DashedLineVerticalPainter(
                    lineColors: AppColors.texas_rose,
                    dashSpace: 5,
                  ),
                ),
              ),
              _buildOrderStatusItemWidget(
                AppImagePath.order_received,
                Strings.order_received,
                orderReceivedStatus,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderStatusItemWidget(String stepImage, String title, var status) {
    return Row(
      children: [
        Image.asset(
          stepImage,
          width: 64,
          height: 64,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(title, style: AppTextStyles.kBoldBlack16),
        ),
        (status == TrackOrderStatus.complete)
            ? completeAnimation
            : (status == TrackOrderStatus.waiting)
                ? Lottie.asset(
                    AppAnimationPath.lottie_waiting,
                    width: 32,
                    height: 32,
                    fit: BoxFit.fill,
                    repeat: true,
                    frameRate: FrameRate.max,
                  )
                : Lottie.asset(
                    AppAnimationPath.lottie_processing,
                    width: 32,
                    height: 32,
                    fit: BoxFit.fill,
                    repeat: true,
                    frameRate: FrameRate.max,
                  )
      ],
    );
  }

  Widget _buildOrderIsBeingDeliveredWidget(
      String stepImage, String title, String subtitle, var status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Image.asset(
              stepImage,
              width: 64,
              height: 64,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.kBoldBlack16,
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyles.kBoldBlack16,
                  )
                ],
              ),
            ),
            (status == TrackOrderStatus.complete)
                ? completeAnimation
                : (status == TrackOrderStatus.waiting)
                    ? Lottie.asset(
                        AppAnimationPath.lottie_waiting,
                        width: 32,
                        height: 32,
                        fit: BoxFit.fill,
                        repeat: true,
                      )
                    : GestureDetector(
                        onTap: () {
                          _makePhoneCall('tel:${Strings.sample_phone_number}');
                        },
                        child: Lottie.asset(AppAnimationPath.lottie_call,
                            width: 64,
                            height: 64,
                            alignment: Alignment.centerRight,
                            repeat: true),
                      )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 32),
          child: CustomPaint(
            size: Size(
              1,
              26,
            ),
            painter: DashedLineVerticalPainter(
              lineColors: AppColors.texas_rose,
              dashSpace: 5,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 210,
            child: _mapWidget,
          ),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _handleStage(int stage) {
    switch (stage) {
      case TRACK_ORDER_STAGE_ORDER_TAKEN:
        _changeState(TrackOrderStatus.processing, TrackOrderStatus.waiting,
            TrackOrderStatus.waiting, TrackOrderStatus.waiting);
        break;
      case TRACK_ORDER_STAGE_ORDER_PREPARED:
        _changeState(TrackOrderStatus.complete, TrackOrderStatus.processing,
            TrackOrderStatus.waiting, TrackOrderStatus.waiting);
        break;
      case TRACK_ORDER_STAGE_ORDER_DELIVERED:
        _changeState(TrackOrderStatus.complete, TrackOrderStatus.complete,
            TrackOrderStatus.processing, TrackOrderStatus.waiting);
        break;
      case TRACK_ORDER_STAGE_ORDER_RECEIVED:
        _changeState(TrackOrderStatus.complete, TrackOrderStatus.complete,
            TrackOrderStatus.complete, TrackOrderStatus.processing);
        break;
      case TRACK_ORDER_STAGE_ORDER_COMPLETE:
        _changeState(TrackOrderStatus.complete, TrackOrderStatus.complete,
            TrackOrderStatus.complete, TrackOrderStatus.complete);
        break;
    }
  }

  void _changeState(
      TrackOrderStatus orderTakenStatus,
      TrackOrderStatus orderPreparedStatus,
      TrackOrderStatus orderDeliveredStatus,
      TrackOrderStatus orderReceivedStatus) {
    this.orderTakenStatus = orderTakenStatus;
    this.orderPreparedStatus = orderPreparedStatus;
    this.orderDeliveredStatus = orderDeliveredStatus;
    this.orderReceivedStatus = orderReceivedStatus;
  }
}
