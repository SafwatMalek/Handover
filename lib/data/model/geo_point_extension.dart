import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map_location;

extension LatLngParser on GeoPoint {
  map_location.LatLng toLatLng() {
    return map_location.LatLng(latitude, longitude);
  }
}
