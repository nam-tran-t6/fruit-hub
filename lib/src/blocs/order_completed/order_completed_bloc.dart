import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fruit_hub/src/blocs/order_completed/order_completed_event.dart';
import 'package:flutter_fruit_hub/src/screens/home_screen.dart';
import 'package:flutter_fruit_hub/src/screens/track_order_screen.dart';

class OrderCompletedCubit extends Cubit<OrderCompletedEvent> {
  OrderCompletedCubit() : super(OrderCompletedEventInit());

  void onPressedContinueShoppingButton(BuildContext context) {
    Navigator.popUntil(
      context,
      ModalRoute.withName(HomeScreen.TAG),
    );
  }

  void onPressedTrackOrderButton(BuildContext context) {
    Navigator.pushNamed(context, TrackOrderScreen.TAG);
  }
}
