import 'package:flutter/material.dart';
import 'package:flutter_mvc/model/toDoModel/ToDoModel.dart';
import 'package:get/get.dart';

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

  // Método para carregar dados do usuário a partir do JSON
  void inserirToDo(Map<dynamic, dynamic> json) {
    ToDo aux = ToDo()
    ..id = json["id"]
    ..dataConclusao = json["dataConclusao"]
    ..dataCriacao = json["dataCriacao"]
    ..dataMaximaConclusao = json["dataMaximaConclusao"]
    ..item = json["item"]
    ..statusId = json["statusId"];

    _toDoList.add(aux);
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
