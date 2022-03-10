import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';

class ForecastData extends StatelessWidget {
  var data;
  WidgetRef ref;

  ForecastData({required this.data, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
                subtitle: Text(
                    data[index].celsius.toString() + '°C '),
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(),
    );
  }
}
