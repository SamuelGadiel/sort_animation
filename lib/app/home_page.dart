import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:sort_animation/app/controller/home_controller.dart';

import 'controller/home_store.dart';

final HomeStore homeStore = HomeStore();

class HomePage extends StatelessWidget {
  final HomeController homeController = HomeController(homeStore);

  final int sizeOfList = 100;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(() => {homeStore.items, homeStore.isBarStyle.value});
    final height = (MediaQuery.of(context).size.height) - kToolbarHeight - 10 - 40;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bubble Sort Example'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => homeStore.isBarStyle.value = !homeStore.isBarStyle.value,
            icon: Icon(homeStore.isBarStyle.value == true ? Icons.equalizer : Icons.grain),
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
              children: homeStore.listNotifier.value.map((element) {
                  

                if (homeStore.isBarStyle.value == true) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: lerpDouble(0, (height), (element / 1000)),
                    width: (MediaQuery.of(context).size.width / sizeOfList) - 4,
                    color: Theme.of(context).primaryColor,
                  );
                }

                return Column(
                  children: [
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: (MediaQuery.of(context).size.width / sizeOfList) - 4,
                      width: (MediaQuery.of(context).size.width / sizeOfList) - 4,
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
                  onPressed: () => homeController.generateList(sizeOfList),
                  child: const Text('reset'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(36),
                  ),
                  onPressed: () => homeController.bubbleSort(),
                  child: const Text('Buuble Sort'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(36),
                  ),
                  onPressed: () => homeController.selectionSort(),
                  child: const Text('Selection Sort'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
