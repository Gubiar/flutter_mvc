import 'package:flutter/material.dart';
import 'package:flutter_mvc/resources/color_schemes.g.dart';
import 'package:flutter_mvc/view/PageLogin.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      getPages: [
        GetPage(name: '/', page: () => const PageLogin()),
      ],
    );
  }
}
