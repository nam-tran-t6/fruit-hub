part of 'track_order_bloc.dart';

@immutable
abstract class TrackOrderState {}

class TrackOrderInitial extends TrackOrderState {}
class TrackOrderProcessOrder extends TrackOrderState{
  final int _trackOrderStage;
  TrackOrderProcessOrder(this._trackOrderStage);

  int get trackOrderStage => _trackOrderStage;
}
