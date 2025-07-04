import '../../data/models/auth_model.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;
  SignInUseCase(this.repository);

  Future<AuthModel> call(AuthModel user) async {
    return repository.signIn(user);
  }
}
