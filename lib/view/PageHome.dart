import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/ToDoListController.dart';
import 'package:flutter_mvc/model/toDoModel/ToDoModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../controller/ThemeController.dart';

class PageHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final ToDoListController toDoListController = Get.put(ToDoListController(), permanent: true);
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
                onReorder: (int oldIndex, int newIndex) => toDoListController.changeOrder(oldIndex, newIndex))),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async {
          Map? aux;
          await showNewItemBottomSheet(context, aux);
          if (aux != null) {
            print(json.encode(aux));
            await toDoListController.inserirToDo(aux);

            await scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
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
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1))),
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
                  children: [Text("Criado"), Text(DateFormat('dd/MM/yyyy').format(item.dataCriacao!))],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Limite"), Text(DateFormat('dd/MM/yyyy').format(item.dataMaximaConclusao!))],
                )
              ],
            ),
          )),
    );
  }

  FutureOr<void> showNewItemBottomSheet(BuildContext context, Map? jsonAux) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController dateConclusao = TextEditingController();
    TextEditingController dateConclusaoMaxima = TextEditingController();
    Uuid uuid = const Uuid();

    await showModalBottomSheet<Map?>(
      context: context,
      enableDrag: true,
      backgroundColor: Get.theme.colorScheme.background,
      showDragHandle: true,
      barrierColor: Colors.black87.withOpacity(0.5),
      elevation: 5,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.4, maxHeight: MediaQuery.of(context).size.height * 0.9),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              width: Get.width,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text("Descrição"),
                        suffixIcon: Icon(Icons.text_snippet_rounded),
                        hintText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width - 40,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, right: 20),
                          child: TextField(
                            controller: dateConclusao,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: () async {
                              DateTime? aux = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.utc(2100, 12, 30));

                              if (aux != null) {
                                dateConclusao.text = DateFormat("dd/MM/yyyy").format(aux);
                              }
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxWidth: Get.width / 2 - 30,
                                ),
                                label: const Text("Conclusão Prevista"),
                                hintText: '11/07/2023',
                                border: const OutlineInputBorder(),
                                suffixIcon: const Icon(Icons.calendar_month)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: dateConclusaoMaxima,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: () async {
                              DateTime? aux = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.utc(2100, 12, 30));
                              if (aux != null) {
                                dateConclusaoMaxima.text = DateFormat("dd/MM/yyyy").format(aux);
                              }
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxWidth: Get.width / 2 - 30,
                                ),
                                label: const Text("Conclusão Máxima"),
                                hintText: '12/07/2023',
                                border: const OutlineInputBorder(),
                                suffixIcon: const Icon(Icons.calendar_month)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(Get.width - 40, 50), backgroundColor: Get.theme.colorScheme.secondary),
                      onPressed: () {
                        if (dateConclusaoMaxima.text.isEmpty || dateConclusao.text.isEmpty || nameController.text.isEmpty) {
                          Get.snackbar("Atenção", "Todos os dados são obrigatórios");
                        } else {
                          jsonAux = {
                            "id": uuid.v1(),
                            "item": nameController.text,
                            "statusId": 1,
                            "dataCriacao": DateTime.now(),
                            "dataConclusao": DateFormat("dd/MM/yyyy").parse(dateConclusao.text),
                            "dataMaximaConclusao": DateFormat("dd/MM/yyyy").parse(dateConclusaoMaxima.text),
                          };
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Salvar",
                        style: TextStyle(color: Get.theme.colorScheme.onSecondary),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
