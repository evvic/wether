import 'package:mobile_weather_app/model/forecast_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// command to build generated freezed file
// flutter pub run build_runner build
part 'forecast_state.freezed.dart';

@freezed
abstract class ForecastState with _$ForecastState {
  const factory ForecastState() = Initial;
  const factory ForecastState.loading() = Loading;
  const factory ForecastState.loaded(List<ForecastData> forecastData) =
      ForecastData;
  const factory ForecastState.error({required String message}) = Error;
}
