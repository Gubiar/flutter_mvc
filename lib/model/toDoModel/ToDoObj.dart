import 'package:get/get.dart';

class ToDoObj extends GetxController {
  int? id;
  String? item;
  int? status;
  DateTime? dataCriacao;
  DateTime? dataConclusao;
  DateTime? dataMaximaConclusao;

  ToDoObj({Map<dynamic, dynamic>? json}){
    if(json != null){
      fromJson(json);
    }
  }

  void fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    item = json['item'];
    status = json['status'];
    dataCriacao = json['dataCriacao'];
    dataConclusao = json['dataConclusao'];
    dataMaximaConclusao = json['dataMaximaConclusao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['item']= item;
    data['status'] = status;
    data['dataCriacao'] = dataCriacao!.toIso8601String();
    data['dataConclusao'] = dataConclusao!.toIso8601String();
    data['dataMaximaConclusao'] = dataMaximaConclusao!.toIso8601String();
    return data;
  }
}