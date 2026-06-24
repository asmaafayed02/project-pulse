import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/is_logged_in_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

final authRemoteDataSourceProvider =
    Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    ref.read(firebaseAuthProvider),
  );
});


final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authRepositoryProvider =
    Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
  );
});

final loginUseCaseProvider =
    Provider<LoginUseCase>((ref) {
  return LoginUseCase(
    ref.read(authRepositoryProvider),
  );
});

final registerUseCaseProvider =
    Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(
    ref.read(authRepositoryProvider),
  );
});

final logoutUseCaseProvider =
    Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(
    ref.read(authRepositoryProvider),
  );
});

final isLoggedInUseCaseProvider =
    Provider<IsLoggedInUseCase>((ref) {
  return IsLoggedInUseCase(
    ref.read(authRepositoryProvider),
  );
});