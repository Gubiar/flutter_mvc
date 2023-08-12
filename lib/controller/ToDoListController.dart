import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mvc/model/ToDoModel.dart';

class ToDoListController extends GetxController {
  RxList<ToDoModel> _toDoList = <ToDoModel>[].obs;
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

  // Método para carregar dados do usuário a partir do JSON
  void inserirToDo(Map<dynamic, dynamic> json) {
    _toDoList.add(ToDoModel(json: json));
  }

  // Remove o item passado por parâmetro
  void removerToDo(ToDoModel item) {
    _toDoList.remove(item);
  }

  //Remove um item de acordo com o id
  void removerToDoPeloId(int id) {
    _toDoList.removeWhere((element) => element.id == id);
  }

  // Atualiza toda a lista
  void atualizarToDoList(List<ToDoModel> lista) {
    _toDoList.clear();
    _toDoList.value = List.from(lista);
  }

  // Retorna uma lista filtrada pelo status
  List<ToDoModel> getListaPeloStatusId(int statusId) {
    List<ToDoModel> aux = [];
    for (ToDoModel cadaToDo in _toDoList.value) {
      if (cadaToDo.status == statusId) {
        aux.add(cadaToDo);
      }
    }
    return aux;
  }

  void changeOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ToDoModel item = _toDoList.removeAt(oldIndex);
    _toDoList.insert(newIndex, item);
  }

  List<ToDoModel>? get toDoList => _toDoList.value;

  void limparLista() {
    _toDoList.clear();
  }
}
