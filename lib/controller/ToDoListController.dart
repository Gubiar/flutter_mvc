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

  List<ToDo>? get toDoList => _toDoList.value; //public getter

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
    late int id;

    await databaseController.isar!.writeTxn(() async {
      id = await databaseController.isar!.toDos.put(aux);
    });

    aux.id = id;
    _toDoList.add(aux);
  }

  Future<void> removeToDoDB(int id) async {
    final DatabaseController databaseController = Get.find();

    await databaseController.isar!.writeTxn(() async {
      final success = await databaseController.isar!.toDos.delete(id);
      debugPrint('ToDo apagada: $success');
    });
  }

  Future<void> limparToDoDB() async {
    final DatabaseController databaseController = Get.find();

    await databaseController.isar!.writeTxn(() async {
      int totalDeleted = await databaseController.isar!.toDos.where().deleteAll();
      debugPrint('ToDos apagadas: $totalDeleted');
    });
  }

  // Remove o item passado por parâmetro
  Future<void> removerToDo(ToDo item) async {
    await removeToDoDB(item.id);
    _toDoList.remove(item);
  }

  //Remove um item de acordo com o id
  Future<void> removerToDoPeloId(int id) async {
    await removeToDoDB(id);
    _toDoList.removeWhere((element) => element.id == id);
  }

  // Atualiza toda a lista
  Future<void> atualizarToDoList(List<ToDo> lista) async {
    _toDoList.clear();
    await limparToDoDB();

    final DatabaseController databaseController = Get.find();

    await databaseController.isar!.writeTxn(() async {
      await databaseController.isar!.toDos.putAll(lista);
    });

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

  Future<void> changeOrder(int oldIndex, int newIndex) async {
    await changeOrderDB(_toDoList[oldIndex].id, _toDoList[newIndex].id);

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ToDo item = _toDoList.removeAt(oldIndex);
    _toDoList.insert(newIndex, item);
  }

  //será feito update nos item, o conteudo de
  // cada um será alterado no outro e vise-versa (sem mudar o id)
  //Assim, o conteudo de cada item trocara de posicao
  Future<bool> changeOrderDB(int oldId, int newId) async {
    final DatabaseController databaseController = Get.find();

    ToDo? item1 = await databaseController.isar!.toDos.get(oldId);
    ToDo? item2 = await databaseController.isar!.toDos.get(newId);

    if (item1 == null || item2 == null) {
      return false;
    }

    int idItem1 = item1.id;

    // Trocar as posições diretamente nos objetos
    item1.id = item2.id;
    item2.id = idItem1;

    // Atualizar os itens no banco de dados
    await databaseController.isar!.toDos.put(item1);
    await databaseController.isar!.toDos.put(item2);

    return true;
  }

  Future<void> limparLista() async {
    await limparToDoDB();
    _toDoList.clear();
  }
}
