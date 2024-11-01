import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvc/controller/Controller.dart';
import 'package:flutter_mvc/data/model/UsuarioModel/UsuarioObj.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioController extends GetxController {
  final Rx<UsuarioObj?> _usuarioModel = Rx<UsuarioObj?>(UsuarioObj());

  // Método para carregar dados do usuário a partir do JSON
  void carregarUsuario(Map<dynamic, dynamic> json) {
    _usuarioModel.value = UsuarioObj(json: json);
  }

  // Método para atualizar os dados do usuário
  void atualizarUsuario(UsuarioObj usuario) {
    _usuarioModel.value = usuario;
  }

  // Método para recuperar o usuário atual
  UsuarioObj? get usuario => _usuarioModel.value;

  // Método para limpar os dados do usuário
  void limparUsuario() {
    _usuarioModel.value = null;
  }

  Future<bool> fazerLogin({required String email, required String senha}) async {
    if(email.isEmpty || senha.isEmpty){
      Get.snackbar('login Inválido!', 'Preencha todos os campos');
      return false;
    } else {
      Map<String, dynamic> retorno = await _postLogin(email, senha);
      if(retorno['success'] == "true") return true;
      Get.snackbar('Houve um erro', retorno['message'].toString());
      return false;
    }
  }

  Future<bool> fazerCadastro({required String nome, required String email, required String senha, required String repetirSenha}) async {
    if(nome.isEmpty || email.isEmpty || senha.isEmpty || repetirSenha.isEmpty){
      Get.snackbar('Cadastro Inválido!', 'Todos os campos são obrigatórios');
      return false;
    } else if(senha != repetirSenha){
      Get.snackbar('Dados incorretos', 'As senhas estão diferentes');
      return false;
    } else {

      String mapToSend = '{"name":"$nome","email":"$email","password":"$senha","confirmPassword":"$repetirSenha"}';
      Map<String, dynamic> retorno = await _postCadastro(mapToSend);

      if(retorno['success'] == 'true'){
        Get.offAllNamed('/PageHome');
      }
      Get.snackbar('Erro ao cadastrar!', retorno['message']);
      return false;
    }
  }

  Future<Map<String, dynamic>> _postLogin(String login, String senha) async {
    String mapToSend = '{"email":"$login","password":"$senha"}';
    debugPrint('postLogin body $mapToSend');

    try {
      http.Response response = await http
          .post(
        Uri.parse('${Controller.url}auth/login'),
        headers: {
          "Content-Type": "application/json",
        },
        body: mapToSend,
      )
          .timeout(Duration(seconds: Controller.resquestDurationSecondsTime),
          onTimeout: () => http.Response(
            'timeout',
            408,
          ));

      debugPrint('postLogin URL-> ${Controller.url}auth/login.json\n');
      debugPrint('postLogin CODE-> ${response.statusCode}');
      debugPrint('postLogin response->${response.body}');

      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData['success'].toString() == 'true') {
        carregarUsuario(jsonData);
        (await SharedPreferences.getInstance()).setString('token', usuario!.token.toString());
        return {
          'success': 'true',
        };
      } else {
        return {'success': 'false', 'message': jsonData['message'].toString()};
      }
    } catch (error) {
      debugPrint('erro postLogin: $error');
      return {'success': 'catch', 'message': 'Não foi possível fazer o Login'};
    }
  }

  Future<Map<String, dynamic>> _postCadastro(String mapToSend) async {
    debugPrint('postCadastro body $mapToSend');

    try {
      http.Response response = await http
          .post(
        Uri.parse('${Controller.url}auth/register'),
        headers: {
          "Content-Type": "application/json",
        },
        body: mapToSend,
      )
          .timeout(Duration(seconds: Controller.resquestDurationSecondsTime),
          onTimeout: () => http.Response(
            'timeout',
            408,
          ));

      debugPrint('postCadastro URL-> ${Controller.url}auth/register\n');
      debugPrint('postCadastro CODE-> ${response.statusCode}');
      debugPrint('postCadastro response->${response.body}');

      Map<String, dynamic> jsonData = json.decode(response.body);

      if (jsonData['success'].toString() == 'true') {
        carregarUsuario(jsonData);
        (await SharedPreferences.getInstance()).setString('token', usuario!.token.toString());
        return {
          'success': 'true',
        };
      } else {
        return {'success': 'false', 'message': jsonData['message'].toString()};
      }
    } catch (error) {
      debugPrint('erro postLogin: $error');
      return {'success': 'catch', 'message': 'Não foi possível fazer o Login'};
    }
  }
}
