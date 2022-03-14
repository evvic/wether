import 'dart:core';
import 'package:wether/main.dart'; // coordinate provider (container)
import 'package:location/location.dart';
import 'package:wether/providers/coordinate_provider.dart';

// getLocationData()
// checks for gps service to be enabled and user permission granted
// returns raw location data
// returns null if data could not be achieved
Future<LocationData?> getLocationData() async {
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  _locationData = await location.getLocation();

  return _locationData;
}

// updateCoordinates()
// updates the coordinates to the data store Provider
// returns true if successful
bool updateCoordinates(LocationData data) {
  try {
    container.read(coordinateNotifier).latitude = data.latitude!;
    container.read(coordinateNotifier).longitude = data.longitude!;
  } catch (e) {
    print("unsucessfully updated coordinates");
    return false;
  }

  return true;
}

// getLocation(CALLBACK_fUNC)
//
Future<void> getLocation(var fetch) async {
  LocationData? _locationData = await getLocationData();

  // null checker
  if (_locationData != null) {
    // save coordinates to data store Provider
    updateCoordinates(_locationData);

    print("getLocation: " +
        container.read(coordinateNotifier).latitude.toString() +
        ', ' +
        container.read(coordinateNotifier).longitude.toString());

    fetch(_locationData.latitude!, _locationData.longitude!);
  }
}

bool saveLocation(String loc) {
  try {
    container.read(coordinateNotifier).location = loc;
    return true;
  } catch (e) {
    return false;
  }
}
