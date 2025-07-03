import '../../domain/repositories/auth_repository.dart';
import '../auth_repository_datasurce.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);
  @override
  Future<AuthModel> signIn(AuthModel user) {
    return authRemoteDatasource.signIn(user);
  }

  @override
  Future<AuthModel> signUp(AuthModel user) {
    return authRemoteDatasource.signUp(user);
  }

  @override
  Future<void> signOut() {
    return authRemoteDatasource.signOut();
  }

  @override
  Future<void> refreshToken() async {
    await authRemoteDatasource.refreshToken();
  }
}
