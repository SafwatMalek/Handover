import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geodesy/geodesy.dart' as geo_distance;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handover/data/model/driver/driver_model.dart';
import 'package:handover/data/model/geo_distance_extension.dart';
import 'package:handover/data/model/order/order_model.dart';
import 'package:handover/data/model/order/order_status.dart';
import 'package:handover/data/notification/local_notification.dart';
import 'package:handover/data/repository/driver_repository_imp.dart';
import 'package:handover/data/repository/order_repository_imp.dart';
import 'package:handover/domain/use_case/driver/driver_location_use_case.dart';
import 'package:handover/domain/use_case/driver/driver_location_use_case_imp.dart';
import 'package:handover/domain/use_case/order/order_data_use_case.dart';
import 'package:handover/domain/use_case/order/order_data_use_case_imp.dart';
import 'package:handover/domain/use_case/order/update_order/update_order_use_case.dart';
import 'package:handover/domain/use_case/order/update_order/update_order_use_case_imp.dart';

part 'tracking_event.dart';

part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final DriverLocationUseCase _driverUseCase =
      DriverLocationUseCaseImp(DriverRepoImp());
  final OrderDataUseCase _orderUseCase = OrderDataUseCaseImp(OrderRepoImp());
  final UpdateOrderUseCase _updateOrder = UpdateOrderUseCaseImp(OrderRepoImp());
  StreamSubscription? _driverStream;

  TrackingBloc() : super(TrackingInitial()) {
    on<InitializeMap>(initializeMapHandler);
    on<TrackingComplete>(onDispose);
    on<UpdateMapEvent>((event, emit) => emit(UpdateMapMarkers(
          orderModel: event.orderModel,
          markers: event.markers,
        )));
  }

  initializeMapHandler(TrackingEvent event, Emitter<TrackingState> emit) async {
    emit(LoadingState());
    var order = await _orderUseCase.execute("567");
    _driverStream = _driverUseCase.execute(order.orderId).listen((event) async {
      var driver = event.docs.first.data();
      Set<Marker> markers = {
        await _addMarkers(
            "driver", driver.location, "assets/images/driver.png"),
        await _addMarkers(
            "pickup", order.pickUpPoint, "assets/images/pickup.png"),
        await _addMarkers(
            "delivery", order.deliveryPoint, "assets/images/delivery.png")
      };
      add(UpdateMapEvent(orderModel: order, markers: markers));
      _updateOrderStatus(order, driver);
    });
  }

  _addMarkers(String id, LatLng position, String imagePath) async {
    var marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), imagePath),
    );
    return marker;
  }

  _updateOrderStatus(OrderModel order, Driver driver) async {
    if (order.status == OrderStatus.onTheWay.value) {
      await _validateDeliveryPoint(
          order,
          driver,
          5000,
          "Please be ready, the order on the way for pickup",
          OrderStatus.readyToPickup);
    } else if (order.status == OrderStatus.readyToPickup.value) {
      await _validateDeliveryPoint(order, driver, 100,
          "Driver very closer, be ready for pickup", OrderStatus.pickedUp);
    } else if (order.status == OrderStatus.pickedUp.value) {
      order.status = OrderStatus.nearToDelivery.value;
      await _updateOrder.execute(order.orderId.toString(), order.status);
      add(UpdateOrderStatusEvent(orderModel: order));
    } else if (order.status == OrderStatus.nearToDelivery.value) {
      await _validateDeliveryPoint(
          order,
          driver,
          5000,
          "Driver very closer, be ready for received",
          OrderStatus.readyToDeliver);
    } else if (order.status == OrderStatus.readyToDeliver.value) {
      await _validateDeliveryPoint(order, driver, 100,
          "Driver very closer, be ready for received", OrderStatus.delivered);
    } else if (order.status == OrderStatus.delivered.value) {
      order.status = OrderStatus.delivered.value;
      await _updateOrder.execute(order.orderId.toString(), order.status);
      add(TrackingComplete());
    } else {
      throw Exception("unhandled order state");
    }
  }

  _validateDeliveryPoint(
    OrderModel order,
    Driver driver,
    int area,
    String message,
    OrderStatus nextStatus,
  ) async {
    var isDriverReady = _isNearTo(driver.location, order.pickUpPoint, area);
    if (isDriverReady) {
      _sendNotification("Handover", message);
      order.status = nextStatus.value;
      await _updateOrder.execute(order.orderId.toString(), order.status);
    }
  }

  _isNearTo(LatLng driver, LatLng target, num area) {
    final geodesy = geo_distance.Geodesy();
    final des = geodesy.distanceBetweenTwoGeoPoints(
      driver.toLatLng(),
      target.toLatLng(),
    );
    return des <= area;
  }

  _sendNotification(title, body) async {
    var localNotification = LocalNotification();
    localNotification.showNotification(title, body);
  }

  onDispose(TrackingEvent event, Emitter<TrackingState> emitter) async {
    _driverStream?.cancel();
    emitter(OrderCompleted());
  }
}
