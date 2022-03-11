import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadedLongDesc extends StatelessWidget {
  String description;

  LoadedLongDesc({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("Currently, $description.",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
      )
    );
  }
}
