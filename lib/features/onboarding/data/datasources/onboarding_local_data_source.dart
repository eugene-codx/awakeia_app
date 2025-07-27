import 'dart:convert';

import '../../../../core/storage/secure_storage.dart';
import '../../../../core/storage/storage_keys.dart';
import '../models/onboarding_model.dart';

/// Local data source for onboarding data
abstract class OnboardingLocalDataSource {
  /// Get saved onboarding state
  Future<OnboardingModel?> getOnboardingState();

  /// Save onboarding state
  Future<void> saveOnboardingState(OnboardingModel state);

  /// Clear onboarding state
  Future<void> clearOnboardingState();
}

/// Implementation of OnboardingLocalDataSource
class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  OnboardingLocalDataSourceImpl({required SecureStorage secureStorage})
      : _secureStorage = secureStorage;
  final SecureStorage _secureStorage;

  @override
  Future<OnboardingModel?> getOnboardingState() async {
    final jsonString =
        await _secureStorage.read(key: StorageKeys.onboardingCompleted);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return OnboardingModel.fromJson(json);
    } catch (e) {
      // If parsing fails, return null
      return null;
    }
  }

  @override
  Future<void> saveOnboardingState(OnboardingModel state) async {
    final json = state.toJson();
    await _secureStorage.write(
      key: StorageKeys.onboardingCompleted,
      value: jsonEncode(json),
    );
  }

  @override
  Future<void> clearOnboardingState() async {
    await _secureStorage.delete(key: StorageKeys.onboardingCompleted);
  }
}
