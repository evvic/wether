import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/application/freezed/weather_state.dart';
import 'package:mobile_weather_app/model/weather.dart';
import 'package:mobile_weather_app/utils/weather_client.dart';

class WeatherNotifier extends StateNotifier<WeatherState> {
  final WeatherClient _weatherClient;

  WeatherNotifier(this._weatherClient) : super(WeatherState());

  Future<void> getWeatherInfo() async {
    try {
      state = const WeatherState.loading();
      final weatherInfo = await _weatherClient.fetchWeatherInfo();
      state = WeatherState.loaded(weatherInfo!);
    } catch (e) {
      state = const WeatherState.error(message: 'Error fetching weather info');
    }
  }
}