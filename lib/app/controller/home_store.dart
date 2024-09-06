import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeStore {
  final ValueNotifier<bool> isBarStyle = RxNotifier(true);

  final ValueNotifier<bool> isSorting = RxNotifier(false);

  final int sizeOfList = 100;

  ValueNotifier<List<int>> listNotifier = RxNotifier([]);

  List<int> get items => listNotifier.value;
}
