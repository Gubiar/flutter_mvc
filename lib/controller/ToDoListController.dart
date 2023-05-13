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

  // Método para carregar dados do usuário a partir do JSON
  void removerToDo(ToDoModel item) {
    _toDoList.remove(item);
  }

  void removerToDoPeloId(int id) {
    _toDoList.removeWhere((element) => element.id == id);
  }

  // Método para atualizar os dados do usuário
  void atualizarToDoList(List<ToDoModel> lista) {
    _toDoList.clear();
    _toDoList.value = List.from(lista);
  }

  // Método para atualizar os dados do usuário
  List<ToDoModel> getListaPeloStatusId(int statusId) {
    List<ToDoModel> aux = [];
    for(ToDoModel cadaToDo in _toDoList.value){
      if(cadaToDo.status == statusId){
        aux.add(cadaToDo);
      }
    }
    return aux;
  }

  List<ToDoModel>? get toDoList => _toDoList.value;

  void limparLista() {
    _toDoList.clear();
  }

}