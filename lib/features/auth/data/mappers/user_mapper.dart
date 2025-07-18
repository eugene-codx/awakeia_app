import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

/// Mapper class for converting between UserModel and UserEntity
/// Ensures clean separation between data and domain layers
class UserMapper {
  /// Converts UserModel (data layer) to UserEntity (domain layer)
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      email: model.email,
      name: model.name,
      createdAt: model.createdAt,
      isGuest: model.isGuest,
    );
  }

  /// Converts UserEntity (domain layer) to UserModel (data layer)
  static UserModel toModel(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      createdAt: entity.createdAt,
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
