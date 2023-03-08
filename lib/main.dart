import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:sort_animation/home_controller.dart';

void main() {
  runApp(const RxRoot(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeController = HomeController(sizeOfList: 100);

  final ValueNotifier<bool> isBarStyle = RxNotifier(true);

  @override
  Widget build(BuildContext context) {
    context.select(() => {homeController.values.value, isBarStyle.value});
    final height = (MediaQuery.of(context).size.height) - kToolbarHeight - 10 - 40;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bubble Sort Example'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => isBarStyle.value = !isBarStyle.value,
            icon: Icon(isBarStyle.value == true ? Icons.equalizer : Icons.grain),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: homeController.values.value.map((element) {
                if (isBarStyle.value == true) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: lerpDouble(0, (height), (element / 1000)),
                    width: (MediaQuery.of(context).size.width / homeController.sizeOfList) - 4,
                    color: Theme.of(context).primaryColor,
                  );
                } else {
                  return Column(
                    children: [
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: (MediaQuery.of(context).size.width / homeController.sizeOfList) - 4,
                        width: (MediaQuery.of(context).size.width / homeController.sizeOfList) - 4,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      SizedBox(
                        height: lerpDouble(0, (height - 10), (element / 1000)),
                      ),
                    ],
                  );
                }
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(36),
                  ),
                  onPressed: () => homeController.generateList(),
                  child: const Text('reset'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(36),
                  ),
                  onPressed: () => homeController.sort(),
                  child: const Text('sort'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
