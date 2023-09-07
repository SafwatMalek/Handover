import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map_location;
import 'package:handover/data/model/geo_point_extension.dart';

class OrderModel {
  map_location.LatLng deliveryPoint;
  map_location.LatLng pickUpPoint;
  String driverId;
  String orderId;
  String rate;
  String review;
  String status;
  String userId;

  OrderModel(
      {required this.deliveryPoint,
      required this.pickUpPoint,
      required this.driverId,
      required this.rate,
      required this.review,
      required this.status,
      required this.userId,
      required this.orderId});

  Map<String, dynamic> toMap() {
    return {
      'delivery_location': deliveryPoint,
      'pickup_location': pickUpPoint,
      'driver_id': driverId,
      'order_id': orderId,
      'rate': rate,
      'review': review,
      'status': status,
      'user_id': userId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic>? map) {
    return OrderModel(
        deliveryPoint: (map?['delivery_location'] as GeoPoint).toLatLng(),
        pickUpPoint: (map?['pickup_location'] as GeoPoint).toLatLng(),
        driverId: map?['driver_id'],
        rate: map?['rate'],
        review: map?['review'],
        status: map?['status'],
        userId: map?['user_id'],
        orderId: map?['order_id']);
  }

  @override
  String toString() {
    return 'Order{deliveryPoint: $deliveryPoint, pickUpPoint: $pickUpPoint, driverId: $driverId, rate: $rate, review: $review, status: $status, userId: $userId}, orderID:$orderId';
  }
}
