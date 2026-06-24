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

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(
      key: ApiConstants.refreshTokenKey,
      value: refreshToken,
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
  Future<void> saveUserData({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    await _storage.write(key: 'user_id',         value: id);
    await _storage.write(key: 'user_first_name', value: firstName);
    await _storage.write(key: 'user_last_name',  value: lastName);
    await _storage.write(key: 'user_email',      value: email);
  }

  Future<String?> getUserId()        => _storage.read(key: 'user_id');
  Future<String?> getUserFirstName() => _storage.read(key: 'user_first_name');
  Future<String?> getUserLastName()  => _storage.read(key: 'user_last_name');
  Future<String?> getUserEmail()     => _storage.read(key: 'user_email');

  Future<void> clearAll() async {
      await _storage.deleteAll();
  }
}

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return const SecureStorageService(
    FlutterSecureStorage(),
  );
});