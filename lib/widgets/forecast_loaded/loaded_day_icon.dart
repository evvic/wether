import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wether/model/forecast_day.dart';
import 'package:wether/services/forecast_services.dart';

class LoadedDayIcon extends StatelessWidget {
  String longDesc;
  String icon;
  int index;

  LoadedDayIcon(
      {Key? key,
      required this.longDesc,
      required this.icon,
      required this.index})
      : super(key: key);

  static const dayNameStyle = TextStyle(
      fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold);
  static const defaultDayNameStyle =
      TextStyle(fontSize: 16, color: Colors.black87);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Image.network(
        'http://openweathermap.org/img/wn/${icon}@2x.png',
        scale: 1.6,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black),
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),

      RichText(
        text: TextSpan(style: defaultDayNameStyle, children: <TextSpan>[
          TextSpan(text: forecastDay(index), style: dayNameStyle),
          TextSpan(
            text: ', ${longDesc}',
          ),
          TextSpan(text: "."),
        ]),
      ),
    ]);
  }
}
