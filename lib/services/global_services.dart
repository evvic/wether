// to refresh data
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/providers/forecast_provider.dart';

_refresh(WidgetRef ref) async {
    try {
      ref.refresh(forecastProvider);
      return await ref.read(forecastProvider.future);
    } catch (e) {
      print(e.toString());
    }
  }