import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadedTempExtrema extends StatelessWidget {
  int min = 69;
  int max = 69;

  LoadedTempExtrema({Key? key, required this.min, required this.max})
      : super(key: key);

  static const ztyle = TextStyle(fontSize: 18);
  static const subZtyle = TextStyle(fontSize: 16, color: Colors.black45);

  // in the future maybe add some color to this that represetns how hot and/or cool the high and low is for today
  // represent through a background gradient of red to blue, i.e. where a hotter day would be more red
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        width: double.infinity,
        //height: double.maxFinite,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text("high  ", style: subZtyle),
                            Text("$max°C", style: ztyle),
                            const Icon(Icons.arrow_upward_rounded),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.arrow_downward_rounded),
                            Text("$min°C", style: ztyle),
                            Text("  low", style: subZtyle)
                          ],
                        ),
                      ),
                  ]
                  )
                  ))));
  }
}
