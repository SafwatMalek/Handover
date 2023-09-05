import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  String orderId;
  String name;
  GeoPoint currentLocation;

  Driver(
      {required this.orderId,
      required this.name,
      required this.currentLocation});

  Map<String, dynamic> toMap() {
    return {
      'current_order': orderId,
      'driver_name': name,
      'location': currentLocation,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      orderId: map['current_order'],
      name: map['driver_name'],
      currentLocation: map['location'],
    );
  }

  @override
  String toString() {
    return 'Driver{orderId: $orderId, name: $name, currentLocation: $currentLocation}';
  }
}
