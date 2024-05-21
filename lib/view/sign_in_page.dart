import 'package:flutter/material.dart';
import 'package:todo_api/controllers/sign_in_controller.dart';
import 'package:todo_api/core/dio_client.dart';
import 'package:todo_api/data/user_repository.dart';
import 'package:todo_api/main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInController controller;

  @override
  void initState() {
    controller = SignInController(
      userRepository: UserRepository(DioClient.create()),
      sessionDatasource: sessionDatasource,
    );
    Future.delayed(Duration.zero, () {
      controller.verifySession(_goHome);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _doSignIn,
          child: const Text('Sign In'),
        ),
      ),
    );
  }

  void _doSignIn() {
    controller.doSignIn(
      email: 'rafaelbarbosatec@gmail.com',
      password: '12345678',
      onSuccess: _goHome,
      onError: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login ou senha invalidos'),
          ),
        );
      },
    );
  }

  void _goHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }
}
