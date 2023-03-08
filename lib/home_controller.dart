import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

final random = Random();

class HomeController {
  final int sizeOfList;

  HomeController({required this.sizeOfList}) {
    generateList();
  }

  ValueNotifier<List<int>> values = RxNotifier([]);

  void generateList() {
    values.value = List<int>.generate(sizeOfList, (int index) => random.nextInt(1000));
  }

  Future<void> sort() async {
    for (int i = 0; i < values.value.length; i++) {
      for (int j = 0; j < values.value.length - i - 1; j++) {
        if (values.value[j] > values.value[j + 1]) {
          int aux = values.value[j];
          values.value[j] = values.value[j + 1];
          values.value[j + 1] = aux;
          await Future.delayed(const Duration(milliseconds: 10));
          values.value = values.value.toList();
        }
      }
    }
  }
}
