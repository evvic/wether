import 'dart:convert'; //json
import 'package:flutter/material.dart';
import 'package:mobile_weather_app/functions/get_api_key.dart';
import 'package:mobile_weather_app/functions/get_location.dart';
import 'package:http/http.dart' as http;

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreen();
}

class _WeatherForecastScreen extends State<WeatherForecastScreen> {
  final List<String> entries = <String>['A', 'B', 'C'];
  List? tododata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWeatherForecast(13.0, 100.0); //temp values
  }

  fetchWeatherForecast(double lat, double long) async {
    //city = "Sacramento";

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

  String forecastDay(int ind) {
    String dayName = "";

    var date = DateTime.now();

    if (ind == 0) {
      dayName = "Today";
    } else if (ind == 1) {
      dayName = "Tomorrow";
    } else {
      date.weekday; //1-7
      switch ((date.weekday - 1 + ind) % 7) {
        case 0:
          {
            dayName = "Monday";
            break;
          }
        case 1:
          {
            dayName = "Tuesday";
            break;
          }
        case 2:
          {
            dayName = "Wednesday";
            break;
          }
        case 3:
          {
            dayName = "Thursday";
            break;
          }
        case 4:
          {
            dayName = "Friday";
            break;
          }
        case 5:
          {
            dayName = "Saturday";
            break;
          }
        case 6:
          {
            dayName = "Sunday";
            break;
          }
        default:
          {
            dayName = "ERROR";
          }
      }
    }
    return dayName;
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
