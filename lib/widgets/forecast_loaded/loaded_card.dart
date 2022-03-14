import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/model/forecast_day.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';
import 'package:mobile_weather_app/widgets/forecast_loaded/loaded_day_icon.dart';

class LoadedCard extends StatelessWidget {
  ForecastDayData data;
  int index;

  LoadedCard({Key? key, required this.data, required this.index})
      : super(key: key);

  static const dayNameStyle = TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold);
  static const defaultDayNameStyle = TextStyle(fontSize: 16, color: Colors.black87);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (index == 0)?
        // add top padding to the first element so it doesn't
        // begin under the appbar
        const EdgeInsets.only(top: 50.0, left: 10, right: 10) :
        const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        //http://openweathermap.org/img/wn/10d@2x.png
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LoadedDayIcon(longDesc: data.descDesc, icon: data.icon, index: index),


            ],
          ),
        )
      )
    );
  }
}