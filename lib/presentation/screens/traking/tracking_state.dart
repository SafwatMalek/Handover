part of 'tracking_bloc.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class LoadingState extends TrackingState {}

class InitialMapState extends TrackingState {
  OrderModel orderModel;
  Set<Marker> markers;

  InitialMapState({
    required this.orderModel,
    required this.markers,
  });
}

class ErrorState extends TrackingState {}
