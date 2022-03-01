import 'dart:convert';

import 'package:location/location.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';

Future<void> getLocation(var fetch, Coordinate coordinate) async {
  Location location = new Location();

  //print("Entered getLocation");

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();

  // save coordinates to data store Provider
  coordinate.latitude = _locationData.latitude!;
  coordinate.longitude = _locationData.longitude!;


  print("getLocation: " +
      coordinate.latitude.toString() +
      ', ' +
      coordinate.longitude.toString());

  fetch(_locationData.latitude!, _locationData.longitude!);
}
