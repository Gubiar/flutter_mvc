import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/ToDoListController.dart';
import 'package:flutter_mvc/model/toDoModel/ToDoModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/ThemeController.dart';

class PageHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final ToDoListController toDoListController =
      Get.put(ToDoListController(), permanent: true);
  PageHome({super.key}) {
    toDoListController.getToDoFromDB();
  }

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
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.black87,
              )))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 140),
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => ReorderableListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                proxyDecorator: proxyDecorator,
                itemCount: toDoListController.toDoList!.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  final item = toDoListController.toDoList![index];
                  return getToDoItemList(item);
                },
                onReorder: (int oldIndex, int newIndex) =>
                    toDoListController.changeOrder(oldIndex, newIndex))),
          ],
        ),
      ),
      floatingActionButton:   ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async {
          int id = toDoListController.toDoList!.length + 1;

          await toDoListController.inserirToDo({
            "id": DateTime.now().millisecondsSinceEpoch,
            "item": "Item $id",
            "statusId": 1,
            "dataCriacao": DateTime.now(),
            "dataConclusao": DateTime.now().add(const Duration(days: 3)),
            "dataMaximaConclusao": DateTime.now().add(const Duration(days: 7))
          });

          await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        child: Text(
          'Adicionar',
          style: TextStyle(color: Get.theme.colorScheme.onPrimary),
        ),
      ),
    );
  }

  Widget getToDoItemList(ToDo item) {
    return Dismissible(
      key: Key(item.id!.toString()),
      onDismissed: (direction) {
        toDoListController.removerToDo(item);
        if (!Get.isSnackbarOpen) {
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
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1))),
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(item.item!),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Criado"),
                    Text(DateFormat('dd/MM/yyyy').format(item.dataCriacao!))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Limite"),
                    Text(DateFormat('dd/MM/yyyy')
                        .format(item.dataMaximaConclusao!))
                  ],
                )
              ],
            ),
          )),
    );
  }
}
