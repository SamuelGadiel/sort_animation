import 'dart:math';

import 'package:sort_animation/app/controller/home_store.dart';

class HomeController {
  final HomeStore homeStore;

  HomeController(this.homeStore) {
    generateList(homeStore.sizeOfList);
  }

  void generateList(int sizeOfList) {
    final random = Random();

    homeStore.listNotifier.value = List<int>.generate(sizeOfList, (int index) => random.nextInt(1000));
  }

  Future<void> bubbleSort() async {
    for (int i = 0; i < homeStore.items.length; i++) {
      for (int j = 0; j < homeStore.items.length - i - 1; j++) {
        if (homeStore.items[j] > homeStore.items[j + 1]) {
          int aux = homeStore.items[j];
          homeStore.items[j] = homeStore.items[j + 1];
          homeStore.items[j + 1] = aux;
          await Future.delayed(const Duration(milliseconds: 30));
          homeStore.listNotifier.value = homeStore.items.toList();
        }
      }
    }
  }

  Future<void> selectionSort() async {
    for (int i = 0; i < homeStore.items.length - 1; i++) {
      int minorIndex = i;

      for (int j = i + 1; j < homeStore.items.length; j++) {
        if (homeStore.items[j] < homeStore.items[minorIndex]) {
          minorIndex = j;
        }
      }

      if (minorIndex != i) {
        int aux = homeStore.items[i];
        homeStore.items[i] = homeStore.items[minorIndex];
        homeStore.items[minorIndex] = aux;

        await Future.delayed(const Duration(milliseconds: 30));
        homeStore.listNotifier.value = homeStore.items.toList();
      }
    }
  }
}
