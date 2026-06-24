import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/features/auth/presentation/providers/auth_dependencies.dart';

final splashProvider = FutureProvider<bool>((ref) async {
  final isLoggedIn = ref.read(
    isLoggedInUseCaseProvider,
  );

  await Future.delayed(
    const Duration(seconds: 2),
  );

  return isLoggedIn();
});