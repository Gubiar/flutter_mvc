import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/ToDoListController.dart';
import 'package:flutter_mvc/model/toDoModel/ToDoObj.dart';
import 'package:get/get.dart';

import '../controller/ThemeController.dart';

class PageHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final ToDoListController toDoListController = Get.put(ToDoListController(), permanent: true);
  PageHome({Key? key}) : super(key: key);

  final Color oddItemColor = Get.theme.colorScheme.secondary.withOpacity(0.05);
  final Color evenItemColor = Get.theme.colorScheme.secondary.withOpacity(0.15);
  final Color draggableItemColor = Get.theme.colorScheme.secondary;

  Widget proxyDecorator(
      Widget child, int index, Animation<double> animation) {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => ReorderableListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                proxyDecorator: proxyDecorator,
                itemCount: toDoListController.toDoList!.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = toDoListController.toDoList![index];
                  return getToDoItemList(item);
                },
                onReorder: (int oldIndex, int newIndex) => toDoListController.changeOrder(oldIndex, newIndex))),
            InkWell(
              onTap: () {
                int id = toDoListController.toDoList!.length + 1;

                toDoListController.inserirToDo({
                  "id": DateTime.now().millisecondsSinceEpoch,
                  "item": "Item $id",
                  "status": 1,
                  "dataCriacao": DateTime.now(),
                  "dataConclusao": DateTime.now().add(const Duration(days: 3)),
                  "dataMaximaConclusao": DateTime.now().add(const Duration(days: 7))
                });
              },
              child: Text('Adicionar'),
            ),

            const SizedBox(height: 60), //Padding bottom
          ],
        ),
      ),
    );
  }

  Widget getToDoItemList(ToDoObj item) {
    return Dismissible(
      key: Key(item.id!.toString()),
      onDismissed: (direction) {
        toDoListController.removerToDo(item);
        if(!Get.isSnackbarOpen){
          Get.showSnackbar(
            GetSnackBar(
              title: "Item removido",
              message: '${item.item} removido com sucesso',
              icon: const Icon(Icons.delete_forever),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      background: Container(color: Colors.red),
      child: ListTile(
        title: Text(item.item!),
      ),
    );
  }
}
