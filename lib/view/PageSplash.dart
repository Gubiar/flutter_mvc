import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/ThemeController.dart';
import 'package:flutter_mvc/controller/UsuarioController.dart';
import 'package:get/get.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({Key? key}) : super(key: key);

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(const Duration(seconds: 5)); //Simulação de uma chamada API
    Get.offAllNamed('/PageLogin');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Get.theme.colorScheme.primary,
      alignment: Alignment.center,
      child: Icon(
        Icons.home_rounded,
        color: Get.theme.colorScheme.onPrimary,
        size: 100,
      ),
    );
  }
}
