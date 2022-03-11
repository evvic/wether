import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadedHeading extends StatelessWidget {
  int temp = 69;
  String description = "Cloudy";
  String icon = "10d";

  LoadedHeading({Key? key, required this.temp, required this.description, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 4 / 2,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Image.network(
                    'https://openweathermap.org/img/wn/$icon@2x.png',
                    scale: 0.5,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )

                  //color: Colors.green,
                  ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        //align left
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15.0),
                          ),
                          Text("$temp°C",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 64,
                              )),
                          Text("$description",
                              style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 36,
                              ))
                        ],
                      ),
                    ))

                //color: Colors.green,
                )
          ],
        ));
  }
}
