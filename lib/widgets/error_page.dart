import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/services/error_services.dart';

class ErrorPage extends StatelessWidget {
  ErrorException error;
  var refresh_; //function to refresh page
  WidgetRef ref;

  ErrorPage(
      {required this.error, required this.refresh_, required this.ref});

  // LEARN HOW TO CENTER ERROR WIDGET1
  @override
  Widget build(BuildContext context) {
    return Center(
        //heightFactor: double.infinity,
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            error.name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            error.message,
                            style: TextStyle(fontSize: 16),
                          )),
                      const Icon(
                        Icons.public_off_rounded,
                        size: 150,
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            error.suggestion,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CupertinoButton(
                            child: const Text("refresh"),
                            // maybe dont need arrow function
                            onPressed: () => refresh_(ref, (String m) => print(m))),
                      )
                    ]))));
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