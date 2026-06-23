import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api/api_constants.dart';

class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> saveToken(String token) async {
    await _storage.write(
      key: ApiConstants.tokenKey,
      value: token,
    );
  }

  Future<String?> getToken() {
    return _storage.read(
      key: ApiConstants.tokenKey,
    );
  }

  Future<void> deleteToken() async {
    await _storage.delete(
      key: ApiConstants.tokenKey,
    );
  }
}

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return const SecureStorageService(
    FlutterSecureStorage(),
  );
});