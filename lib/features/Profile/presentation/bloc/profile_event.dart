part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class FetchProfilePressed extends ProfileEvent {}

class UpdateProfilePressed extends ProfileEvent {
  final String name;
  final String email;
  final String institusi;

  const UpdateProfilePressed({
    required this.name,
    required this.email,
    required this.institusi,
  });

  @override
  List<Object?> get props => [name, email, institusi];
}
