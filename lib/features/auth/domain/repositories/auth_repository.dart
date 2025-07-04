import '../../data/models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> signIn(AuthModel user);
  Future<AuthModel> signUp(AuthModel user);
  Future<void> signOut();
  Future<void> refreshToken();
}
