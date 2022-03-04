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

    //getLocation(fetchWeatherForecast, container.read(coordinateNotifier));
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

    final config = ref.watch(forecastProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Forecast"),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            ref.refresh(forecastProvider);
            await ref.read(forecastProvider.future);
          },
          child: Center(
            child: config.when(
                data: (data) => (ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(forecastDay(index) +
                                    ', ' +
                                    data[index].description),
                                subtitle: Text(data[index].celsius.toString() +
                                    '°C '),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    )),
                error: (err, stack) => Text('Error: $err'),
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          )),
    );



    //loading forecast data
  }
}
