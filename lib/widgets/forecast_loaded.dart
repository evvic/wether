import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_weather_app/model/forecast_day.dart';
import 'package:mobile_weather_app/services/forecast_services.dart';
import 'package:mobile_weather_app/widgets/forecast_loaded/loaded_card.dart';

class ForecastLoaded extends StatelessWidget {
  List<ForecastDayData> data;
  WidgetRef ref;
  bool saved;

  ForecastLoaded({required this.data, required this.ref, required this.saved});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: ListView.separated(
        // for scroll physics on refresh
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(8),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return LoadedCard(index: index, data: data[index]);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(color: Colors.transparent),
      ),
    );
  }
}
