import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/Controller.dart';
import 'package:flutter_mvc/controller/UsuarioController.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioServices {
  final UsuarioController _usuarioController = Get.find();

  Future<Map<String, dynamic>> postLogin(String login, String senha) async {
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
        _usuarioController.carregarUsuario(jsonData);
        (await SharedPreferences.getInstance()).setString('token', _usuarioController.usuario!.token.toString());
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

  Future<Map<String, dynamic>> postCadastro(String mapToSend) async {
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
        _usuarioController.carregarUsuario(jsonData);
        (await SharedPreferences.getInstance()).setString('token', _usuarioController.usuario!.token.toString());
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
