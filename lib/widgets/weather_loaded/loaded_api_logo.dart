import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class LoadedApiLogo extends StatelessWidget {
  final _url = "https://openweathermap.org/";

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 120, right: 120),
          child: GestureDetector(
            child: Image.asset(
              "assets/openweathermap_logo.png",
              fit: BoxFit.fitWidth,
            ),
            onTap: () => _launchURL(),
          ),
        ));
  }

  void _launchURL() async {
    try {
      if (await canLaunch(_url)) {
        await launch(_url);
      } else {
        throw 'Could not launch $_url';
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
