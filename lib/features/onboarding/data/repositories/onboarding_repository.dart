import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/storage/secure_storage.dart';
import '../../../../core/storage/storage_keys.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/onboarding_entity.dart';

abstract class OnboardingRepository {
  Future<OnboardingEntity> getState({required int defaultTotalSteps});

  Future<void> saveState(OnboardingEntity entity);

  Future<void> markCompleted({required int totalSteps});

  Future<void> reset() async {}
}

/// Implementation of OnboardingRepository
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this.secureStorage);

  final SecureStorage secureStorage;

  @override
  Future<OnboardingEntity> getState({required int defaultTotalSteps}) async {
    final jsonString =
        await secureStorage.read(key: StorageKeys.onboardingCompleted);
    if (jsonString == null) {
      return OnboardingEntity(currentStep: 0, totalSteps: defaultTotalSteps);
    }
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return OnboardingEntity.fromJson(json);
    } catch (_) {
      // If parsing fails, then start from the beginning
      return OnboardingEntity(currentStep: 0, totalSteps: defaultTotalSteps);
    }
  }

  @override
  Future<void> saveState(OnboardingEntity entity) async {
    await secureStorage.write(
      key: StorageKeys.onboardingCompleted,
      value: jsonEncode(entity.toJson()),
    );
  }

  @override
  Future<void> markCompleted({required int totalSteps}) async {
    final completed =
        OnboardingEntity(currentStep: totalSteps, totalSteps: totalSteps);
    await saveState(completed);
  }

  @override
  Future<void> reset() async {
    await secureStorage.delete(key: StorageKeys.onboardingCompleted);
  }
}

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return OnboardingRepositoryImpl(storage);
});
