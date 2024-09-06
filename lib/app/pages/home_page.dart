import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:sort_animation/app/controller/home_controller.dart';
import 'package:sort_animation/app/widgets/options_card.dart';

import '../controller/home_store.dart';

final HomeStore homeStore = HomeStore();

class HomePage extends StatelessWidget {
  final HomeController homeController = HomeController(homeStore);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(() => {homeStore.items, homeStore.isBarStyle.value});
    final height = (MediaQuery.of(context).size.height) - kToolbarHeight - 11;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort Animations'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => homeStore.isBarStyle.value = !homeStore.isBarStyle.value,
            icon: Icon(homeStore.isBarStyle.value == true ? Icons.equalizer : Icons.grain),
          ),
          const SizedBox(width: 20),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 0),
        ),
      ),
      body: Stack(
        children: [
          Column(
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
                        width: (MediaQuery.of(context).size.width / homeStore.sizeOfList) - 4,
                        color: Theme.of(context).primaryColor,
                      );
                    }

                    return Column(
                      children: [
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: (MediaQuery.of(context).size.width / homeStore.sizeOfList) - 4,
                          width: (MediaQuery.of(context).size.width / homeStore.sizeOfList) - 4,
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 2),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           fixedSize: const Size.fromHeight(36),
              //           backgroundColor: const Color(0xFF005c3c),
              //           foregroundColor: const Color(0xFF83f5cb),
              //         ),
              //         onPressed: () => homeController.generateList(homeStore.sizeOfList),
              //         child: const Text('Generate'),
              //       ),
              //       const SizedBox(width: 128),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           fixedSize: const Size.fromHeight(36),
              //           foregroundColor: const Color(0xFFdedfff),
              //         ),
              //         onPressed: () => homeController.bubbleSort(),
              //         child: const Text('Buuble Sort'),
              //       ),
              //       const SizedBox(width: 16),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           fixedSize: const Size.fromHeight(36),
              //           foregroundColor: const Color(0xFFdedfff),
              //         ),
              //         onPressed: () => homeController.selectionSort(),
              //         child: const Text('Selection Sort'),
              //       ),
              //       const SizedBox(width: 16),
              //       ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           fixedSize: const Size.fromHeight(36),
              //           foregroundColor: const Color(0xFFdedfff),
              //         ),
              //         onPressed: () => homeController.insertionSort(),
              //         child: const Text('Insertion Sort'),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          Positioned(
            left: 8,
            top: 8,
            child: OptionsCard(homeController),
          ),
        ],
      ),
    );
  }
}
