import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Coordinate extends ChangeNotifier {
  double? latitude;
  double? longitude;
  String location = "Weather";

  set setLatitude(double lat) {
    latitude = lat;
    notifyListeners();
  }

  set setLongitude(double lon) {
    longitude = lon;
    notifyListeners();
  }

  set setLocation(String loc) {
    location = loc;
    notifyListeners();
  }
}

// instantiate the provider class
final coordinateNotifier = ChangeNotifierProvider<Coordinate>((ref) {
  return Coordinate();
});
