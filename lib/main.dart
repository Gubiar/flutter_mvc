import 'package:flutter/material.dart';
import 'package:flutter_mvc/controller/ThemeController.dart';
import 'package:flutter_mvc/controller/UsuarioController.dart';
import 'package:flutter_mvc/resources/color_schemes.g.dart';
import 'package:flutter_mvc/view/PageHome.dart';
import 'package:flutter_mvc/view/PageLogin.dart';
import 'package:flutter_mvc/view/PageSplash.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UsuarioController());
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter MVC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: 'Roboto',
      ),
      themeMode: ThemeMode.system,
      getPages: [
        GetPage(name: '/', page: () => const PageSplash()),
        GetPage(name: '/PageLogin', page: () => PageLogin()),
        GetPage(name: '/PageHome', page: () => PageHome()),
      ],
    );
  }
}
