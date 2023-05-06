import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs(); // Carrega o tema salvo no SharedPreferences
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToPrefs(); // Salva o tema atual no SharedPreferences
  }

  // Carrega o tema salvo no SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkModeOn = prefs.getBool('isDarkMode');
    if (isDarkModeOn != null) {
      isDarkMode.value = isDarkModeOn;
      Get.changeThemeMode(isDarkModeOn ? ThemeMode.dark : ThemeMode.light);
    } else {
      isDarkMode.value = Get.isDarkMode;
      print('inicializando tema - IsDark -> ${Get.isDarkMode}');
    }
  }

  // Salva o tema atual no SharedPreferences
  Future<void> _saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode.value);
  }
}
