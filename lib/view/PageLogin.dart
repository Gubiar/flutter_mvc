import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/UsuarioController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PageLogin extends StatelessWidget {
  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;
  RxBool isLogin = true.obs;
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();
  final repetirSenhaController = TextEditingController();
  final UsuarioController _usuarioController = Get.find();

  PageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
             onPressed: () => Get.changeThemeMode(Get.isDarkMode? ThemeMode.light: ThemeMode.dark),
              icon: Icon(
                Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Get.isDarkMode ? Colors.white : Colors.black87,
              )
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Obx(() => Column(
              children: [

                isLogin.value ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/images/account.svg',
                        width: Get.width * 0.4,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: Get.width * 0.9,
                        child: Column(
                          children: [
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() => TextField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: senhaController,
                              obscureText: isObscure.value,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: 'Senha',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      (isObscure.value)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 20,
                                      color: const Color(0xff231942),
                                    ),
                                    onPressed: () =>
                                    isObscure.value = !isObscure.value,
                                  )),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          isLoading.value = true;
                          bool loginValido = await _usuarioController.fazerLogin(email: emailController.text, senha: senhaController.text);
                          isLoading.value = false;
                          if (loginValido) {
                            Get.offAllNamed('/PageHome');
                          }
                        },
                        child: Container(
                          width: Get.width * 0.9,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark
                          ),
                          child: Obx(() => ((isLoading.value) ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,

                          ) : const Text(
                            'Entrar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            ),
                          ))),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextButton(
                          onPressed: () => isLogin.value = false,
                          child: const Text(
                            "Não tem conta? Clique aqui",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                      )
                    ]) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/images/account.svg',
                        width: Get.width * 0.4,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: Get.width * 0.9,
                        child: Column(
                          children: [

                            TextField(
                              keyboardType: TextInputType.text,
                              controller: nomeController,
                              decoration: InputDecoration(
                                labelText: 'Nome',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            Obx(() => TextField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isObscure.value,
                              controller: senhaController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: 'Senha',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      (isObscure.value)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 20,
                                      color: const Color(0xff231942),
                                    ),
                                    onPressed: () =>
                                    isObscure.value = !isObscure.value,
                                  )),
                            )),

                            const SizedBox(
                              height: 20,
                            ),

                            Obx(() => TextField(
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isObscure.value,
                              controller: repetirSenhaController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: 'Repetir Senha',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      (isObscure.value)
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 20,
                                      color: const Color(0xff231942),
                                    ),
                                    onPressed: () =>
                                    isObscure.value = !isObscure.value,
                                  )),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          isLoading.value = true;
                          bool cadastroValido = await _usuarioController.fazerCadastro(nome: nomeController.text, email: emailController.text, senha: senhaController.text, repetirSenha: repetirSenhaController.text);
                          isLoading.value = false;
                          if (cadastroValido) {
                            Get.offAllNamed('/PageHome');
                          }
                        },
                        child: Container(
                          width: Get.width * 0.9,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Get.isDarkMode ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark
                          ),
                          child: Obx(() => ((isLoading.value) ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ) : const Text(
                            'Cadastrar',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            ),
                          ))),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextButton(
                          onPressed: () => isLogin.value = true,
                          child: const Text(
                            "Já é cadastrado? Faça o login",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                      )
                    ])

              ],
            )),
          ),
        ),
      )
    );
  }
}
