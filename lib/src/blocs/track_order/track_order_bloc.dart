import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_fruit_hub/src/constants/app_constants.dart';
import 'package:flutter_fruit_hub/src/mixin/logger_service_mixin.dart';
import 'package:meta/meta.dart';

part 'track_order_event.dart';
part 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> with LoggerBlocMixin {
  TrackOrderBloc() : super(TrackOrderInitial());

  @override
  Stream<TrackOrderState> mapEventToState(
    TrackOrderEvent event,
  ) async* {
    switch (event.runtimeType) {
      case TrackOrderReceivedOrder:
        await Future.delayed(Duration(seconds: 3));
        yield TrackOrderProcessOrder(TRACK_ORDER_STAGE_ORDER_TAKEN);
        await Future.delayed(Duration(seconds: 3));
        yield TrackOrderProcessOrder(TRACK_ORDER_STAGE_ORDER_PREPARED);
        await Future.delayed(Duration(seconds: 3));
        yield TrackOrderProcessOrder(TRACK_ORDER_STAGE_ORDER_DELIVERED);
        await Future.delayed(Duration(seconds: 30));
        yield TrackOrderProcessOrder(TRACK_ORDER_STAGE_ORDER_RECEIVED);
        await Future.delayed(Duration(seconds: 3));
        yield TrackOrderProcessOrder(TRACK_ORDER_STAGE_ORDER_COMPLETE);
    }
  }
}
