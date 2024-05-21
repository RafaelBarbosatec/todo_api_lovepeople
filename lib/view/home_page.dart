import 'package:flutter/material.dart';
import 'package:todo_api/controllers/home_controller.dart';
import 'package:todo_api/core/dio_client.dart';
import 'package:todo_api/data/todo_repository.dart';
import 'package:todo_api/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;

  @override
  void initState() {
    controller = HomeController(
      todoRepository: TodoRepository(
        DioClient.create(),
        sessionDatasource,
      ),
      sessionDatasource: sessionDatasource,
    );
    controller.getTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              controller.loggout((){
                Navigator.pushReplacementNamed(context, '/');
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return ListView.builder(
            itemCount: controller.todoList.length,
            itemBuilder: (context, index) {
              final todo = controller.todoList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
