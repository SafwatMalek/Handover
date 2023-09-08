import 'package:geodesy/geodesy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map_location;

extension LatLngParser on map_location.LatLng {
  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}
