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
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // @override
  // void initState() {
  //   // homeController.generateList();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     sort();
  //   });

  //   super.initState();
  // }

  // final homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    final value = context.select(() => values.value);
    final height = (MediaQuery.of(context).size.height) - kToolbarHeight - 10 - 40;

    return Scaffold(
      appBar: AppBar(title: const Text('Sort')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: value.map((element) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    height: lerpDouble(0, (height), (element / 1000)),
                    width: (MediaQuery.of(context).size.width / quantity) - 4,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(36),
              ),
              onPressed: () => sort(),
              child: const Text('sort'),
            ),
          ),
        ],
      ),
    );
  }
}
