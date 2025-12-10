import 'package:choach_debate/features/Profile/domain/entities/profile_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.userName,
    required super.email,
    required super.institusi,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
