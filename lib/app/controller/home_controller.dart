import 'dart:math';

import 'package:sort_animation/app/controller/home_store.dart';
import 'package:sort_animation/app/enums/sort.dart';

class HomeController {
  final HomeStore homeStore;

  HomeController(this.homeStore) {
    generateList(homeStore.sizeOfList);
  }

  void generateList(int sizeOfList) {
    homeStore.isSorting.value = false;

    final random = Random();

    homeStore.listNotifier.value = List<int>.generate(sizeOfList, (int index) => random.nextInt(1000));
  }

  Future<void> updateScreen() async {
    await Future.delayed(const Duration(milliseconds: 30));
    homeStore.listNotifier.value = homeStore.items.toList();
  }

  Future<void> sort(Sort sortMethod) async {
    homeStore.isSorting.value = true;

    switch (sortMethod) {
      case Sort.bubbleSort:
        await bubbleSort();
        break;
      case Sort.selectionSort:
        await selectionSort();
        break;
      case Sort.insertionSort:
        await insertionSort();
        break;
      case Sort.mergeSort:
        homeStore.listNotifier.value = mergeSort(homeStore.items);
        break;
    }
  }

  Future<void> bubbleSort() async {
    for (int i = 0; i < homeStore.items.length; i++) {
      for (int j = 0; j < homeStore.items.length - i - 1; j++) {
        if (homeStore.isSorting.value == false) {
          break;
        }

        if (homeStore.items[j] > homeStore.items[j + 1]) {
          int aux = homeStore.items[j];
          homeStore.items[j] = homeStore.items[j + 1];
          homeStore.items[j + 1] = aux;
          await updateScreen();
        }
      }
    }
  }

  Future<void> selectionSort() async {
    for (int i = 0; i < homeStore.items.length - 1; i++) {
      int minorIndex = i;

      for (int j = i + 1; j < homeStore.items.length; j++) {
        if (homeStore.isSorting.value == false) {
          break;
        }

        if (homeStore.items[j] < homeStore.items[minorIndex]) {
          minorIndex = j;
          await updateScreen();
        }
      }

      if (minorIndex != i) {
        int aux = homeStore.items[i];
        homeStore.items[i] = homeStore.items[minorIndex];
        homeStore.items[minorIndex] = aux;

        await updateScreen();
      }
    }
  }

  Future<void> insertionSort() async {
    for (int i = 1; i < homeStore.items.length; i++) {
      int key = homeStore.items[i];
      int j = i - 1;

      while (j >= 0 && homeStore.items[j] > key) {
        if (homeStore.isSorting.value == false) {
          break;
        }

        homeStore.items[j + 1] = homeStore.items[j];
        j--;

        await updateScreen();
      }
      homeStore.items[j + 1] = key;

      await updateScreen();
    }
  }

  List<int> mergeSort(List<int> unorderedList) {
    if (unorderedList.length <= 1) {
      return unorderedList;
    }

    final middle = unorderedList.length ~/ 2;

    List<int> left = unorderedList.sublist(0, middle);
    List<int> right = unorderedList.sublist(middle);

    left = mergeSort(left);
    right = mergeSort(right);

    return _merge(left, right);
  }

  List<int> _merge(List<int> left, List<int> right) {
    final orderedList = <int>[];
    int i = 0;
    int j = 0;

    while (i < left.length && j < right.length) {
      if (left[i] <= right[j]) {
        orderedList.add(left[i]);
        i++;
      } else {
        orderedList.add(right[j]);
        j++;
      }
    }

    while (i < left.length) {
      orderedList.add(left[i]);
      i++;
    }

    while (j < right.length) {
      orderedList.add(right[j]);
      j++;
    }

    return orderedList;
  }
}
