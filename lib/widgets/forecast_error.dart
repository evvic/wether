import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForecastError extends StatelessWidget {
  final String message;
  var refresh_; //function to refresh page
  WidgetRef ref;

  ForecastError({required this.message, required this.refresh_, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Error: $message'),
      CupertinoButton(
        child: const Text("refresh"),
        // maybe dont need arrow function
        onPressed: () => refresh_(ref))
    ]);
  }
}
