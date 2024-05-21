import 'package:flutter/material.dart';
import 'package:todo_api/data/local/session_datasource.dart';
import 'package:todo_api/view/home_page.dart';
import 'package:todo_api/view/sign_in_page.dart';

const baseUrl = 'https://todo.rafaelbarbosatec.com/api/';
SessionDatasource sessionDatasource = SessionDatasource();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sessionDatasource.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (_) => const SignInPage(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}
