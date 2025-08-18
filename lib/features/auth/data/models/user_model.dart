import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data model for User with JSON serialization support
/// This model is used in the data layer for API communication and local storage
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String publicId,
    required String email,
    required String username,
    String? firstName,
    String? roleName,
    int? roleId,
    @Default(false) bool isGuest,
  }) = _UserModel;

  const UserModel._();

  /// Creates UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Get display name - returns firstName if available, otherwise username
  String get displayName => firstName ?? username;

  /// Check if user has completed profile
  bool get hasCompletedProfile => firstName != null && firstName!.isNotEmpty;
}
