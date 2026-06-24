import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
  });

  factory UserModel.fromFirebase(
    User user,
  ) {
    final names = (user.displayName ?? '').split(' ');

    return UserModel(
      id: user.uid,
      firstName: names.isNotEmpty ? names.first : '',
      lastName: names.length > 1 ? names.sublist(1).join(' ') : '',
      email: user.email ?? '',
    );
  }
}