import 'dart:convert'; //json
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wether/model/forecast_day.dart';
import 'package:wether/services/error_services.dart';
import 'package:wether/services/forecast_services.dart';
import 'package:wether/services/get_api_key.dart';
import 'package:wether/services/location_services.dart';
import 'package:http/http.dart' as http;
import 'package:wether/providers/coordinate_provider.dart';
import 'package:wether/providers/forecast_provider.dart';
import 'package:wether/widgets/appbar.dart';
import 'package:wether/widgets/forecast_loaded.dart';
import 'package:wether/widgets/error_page.dart';

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
  _refresh(WidgetRef ref, var fun) async {
    try {
      ref.refresh(forecastProvider);
      return await ref.read(forecastProvider.future);
    } catch (e) {
      fun("Error: " + errorNameToClass(e.toString()).suggestion);
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
            onRefresh: () => _refresh(
                ref,
                (error) => {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())))
                    }),
            child: Center(
              child: config.when(
                  // LOADED PAGE.
                  data: (data) => ForecastLoaded(
                      data: data, ref: ref, saved: copySave(data)),
                  // ERROR PAGE. If previous state is saved then continue to show old data
                  // but show a Snack bar saying error message
                  error: (err, stack) => (savedData == null)
                      ? ErrorPage(
                          error: errorNameToClass(err.toString()),
                          refresh_: _refresh,
                          ref: ref)
                      : ForecastLoaded(
                          data: savedData!, ref: ref, saved: false),
                  // LOADING PAGE. If previous state is saved then continue to show old data
                  // while refresh indicator continues to show
                  loading: () => (savedData == null)
                      ? const Center(
                          child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ))
                      : ForecastLoaded(
                          data: savedData!, ref: ref, saved: false)),
            )));
  }
}
