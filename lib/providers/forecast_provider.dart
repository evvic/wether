import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForecastProvider extends ChangeNotifier {
  List? forecast;

  set setData(var data) {
    forecast = data;
    notifyListeners();
  }
}

// instantiate the provider class
final forecastNotifier = ChangeNotifierProvider<ForecastProvider>((ref) {
  return ForecastProvider();
});


