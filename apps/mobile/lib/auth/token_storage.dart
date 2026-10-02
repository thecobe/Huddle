import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persistenza del refresh token (Keychain su iOS, Keystore su Android) e della società scelta.
abstract class TokenStorage {
  Future<String?> readRefreshToken();
  Future<void> writeRefreshToken(String? token);
  Future<String?> readClubId();
  Future<void> writeClubId(String? clubId);
}

class SecureTokenStorage implements TokenStorage {
  static const _refreshKey = 'huddle.refreshToken';
  static const _clubKey = 'huddle.clubId';
  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> readRefreshToken() => _storage.read(key: _refreshKey);

  @override
  Future<void> writeRefreshToken(String? token) =>
      token == null ? _storage.delete(key: _refreshKey) : _storage.write(key: _refreshKey, value: token);

  @override
  Future<String?> readClubId() => _storage.read(key: _clubKey);

  @override
  Future<void> writeClubId(String? clubId) =>
      clubId == null ? _storage.delete(key: _clubKey) : _storage.write(key: _clubKey, value: clubId);
}

/// Solo per i test.
class MemoryTokenStorage implements TokenStorage {
  String? refreshToken;
  String? clubId;

  @override
  Future<String?> readRefreshToken() async => refreshToken;
  @override
  Future<void> writeRefreshToken(String? token) async => refreshToken = token;
  @override
  Future<String?> readClubId() async => clubId;
  @override
  Future<void> writeClubId(String? value) async => clubId = value;
}
