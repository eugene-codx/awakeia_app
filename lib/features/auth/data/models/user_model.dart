import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Data model for User with JSON serialization support
/// This model is used in the data layer for API communication and local storage
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? name,
    required DateTime createdAt,
    @Default(false) bool isGuest,
  }) = _UserModel;

  const UserModel._();

  /// Creates UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Custom JSON serialization for DateTime
  Map<String, dynamic> toJsonWithCustomDate() {
    return toJson()..['createdAt'] = createdAt.toIso8601String();
  }
}
