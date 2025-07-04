import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);
  Future<AuthModel> call(AuthModel user) async {
    return repository.signUp(user);
  }
}
