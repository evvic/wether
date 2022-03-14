import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wether/model/forecast_day.dart';
import 'package:wether/services/forecast_services.dart';
import 'package:wether/widgets/forecast_loaded/loaded_card.dart';

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
