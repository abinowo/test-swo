import 'package:flutter/material.dart';
import 'package:swo/modules/charting/charting.module.dart';
import 'package:swo/modules/watchlist/watchlist.module.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('SWO Test'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: const SafeArea(
          child: Column(
            children: [
              WatchListModule(),
              ChartingModule(),
            ],
          ),
        ),
      ),
    );
  }
}
