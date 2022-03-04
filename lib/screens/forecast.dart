import 'dart:convert'; //json
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/functions/forecast_aid.dart';
import 'package:mobile_weather_app/functions/get_api_key.dart';
import 'package:mobile_weather_app/functions/get_location.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/main.dart';
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/providers/forecast_provider.dart';

class WeatherForecastScreen extends ConsumerStatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  _WeatherForecastScreen createState() => _WeatherForecastScreen();
}

class _WeatherForecastScreen extends ConsumerState<WeatherForecastScreen> {
  List? tododata;

  @override
  void initState() {
    super.initState();

    ref.read(coordinateNotifier);

    //print("forecast init state: " + forecast_container.read(coordinateNotifier).latitude.toString());
    //fetchWeatherForecast(13, 100); //temp values
    // below is the correct call but

    getLocation(fetchWeatherForecast, container.read(coordinateNotifier));
  }


  fetchWeatherForecast(double lat, double long) async {
    Uri url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$long&cnt=10&appid=${get_api_key()}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // good response

      var weatherData = json.decode(response.body);

      setState(() {
        tododata = weatherData["list"];
      });

      //updateGUI(); // set state
    }
  }

  @override
  // ignore: dead_code, dead_code
  Widget build(BuildContext context) {
    //final coordinate = ref.watch(coordinateNotifier);


    AsyncValue<List<ForecastProvider>> config = ref.watch(forecastProvider);

    return config.when(
      loading: () => const Center(child: CircularProgressIndicator()),

      error: (err, stack) => Text('Error: $err'),

      data: (forecastProvider) {
        return Scaffold(
        appBar: AppBar(
          title: const Text('Forecast'),
        ),
        body:
          ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: forecastProvider.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                color: Colors.amber[
                    ((forecastProvider.length - 1 - index) * 100).round()],
                child:
                  Center(
                    child: Text(forecastDay(index) + ', ' +
                      forecastProvider[index].celsius.toString() + '°C ' +
                      forecastProvider[index].description
                      ),
                  )
                /*Center(
                    child: Text(forecastDay(index) +
                        ', ' +
                        (forecastProvider![index]["feels_like"]["day"] - 273.15)
                            .round()
                            .toString() +
                        '°C ' +
                        forecastProvider![index]["weather"][0]["description"]
                        + ', ' + container.read(coordinateNotifier).latitude.toString())), */
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ));

      },
    );

    //loading forecast data
  }
}
