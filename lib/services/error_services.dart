import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ErrorException {
  late String name;
  late String message;
  late String suggestion;
  late IconData icon;
}

ErrorException errorNameToClass(String name) {
  print("errorNameToClass: " + name);

  if (name == "SocketException")
    return SocketException();
  else if (name == "TimeoutException")
    return TimeoutException();
  else if (name == "LocationAccess")
    return LocationAccess();
  else if (name == "BadResponse")
    return BadResponse();
  else
    return UntrackedException();
}

// DEFAULT ERROR EXCEPTION
class UntrackedException extends ErrorException {
  @override
  String get name => "UntrackedException";

  @override
  String get message => "Error fetching data";

  @override
  String get suggestion => "Try checking connection and refreshing";

  @override
  IconData get icon => Icons.public_off_rounded;
}

class SocketException extends ErrorException {
  @override
  String get name => "SocketException";

  @override
  String get message => "Cannot connect to internet";

  @override
  String get suggestion => "Try checking your internet connection";

  @override
  IconData get icon => Icons.public_off_rounded;
}

class TimeoutException extends ErrorException {
  @override
  String get name => "TimeoutException";

  @override
  String get message => "Timed out when connecting to the API";

  @override
  String get suggestion => "Try checking your internet connection";

  @override
  IconData get icon => Icons.cloud_off_rounded;
}

class LocationAccess extends ErrorException {
  @override
  String get name => "LocationAccess";

  @override
  String get message => "Failed retrieving the devices location coordinates";

  @override
  String get suggestion => "Try refreshing and giving location permision";

  @override
  IconData get icon => Icons.location_disabled_rounded;
}

class BadResponse extends ErrorException {
  @override
  String get name => "BadResponse";

  @override
  String get message => "Retrieved a bad response from the API";

  @override
  String get suggestion => "Try refreshing and giving location permision";

  @override
  IconData get icon => Icons.cloud_off_rounded;
}
