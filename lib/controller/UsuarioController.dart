import 'package:flutter_mvc/model/UsuarioModel.dart';
import 'package:get/get.dart';

class UsuarioController extends GetxController {
  Rx<UsuarioModel?> _usuarioModel = Rx<UsuarioModel?>(UsuarioModel());

  // Método para carregar dados do usuário a partir do JSON
  void carregarUsuario(Map<dynamic, dynamic> json) {
    _usuarioModel.value = UsuarioModel(json: json);
  }

  // Método para atualizar os dados do usuário
  void atualizarUsuario(UsuarioModel usuario) {
    _usuarioModel.value = usuario;
  }

  // Método para recuperar o usuário atual
  UsuarioModel? get usuario => _usuarioModel.value;

  // Método para limpar os dados do usuário
  void limparUsuario() {
    _usuarioModel.value = null;
  }
}
