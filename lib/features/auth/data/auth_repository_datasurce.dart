import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/auth_model.dart';
import 'models/user_model.dart';
import 'repositories/auth_local_repository.dart';

class AuthRemoteDatasource {
  final firebaseAuth = FirebaseAuth.instance;
  final authLocalDatasource = AuthLocalDatasource();

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

    final uid = token.user?.uid;
    if (uid != null) {
      final dbRef = FirebaseDatabase.instance.ref();
      await dbRef.child('user').child(uid).set({
        'email': user.email,
        'createdAt': DateTime.now().toIso8601String(),
      });
    }

    return user;
  }

  Future<void> completeProfile(String name, String phone) async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) return;

    final dbRef = FirebaseDatabase.instance.ref();
    await dbRef.child('user').child(uid).update({
      'name': name,
      'phone': phone,
      'updatedAt': DateTime.now().toIso8601String(),
    });
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

  Future<UserModel?> getUserData() async {
    final uid = firebaseAuth.currentUser?.uid;
    if (uid == null) return null;

    final snapshot = await FirebaseDatabase.instance
        .ref()
        .child('user')
        .child(uid)
        .get();

    if (snapshot.exists) {
      return UserModel.fromJson(
        Map<String, dynamic>.from(snapshot.value as Map),
        uid,
      );
    }

    return null;
  }
  
}
