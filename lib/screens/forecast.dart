import 'dart:convert'; //json
import 'package:flutter/material.dart';
import 'package:mobile_weather_app/functions/forecast_aid.dart';
import 'package:mobile_weather_app/functions/get_api_key.dart';
import 'package:mobile_weather_app/functions/get_location.dart';
import 'package:http/http.dart' as http;

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreen();
}

class _WeatherForecastScreen extends State<WeatherForecastScreen> {
  List? tododata;

  @override
  void initState() {
    super.initState();
    //print("forecast init state " + coordinates.latitude.toString());
    fetchWeatherForecast(13, 100); //temp values
    // below is the correct call but

    //getLocation(fetchWeatherForecast, coordinates);
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Forecast'),
        ),
        body: tododata != null
            ? RefreshIndicator(
                onRefresh: () => getLocation(fetchWeatherForecast),
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: tododata!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.amber[
                          ((tododata!.length - 1 - index) * 100).round()],
                      child: Center(
                          child: Text(forecastDay(index) +
                              ', ' +
                              (tododata![index]["feels_like"]["day"] - 273.15)
                                  .round()
                                  .toString() +
                              '°C ' +
                              tododata![index]["weather"][0]["description"])),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ))
            : const Center(
                child: CircularProgressIndicator())); //loading forecast data
  }
}
