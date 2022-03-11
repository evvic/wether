import 'dart:convert'; //json
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';
import 'package:mobile_weather_app/services/get_api_key.dart';
import 'package:mobile_weather_app/services/location_services.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/providers/forecast_provider.dart';
import 'package:mobile_weather_app/widgets/forecast_data.dart';
import 'package:mobile_weather_app/widgets/forecast_error.dart';

class WeatherForecastScreen extends ConsumerStatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  _WeatherForecastScreen createState() => _WeatherForecastScreen();
}

class _WeatherForecastScreen extends ConsumerState<WeatherForecastScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(coordinateNotifier);

    //print("forecast init state: " + forecast_container.read(coordinateNotifier).latitude.toString());
    //fetchWeatherForecast(13, 100); //temp values
    // below is the correct call but

    //getLocation(fetchWeatherForecast, container.read(coordinateNotifier));
  }

  fetchWeatherForecast(double lat, double long) async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=10&appid=${get_api_key()}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // good response

      var weatherData = json.decode(response.body);

      /*
      setState(() {
        tododata = weatherData["list"];
      });
      */

      //updateGUI(); // set state
    }
  }

  // to refresh data
  _refresh(WidgetRef ref) async {
    try {
      ref.refresh(forecastProvider);
      return await ref.read(forecastProvider.future);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  // ignore: dead_code, dead_code
  Widget build(BuildContext context) {
    //final coordinate = ref.watch(coordinateNotifier);

    final config = ref.watch(forecastProvider);
    //final data1 = config.asData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forecast"),
      ),
      body: RefreshIndicator(
          //color: const Color.fromRGBO(100, 100, 100, 100),
          onRefresh: () => _refresh(ref),
          child: Center(
            child: config.when(
                data: (data) => ForecastData(data: data, ref: ref),
                error: (err, stack) => ForecastError(message: err.toString(), refresh_: _refresh, ref: ref),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )),
    );

    //loading forecast data
  }
}
