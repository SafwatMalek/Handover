import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map_location;
import 'package:handover/data/model/geo_point_extension.dart';

class Driver {
  String orderId;
  String name;
  map_location.LatLng location;

  Driver({required this.orderId, required this.name, required this.location});

  Map<String, dynamic> toMap() {
    return {
      'current_order': orderId,
      'driver_name': name,
      'location': location,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      orderId: map['current_order'],
      name: map['driver_name'],
      location: (map['location'] as GeoPoint).toLatLng(),
    );
  }

  @override
  String toString() {
    return 'Driver{orderId: $orderId, name: $name, currentLocation: $location}';
  }
}
