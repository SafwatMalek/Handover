import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/data/model/order/order_model.dart';
import 'package:handover/data/notification/local_notification.dart';
import 'package:handover/data/repository/driver_repository_imp.dart';
import 'package:handover/data/repository/order_repository_imp.dart';
import 'package:handover/domain/use_case/driver/driver_location_use_case.dart';
import 'package:handover/domain/use_case/driver/driver_location_use_case_imp.dart';
import 'package:handover/domain/use_case/order/order_data_use_case.dart';
import 'package:handover/domain/use_case/order/order_data_use_case_imp.dart';

part 'tracking_event.dart';

part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final DriverLocationUseCase _driverUseCase =
      DriverLocationUseCaseImp(DriverRepoImp());
  final OrderDataUseCase _orderUseCase = OrderDataUseCaseImp(OrderRepoImp());
  StreamSubscription? _driverStream;

  TrackingBloc() : super(TrackingInitial()) {
    on<InitializeMap>(initializeMapHandler);
    on<TrackingComplete>(onDispose);
    on<UpdateMapEvent>((event, emit) => emit(UpdateMapMarkers(
        orderModel: event.orderModel, markers: event.markers)));
  }

  initializeMapHandler(TrackingEvent event, Emitter<TrackingState> emit) async {
    emit(LoadingState());
    var order = await _orderUseCase.execute("567");
    _driverStream = _driverUseCase.execute(order.orderId).listen((event) {
      var driver = event.docs.first.data();

      Set<Marker> markers = {
        _addMarkers("driver", driver.location),
        _addMarkers("pickup", order.pickUpPoint),
        _addMarkers("delivery", order.deliveryPoint)
      };
      add(UpdateMapEvent(orderModel: order, markers: markers));
    });
  }

  _addMarkers(String id, LatLng position) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: position,
    );
    return marker;
  }

  // _isDriverCloser(GeoDes.LatLng driver, GeoDes.LatLng target, num area) {
  //   final geodesy = GeoDes.Geodesy();
  //   final des = geodesy.distanceBetweenTwoGeoPoints(driver, target);
  //   return des <= area;
  // }

  _sendNotification(title, body) async {
    var localNotification = LocalNotification();
    localNotification.showNotification(title, body);
  }

  onDispose(TrackingEvent event, Emitter<TrackingState> emitter) async {
    _driverStream?.cancel();
  }
}
