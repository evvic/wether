import 'package:mobx/mobx.dart';

part 'coordinates.g.dart';

class Coordinates = _Coordinates with _$Coordinates;

abstract class _Coordinates with Store {
  @observable
  double latitude = 0.0;

  @observable
  double longitude = 0.0;

  set setLatitude(double lat) {
    latitude = lat;
  }

  set setLongitude(double lon) {
    longitude = lon;
  }
}