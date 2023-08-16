import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/DatabaseController.dart';
import 'package:flutter_mvc/model/toDoModel/ToDoModel.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

class ToDoListController extends GetxController {
  final RxList<ToDo> _toDoList = <ToDo>[].obs;
  List<Map<String, dynamic>> statusList = [
    {
      "id": 1,
      "nome": "A fazer",
      "color": Colors.grey,
      "textColor": Colors.white,
    },
    {
      "id": 2,
      "nome": "No Processo",
      "color": Colors.blue,
      "textColor": Colors.white,
    },
    {
      "id": 3,
      "nome": "Concluído",
      "color": Colors.green,
      "textColor": Colors.white,
    },
    {
      "id": 4,
      "nome": "Arquivado",
      "color": Colors.grey.shade200,
      "textColor": Colors.grey,
    },
    {
      "id": 5,
      "nome": "Atradaso",
      "color": Colors.red,
      "textColor": Colors.white,
    },
  ];

  Future<void> getToDoFromDB() async {
    final DatabaseController databaseController = Get.find();
    _toDoList.clear();
    List<ToDo?> aux = await databaseController.isar!.toDos.where().findAll();
    _toDoList.value = List.from(aux);
  }

  // Método para carregar dados do usuário a partir do JSON
  Future<void> inserirToDo(Map<dynamic, dynamic> json) async {
    ToDo aux = ToDo()
    ..id = json["id"]
    ..dataConclusao = json["dataConclusao"]
    ..dataCriacao = json["dataCriacao"]
    ..dataMaximaConclusao = json["dataMaximaConclusao"]
    ..item = json["item"]
    ..statusId = json["statusId"];

    final DatabaseController databaseController = Get.find();
    await databaseController.isar!.writeTxn(() async {
      await databaseController.isar!.toDos.put(aux);
    });
    getToDoFromDB(); //atualiza a lista
  }

  // Remove o item passado por parâmetro
  void removerToDo(ToDo item) {
    _toDoList.remove(item);
  }

  //Remove um item de acordo com o id
  void removerToDoPeloId(int id) {
    _toDoList.removeWhere((element) => element.id == id);
  }

  // Atualiza toda a lista
  void atualizarToDoList(List<ToDo> lista) {
    _toDoList.clear();
    _toDoList.value = List.from(lista);
  }

  // Retorna uma lista filtrada pelo status
  List<ToDo> getListaPeloStatusId(int statusId) {
    List<ToDo> aux = [];
    for (ToDo cadaToDo in _toDoList.value) {
      if (cadaToDo.statusId == statusId) {
        aux.add(cadaToDo);
      }
    }
    return aux;
  }

  void changeOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ToDo item = _toDoList.removeAt(oldIndex);
    _toDoList.insert(newIndex, item);
  }

  List<ToDo>? get toDoList => _toDoList.value;

  void limparLista() {
    _toDoList.clear();
  }
}
