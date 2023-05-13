import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/ThemeController.dart';

class PageHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageHome'),
        leading: IconButton(
          onPressed: () => Get.offAndToNamed('/PageLogin'),
          icon: Icon(
            Icons.exit_to_app,
            color: Get.theme.colorScheme.primary,
          ),
        ),
        actions: [
          Obx(() => IconButton(
              onPressed: () => themeController.toggleTheme(),
              icon: Icon(
                themeController.isDarkMode.value ? Icons.dark_mode : Icons.light_mode,
                color: themeController.isDarkMode.value ? Colors.white : Colors.black87,
              )
          ))
        ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        alignment: Alignment.center,
        child: const Text('PageHome'),
      ),
    );
  }
}
