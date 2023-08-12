import 'package:isar/isar.dart';

part 'ToDoModel.g.dart';

@collection
class ToDo {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment
  String? item;
  int? statusId;
  DateTime? dataCriacao;
  DateTime? dataConclusao;
  DateTime? dataMaximaConclusao;
}