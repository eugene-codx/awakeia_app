// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      publicId: json['public_id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String?,
      roleName: json['role_name'] as String?,
      roleId: (json['role_id'] as num?)?.toInt(),
      isGuest: json['is_guest'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'email': instance.email,
      'username': instance.username,
      'first_name': instance.firstName,
      'role_name': instance.roleName,
      'role_id': instance.roleId,
      'is_guest': instance.isGuest,
    };
