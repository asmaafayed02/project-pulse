import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../providers/auth_dependencies.dart';
import 'auth_notifier.dart';
import '../../domain/entities/user_entity.dart';

final authProvider =
    StateNotifierProvider<
        AuthNotifier,
        AsyncValue<UserEntity?>>(
  (ref) {
    return AuthNotifier(
      loginUseCase: ref.read(
        loginUseCaseProvider,
      ),
      registerUseCase: ref.read(
        registerUseCaseProvider,
      ),
    );
  },
);