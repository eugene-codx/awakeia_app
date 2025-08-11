import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// Domain entity representing a user in the application
/// This is a pure business model without any data layer dependencies
@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    required String username,
    String? name,
    required DateTime createdAt,
    @Default(false) bool isGuest,
  }) = _UserEntity;

  const UserEntity._();

  /// Get display name - returns name if available, otherwise email prefix
  String get displayName => name ?? email.split('@').first;

  /// Check if user has completed profile
  bool get hasCompletedProfile => name != null && name!.isNotEmpty;
}
