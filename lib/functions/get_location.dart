import 'dart:convert';
//import 'dart:html';

import 'package:location/location.dart'; // JSON converters

Future<void> getLocation(var fetch) async {
  Location location = new Location();

  print("Entered getLocation");

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      //return false;
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      //return false;
      return;
    }
  }

  _locationData = await location.getLocation();

  fetch(_locationData.latitude!, _locationData.longitude!);

  //return true;
}
