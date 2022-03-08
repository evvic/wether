import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_weather_app/model/weather.dart';

// command to build generated freezed file
// flutter pub run build_runner build
part 'weather_state.freezed.dart';

@freezed
abstract class WeatherState with _$WeatherState {
  const factory WeatherState() = Initial;
  const factory WeatherState.loading() = Loading;
  const factory WeatherState.loaded(Weather weatherData) =
      WeatherData;
  const factory WeatherState.error({required String message}) = Error;
}
