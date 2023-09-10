part of 'tracking_bloc.dart';

abstract class TrackingState {}

class TrackingInitial extends TrackingState {}

class LoadingState extends TrackingState {}

class StartTracking extends TrackingState {}

class ErrorState extends TrackingState {}
