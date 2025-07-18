import '../../../../core/storage/secure_storage.dart';
import '../models/user_model.dart';

/// Abstract class defining the contract for local authentication operations
abstract class AuthLocalDataSource {
  /// Cache user data locally
  Future<void> cacheUser(UserModel user);

  /// Get cached user data
  /// Returns null if no cached data
  Future<UserModel?> getCachedUser();

  /// Clear cached user data
  Future<void> clearCachedUser();

  /// Cache auth token
  Future<void> cacheAuthToken(String token);

  /// Get cached auth token
  /// Returns null if no token
  Future<String?> getCachedAuthToken();

  /// Clear cached auth token
  Future<void> clearCachedAuthToken();

  /// Check if user is guest
  Future<bool> isGuestUser();
}

/// Implementation of AuthLocalDataSource using SecureStorage
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required SecureStorage secureStorage,
  }) : _secureStorage = secureStorage;
  final SecureStorage _secureStorage;

  static const String _userKey = 'cached_user';
  static const String _tokenKey = 'auth_token';
  static const String _guestKey = 'is_guest';

  @override
  Future<void> cacheUser(UserModel user) async {
    final userJson = user.toJson();
    await _secureStorage.write(
      key: _userKey,
      value: userJson as String,
    );

    // Also cache if user is guest
    await _secureStorage.write(
      key: _guestKey,
      value: user.isGuest.toString(),
    );
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = await _secureStorage.read(key: _userKey);
    if (userJson != null) {
      return UserModel.fromJson(userJson as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<void> clearCachedUser() async {
    await _secureStorage.delete(key: _userKey);
    await _secureStorage.delete(key: _guestKey);
  }

  @override
  Future<void> cacheAuthToken(String token) async {
    await _secureStorage.write(
      key: _tokenKey,
      value: token,
    );
  }

  @override
  Future<String?> getCachedAuthToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> clearCachedAuthToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  @override
  Future<bool> isGuestUser() async {
    final isGuest = await _secureStorage.read(key: _guestKey);
    return isGuest == 'true';
  }
}
