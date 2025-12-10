part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  ProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdate extends ProfileState {
  final String message;

  ProfileUpdate({this.message = 'Profil berhasil diperbarui'});

  @override
  List<Object?> get props => [message];
}
