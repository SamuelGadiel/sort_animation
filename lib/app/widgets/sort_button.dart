import 'package:flutter/material.dart';
import 'package:sort_animation/app/controller/home_controller.dart';

import '../enums/sort.dart';
import '../pages/home_page.dart';

class SortButton extends StatelessWidget {
  final HomeController homeController;
  final Sort sortMethod;

  const SortButton({
    required this.homeController,
    required this.sortMethod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(fixedSize: const Size.fromHeight(36)),
        onPressed: homeStore.isSorting.value == false ? () => homeController.sort(sortMethod) : null,
        child: Text(sortMethod.description),
      ),
    );
  }
}
