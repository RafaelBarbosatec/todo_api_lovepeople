import 'package:flutter/material.dart';
import 'package:todo_api/data/local/session_datasource.dart';
import 'package:todo_api/data/user_repository.dart';

class SignInController extends ChangeNotifier {
  final UserRepository userRepository;

  final SessionDatasource sessionDatasource;

  SignInController({
    required this.userRepository,
    required this.sessionDatasource,
  });

  void doSignIn({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function() onError,
  }) {
    userRepository
        .doSignIn(
      email: email,
      password: password,
    )
        .then(
      (session) {
        sessionDatasource.saveSession(session);
        return onSuccess();
      },
    ).catchError(
      (e) => onError(),
    );
  }

  void verifySession(Function() onLogged) {
    final session = sessionDatasource.getSession();
    if (session != null) {
      onLogged();
    }
  }
}
