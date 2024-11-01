import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ThemeController.dart';

class PageHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  PageHome({super.key});

  final Color oddItemColor = Get.theme.colorScheme.secondary.withOpacity(0.05);
  final Color evenItemColor = Get.theme.colorScheme.secondary.withOpacity(0.15);
  final Color draggableItemColor = Get.theme.colorScheme.secondary;
  final ScrollController scrollController = ScrollController();

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          color: draggableItemColor,
          shadowColor: draggableItemColor,
          child: child,
        );
      },
      child: child,
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Get.theme.colorScheme.onPrimary,
    backgroundColor: Get.theme.colorScheme.primary,
    minimumSize: const Size(120, 40),
    alignment: Alignment.center,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(40)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageHome'),
        leading: IconButton(
          onPressed: () => Get.offAndToNamed('/PageLogin'),
          icon: Icon(
            Icons.exit_to_app,
            color: Get.theme.colorScheme.secondary,
          ),
        ),
        actions: [
          Obx(() => IconButton(
              onPressed: () => themeController.toggleTheme(),
              icon: Icon(
                themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                color: themeController.isDarkMode.value ? Colors.white : Colors.black87,
              )))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 140),
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

          ],
        ),
      ),
    );
  }

}
