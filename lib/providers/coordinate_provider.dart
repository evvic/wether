import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Coordinate extends ChangeNotifier {
  double latitude = 6.9;
  double longitude = 4.20;

  set setLatitude(double lat) {
    latitude = lat;
    notifyListeners();
  }

  set setLongitude(double lon) {
    longitude = lon;
    notifyListeners();
  }

}

// instantiate the provider class
final coordinateNotifier = ChangeNotifierProvider<Coordinate>((ref) {
  return Coordinate();
});
