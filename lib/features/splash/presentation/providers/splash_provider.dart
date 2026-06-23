import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_pulse/core/services/secure_storage_service.dart';

final splashProvider = FutureProvider<bool>((ref) async {
    await Future.delayed(const Duration(seconds: 2));

  final storage = ref.read(secureStorageProvider);
  final token = await storage.getToken();
  return token != null && token.isNotEmpty;
});