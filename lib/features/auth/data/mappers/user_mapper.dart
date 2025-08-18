import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

/// Mapper class for converting between UserModel and UserEntity
/// Ensures clean separation between data and domain layers
class UserMapper {
  /// Converts UserModel (data layer) to UserEntity (domain layer)
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      publicId: model.publicId,
      email: model.email,
      username: model.username,
      firstName: model.firstName,
      roleName: model.roleName,
      roleId: model.roleId,
      isGuest: model.isGuest,
    );
  }

  /// Converts UserEntity (domain layer) to UserModel (data layer)
  static UserModel toModel(UserEntity entity) {
    return UserModel(
      publicId: entity.publicId,
      email: entity.email,
      username: entity.username,
      firstName: entity.firstName,
      isGuest: entity.isGuest,
    );
  }

  /// Converts list of UserModel to list of UserEntity
  static List<UserEntity> toEntityList(List<UserModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  /// Converts list of UserEntity to list of UserModel
  static List<UserModel> toModelList(List<UserEntity> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
}
