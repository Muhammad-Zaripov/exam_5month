import '../repositories/auth_repository.dart';

class RefreshToken {
  final AuthRepository repository;
  RefreshToken(this.repository);

  Future<void> call() async {
    await repository.refreshToken();
  }
}
