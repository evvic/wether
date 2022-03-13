import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherError extends StatelessWidget {
  final String message;
  var refresh_; //function to refresh page
  WidgetRef ref;

  WeatherError({required this.message, required this.refresh_, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        children: <Widget> [
          const Icon(Icons.public_off_rounded,
            size: 64,),
          Padding(
              padding: EdgeInsets.all(20),
            child: Text('Error: $message',
            style: TextStyle(fontSize: 18),)),
          CupertinoButton(
            child: const Text("refresh"),
            // maybe dont need arrow function
            onPressed: () => refresh_(ref))
        ]
      )
    );
  }
}



// original error handling
/*
(Center(
  child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      Text(error_code!),
      ElevatedButton(
        child: const Text('Get location'),
        onPressed: () {
          // fetch data from internet
          getLocation(fetchWeather); //no arrow function needed here
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
    ]))))
*/