import 'dart:convert'; //json
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/model/forecast_day.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';
import 'package:mobile_weather_app/services/get_api_key.dart';
import 'package:mobile_weather_app/services/location_services.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_weather_app/providers/coordinate_provider.dart';
import 'package:mobile_weather_app/providers/forecast_provider.dart';
import 'package:mobile_weather_app/widgets/appbar.dart';
import 'package:mobile_weather_app/widgets/forecast_loaded.dart';
import 'package:mobile_weather_app/widgets/forecast_error.dart';

class WeatherForecastScreen extends ConsumerStatefulWidget {
  const WeatherForecastScreen({Key? key}) : super(key: key);

  @override
  _WeatherForecastScreen createState() => _WeatherForecastScreen();
}

class _WeatherForecastScreen extends ConsumerState<WeatherForecastScreen> {
  List<ForecastDayData>? savedData;

  @override
  void initState() {
    super.initState();

    ref.read(coordinateNotifier);

    //print("forecast init state: " + forecast_container.read(coordinateNotifier).latitude.toString());
    //fetchWeatherForecast(13, 100); //temp values
    // below is the correct call but

    //getLocation(fetchWeatherForecast, container.read(coordinateNotifier));
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

  copySave(var w) {
    try {
      setState(() {
        savedData = w;
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  // ignore: dead_code, dead_code
  Widget build(BuildContext context) {
    //final coordinate = ref.watch(coordinateNotifier);

    final config = ref.watch(forecastProvider);
    //final data1 = config.asData;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarUni(context, inForecast: true),
      body: RefreshIndicator(
        displacement: 150,
        color: const Color.fromRGBO(100, 100, 100, 100),
        onRefresh: () => _refresh(ref),
        child: Padding(
            padding: const EdgeInsets.only(top: 1), //(top: 100.0),
            child: Center(
              child: config.when(
                  data: (data) => ForecastLoaded(data: data, ref: ref, saved: copySave(data)),
                  error: (err, stack) => ForecastError(
                      message: err.toString(), refresh_: _refresh, ref: ref),
                  loading: () =>
                    (savedData == null)?
                      const Center(child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),)
                      ) :
                      ForecastLoaded(data: savedData!, ref: ref, saved: false)
                ),
            )
          )
        ),
    );

    //loading forecast data
  }
}
