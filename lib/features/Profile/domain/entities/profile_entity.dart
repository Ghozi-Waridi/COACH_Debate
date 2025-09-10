import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String userName;
  final String email;
  final String institusi;

  ProfileEntity({
    required this.userName,
    required this.email,
    required this.institusi,
  });

  @override
  List<Object?> get props => [userName, email, institusi];
}
