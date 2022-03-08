import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/providers/weather_provider.dart';

class WeatherPageInitial extends StatelessWidget {
  final TextEditingController _userIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _userIdController,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // REFACTOR THIS TO CALL getWeatherInfo
              context

                  .read(weatherNotifierProvider)
                  .getWeatherInfo();
            },
            child: Text('Get user info'),
          ),
        ],
      ),
    );
  }
}