import 'package:firebase_auth/firebase_auth.dart';

import 'models/user_model.dart';
import 'repositories/auth_local_repository.dart';

class AuthRemoteDatasource {
  final firebaseAuth = FirebaseAuth.instance;
  final AuthLocalDatasource authLocalDatasource = AuthLocalDatasource();

  Future<AuthModel> signIn(AuthModel user) async {
    final token = await firebaseAuth.signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    authLocalDatasource.saveToken(token.toString());
    return user;
  }

  Future<AuthModel> signUp(AuthModel user) async {
    final token = await firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    authLocalDatasource.saveToken(token.toString());
    return user;
  }

  Future<void> signOut() async {
    authLocalDatasource.getToken();
    await firebaseAuth.signOut();
  }

  Future<void> refreshToken() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      final newToken = await user.getIdToken(true);
      await authLocalDatasource.saveToken(newToken.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // Future<String?> checkUser(String email) async {
  //   final response = await getIt<DioClient>().get(NetworkPath.users);
  //   final users = response.data as Map;
  //   String? id;
  //   users.forEach((key, value) {
  //     if (email == value['email']) {
  //       id = key;
  //     }
  //   });
  //   return id;
  // }
}
