import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';

class WeatherData extends StatelessWidget {
  var data;
  WidgetRef ref;

  WeatherData({required this.data, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        // pull to refresh
        // https://evanfang.medium.com/how-to-make-your-scrollview-support-pull-to-refresh-864f1b0a02e2
        return Text("expand on data");
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(),
    );
  }
}

//
/*
RefreshIndicator(
  onRefresh: () =>
      getLocation(fetchWeather),
  child: SingleChildScrollView(
      child: Column(
    // evenly space all children vertically on the one screen
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // city name //
      Text(weather_data["name"]),
      // short weather desc //
      Text(weather_data['weather'][0]['description'],
          style: TextStyle(fontSize: 40)),
      // icon loaded //
      Image.network(
        'https://openweathermap.org/img/wn/${weather_data['weather'][0]['icon']}.png',
        scale: 0.8,
      ),
      // temperature (celcius) //
      Text(
          (weather_data['main']['temp'] - 273.15)
                  .toStringAsFixed(2) +
              " C",
          style: TextStyle(fontSize: 40)),
      // wind speed m/s //
      Text("${weather_data['wind']['speed']} m/s",
          style: TextStyle(fontSize: 40)),
      // lat & long //
      Text(container.read(coordinateNotifier).latitude.toString()),
      ElevatedButton(
        child: const Text('Get location'),
        onPressed: () {
          // fetch data from internet
          getLocation(
              fetchWeather); //no arrow function needed here
          print("Enter onPressed");
        },
      ),
      ElevatedButton(
        child: const Text('Forecast'),
        onPressed: () {
          // Navigate to second route when tapped.
          Navigator.push(
              context,
              // class we use to change to another page
              MaterialPageRoute(
                  builder: (context) => WeatherForecastScreen()));
        },
      ),
    ],
  ))),
              */
