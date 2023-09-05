import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  GeoPoint deliveryPoint;
  GeoPoint pickUpPoint;
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
      'Delivery_locaiton': deliveryPoint,
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
      deliveryPoint: map?['Delivery_locaiton'],
      pickUpPoint: map?['pickup_location'],
      driverId: map?['driver_id'],
      rate: map?['rate'],
      review: map?['review'],
      status: map?['status'],
      userId: map?['user_id'],
      orderId: map?['order_id']
    );
  }

  @override
  String toString() {
    return 'Order{deliveryPoint: $deliveryPoint, pickUpPoint: $pickUpPoint, driverId: $driverId, rate: $rate, review: $review, status: $status, userId: $userId}, orderID:$orderId';
  }
}
