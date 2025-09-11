import 'package:choach_debate/features/Profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.userName,
    required super.email,
    required super.institusi,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      institusi: json['institusi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'email': email, 'institusi': institusi};
  }
}
