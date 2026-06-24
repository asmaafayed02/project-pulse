
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:project_pulse/core/errors/failures.dart';
import 'package:project_pulse/core/errors/firebase_error_mapper.dart';
import 'package:project_pulse/features/auth/data/models/user_model.dart';
import 'package:project_pulse/features/auth/domain/entities/user_entity.dart';
import 'package:project_pulse/features/auth/domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

 @override
Future<Either<Failure, UserEntity>> login({
  required String email,
  required String password,
}) async {
  try {
    final credential = await _remoteDataSource.login(
      email: email,
      password: password,
    );

    return Right(
      UserModel.fromFirebase(
        credential.user!,
      ),
    );
  } on FirebaseAuthException catch (e) {
    return Left(
      AuthFailure(
    FirebaseErrorMapper.map(e),
        ),
    );
  }
}

@override
Future<Either<Failure, UserEntity>> register({
  required String firstName,
  required String lastName,
  required String email,
  required String password,
}) async {
  try {
    final credential = await _remoteDataSource.register(
      email: email,
      password: password,
    );

    await credential.user?.updateDisplayName(
      '$firstName $lastName',
    );
    await credential.user?.reload();

    return Right(
      UserModel(
        id: credential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
      ),
    );
  } on FirebaseAuthException catch (e) {
    return Left(
      AuthFailure(
        FirebaseErrorMapper.map(e),
      ),
    );
  }
}

@override
Future<Either<Failure, void>> logout() async {
  try {
    await _remoteDataSource.logout();
    return const Right(null);
  } catch (e) {
    return Left(
      ServerFailure(
        e.toString(),
      ),
    );
  }
}
@override
UserEntity? getCurrentUser() {
  final user = _remoteDataSource.getCurrentUser();

  if (user == null) {
    return null;
  }

  return UserModel.fromFirebase(user);
}
  
Future<bool> isLoggedIn() async {
  try {
    final user = _remoteDataSource.getCurrentUser();

    if (user == null) {
      return false;
    }

    await user.reload();

    return _remoteDataSource.getCurrentUser() != null;
  } catch (_) {
    await _remoteDataSource.logout();
    return false;
  }
}
}