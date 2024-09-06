import 'package:flutter/material.dart';
import 'package:sort_animation/app/enums/sort.dart';
import 'package:sort_animation/app/widgets/sort_button.dart';

import '../controller/home_controller.dart';
import '../pages/home_page.dart';

class OptionsCard extends StatelessWidget {
  final HomeController homeController;

  const OptionsCard(this.homeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Options', style: Theme.of(context).textTheme.titleMedium),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(36),
                backgroundColor: const Color(0xFF005c3c),
                foregroundColor: const Color(0xFF83f5cb),
              ),
              onPressed: () => homeController.generateList(homeStore.sizeOfList),
              child: const Text('Generate'),
            ),
            SortButton(homeController: homeController, sortMethod: Sort.bubbleSort),
            SortButton(homeController: homeController, sortMethod: Sort.selectionSort),
            SortButton(homeController: homeController, sortMethod: Sort.insertionSort),
          ],
        ),
      ),
    );
  }
}
