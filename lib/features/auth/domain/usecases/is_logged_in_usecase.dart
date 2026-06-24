import '../repositories/auth_repository.dart';

class IsLoggedInUseCase {
  final AuthRepository _repository;

  IsLoggedInUseCase(this._repository);

  Future<bool> call() {
    return _repository.isLoggedIn();
  }
}