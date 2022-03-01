import 'dart:convert';

import 'package:location/location.dart';

Future<void> getLocation(var fetch) async {
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

  // save coordinates to data store
  //coordinates.latitude = _locationData.latitude!;
  //coordinates.longitude = _locationData.longitude!;

  fetch(_locationData.latitude!, _locationData.longitude!);
}
