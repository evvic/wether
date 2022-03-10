// Notfier Provider (version)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/application/notifier/weather_notifier.dart';
import 'package:mobile_weather_app/utils/weather_client.dart';

final weatherClientProvider = Provider<WeatherClient>((ref) => WeatherClient());

final weatherNotifierProvider = StateNotifierProvider(
  (ref) => WeatherNotifier(ref.watch(weatherClientProvider)),
  
);