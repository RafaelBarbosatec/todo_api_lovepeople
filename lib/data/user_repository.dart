import 'package:dio/dio.dart';
import 'package:todo_api/data/model/sign_in_response.dart';

class UserRepository {
  static const signPath = 'auth/local';
  final Dio dio;

  UserRepository(this.dio);

  Future<SignInResponse> doSignIn({
    required String email,
    required String password,
  }) async {
    return dio.post(
      signPath,
      data: {
        'identifier': email,
        'password': password,
      },
    ).then((e) {
      return SignInResponse.fromMap(e.data);
    });
  }
}
