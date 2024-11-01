import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/ThemeController.dart';
import 'package:flutter_mvc/data/database.dart';
import 'package:get/get.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({super.key});

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  final ThemeController themeController = Get.find();

  
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final database = AppDatabase();
    await database.into(database.todoItems).insert(TodoItemsCompanion.insert(
      title: 'todo: finish drift setup',
      content: 'We can now write queries and define our own tables.',
    ));
    List<TodoItem> allItems = await database.select(database.todoItems).get();

    print('items in database: $allItems');

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
      child: Image.asset(
        themeController.isDarkMode.value ? 'assets/images/Flutter-MVC-logos_transparent.png' : 'assets/images/Flutter-MVC-logos_black.png',
        width: Get.width * 0.75,
        fit: BoxFit.contain,
      ),
    );
  }
}
