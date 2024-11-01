import 'package:get/get.dart';

class UsuarioObj extends GetxController {
  int? id;
  String? nome;
  DateTime? dtNascimento;
  String? email;
  String? token;

  UsuarioObj({Map<dynamic, dynamic>? json}){
    if(json != null){
      fromJson(json);
    }
  }

  void fromJson(Map<dynamic, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    nome = json['nome'];
    dtNascimento = json['dtNascimento'] != null ? DateTime.parse(json['dtNascimento']) : null;
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['nome'] = nome;
    data['dtNascimento'] = dtNascimento?.toIso8601String();
    data['email'] = email;
    data['token'] = token;
    return data;
  }
}