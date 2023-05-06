import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  static const isDev = kDebugMode;
  static const url = "https://server-gubiar.vercel.app/";
  static int resquestDurationSecondsTime = isDev ? 360 : 20;
}