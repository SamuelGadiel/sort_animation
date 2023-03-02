import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

final random = Random();

// class HomeController {
int quantity = 100;
ValueNotifier<List<int>> values = RxNotifier(List<int>.generate(quantity, (int index) => random.nextInt(1000)));

// void generateList() {
//   final list = values.addAll(list);
// }

void sort() async {
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
  // }
}
