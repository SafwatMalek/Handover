part of 'tracking_bloc.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class LoadingState extends TrackingState {}

class UpdateMapMarkers extends TrackingState {
  OrderModel orderModel;
  Set<Marker> markers;

  UpdateMapMarkers({
    required this.orderModel,
    required this.markers,
  });
}

class ErrorState extends TrackingState {}
