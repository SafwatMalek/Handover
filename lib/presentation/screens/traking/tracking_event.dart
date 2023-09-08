part of 'tracking_bloc.dart';

abstract class TrackingEvent {}

class InitializeMap extends TrackingEvent {}

class UpdateMapEvent extends TrackingEvent {
  OrderModel orderModel;
  Set<Marker> markers;

  UpdateMapEvent({
    required this.orderModel,
    required this.markers,
  });
}

class UpdateOrderStatusEvent extends TrackingEvent {
  OrderModel orderModel;

  UpdateOrderStatusEvent({
    required this.orderModel,
  });
}

class TrackingComplete extends TrackingEvent {}
