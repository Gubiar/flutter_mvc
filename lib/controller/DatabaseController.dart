import 'package:flutter_mvc/model/toDoModel/ToDoModel.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' show Directory;

class DatabaseController extends GetxController {
  late Isar _isar;
  late Directory _dir;


  Future<void> initDB() async {
     _dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [ToDoSchema],
      directory: _dir.path,
    );
  }

  Isar? get isar => _isar;

  Directory? get dir => _dir;
}
