import 'package:flutter/material.dart';
import 'package:todo_api/data/local/session_datasource.dart';
import 'package:todo_api/data/model/todo_model.dart';
import 'package:todo_api/data/todo_repository.dart';

class HomeController extends ChangeNotifier {
  final TodoRepository todoRepository;
  final SessionDatasource sessionDatasource;

  List<TodoModel> todoList = [];

  HomeController({
    required this.todoRepository,
    required this.sessionDatasource,
  });

  void getTodoList() {
    todoRepository.getTodoList().then((e) {
      todoList = e;
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }

  void loggout(Function() callback) async {
    await sessionDatasource.deleteSession();
    callback();
  }
}
