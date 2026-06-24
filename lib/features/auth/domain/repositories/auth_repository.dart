import 'package:project_pulse/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<bool> isLoggedIn();

  UserEntity? getCurrentUser();
}