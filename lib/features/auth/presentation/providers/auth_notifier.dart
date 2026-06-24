import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthNotifier extends StateNotifier<AsyncValue<UserEntity?>> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthNotifier({
  required this.loginUseCase,
  required this.registerUseCase,
})  : super(const AsyncData(null));

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await loginUseCase(
      LoginParams(
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) {
        state = AsyncError(
          failure.message,
          StackTrace.current,
        );
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    final result = await registerUseCase(
      RegisterParams(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) {
        state = AsyncError(
          failure.message,
          StackTrace.current,
        );
      },
      (user) {
        state = AsyncData(user);
      },
    );
  }

  void reset() {
    state = const AsyncData(null);
  }
}