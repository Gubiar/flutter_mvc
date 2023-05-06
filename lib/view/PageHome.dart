import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageHome'),
        leading: IconButton(
          onPressed: () => Get.offAndToNamed('/'),
          icon: Icon(
            Icons.exit_to_app,
            color: Get.theme.colorScheme.primary,
          ),
        ),
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
