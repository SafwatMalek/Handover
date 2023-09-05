part of 'tracking_bloc.dart';

abstract class TrackingEvent {}

class InitializeMap extends TrackingEvent {}

class StartTracking extends TrackingEvent {
  String orderId;

  StartTracking({
    required this.orderId,
  });
}

class NearToDeliveryPoint extends TrackingEvent {}

class NearToPickupPoint extends TrackingEvent {}

class TrackingComplete extends TrackingEvent {}

class UpdateMapEvent extends TrackingEvent {
  OrderModel orderModel;
  Set<Marker> markers;

  UpdateMapEvent({
    required this.orderModel,
    required this.markers,
  });
}
