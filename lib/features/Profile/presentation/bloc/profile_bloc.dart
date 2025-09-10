import 'package:choach_debate/core/error/failure.dart';
import 'package:choach_debate/features/Profile/domain/usecases/updateProfile_usecase.dart';
import 'package:choach_debate/features/Profile/domain/usecases/fetchProfile_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:choach_debate/features/Profile/domain/entities/profile_entity.dart';
part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  FetchprofileUsecase fetchProfileUseCase;
  UpdateprofileUsecase updateProfileUseCase;

  ProfileBloc({
    required this.fetchProfileUseCase,
    required this.updateProfileUseCase,
  }) : super(ProfileInitial()) {
    on<FetchProfilePressed>(_fetchProfilePressed);
    on<UpdateProfilePressed>(_updateProfilePressed);
  }

  void _fetchProfilePressed(
    FetchProfilePressed event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final data = await fetchProfileUseCase();

    data.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profileData) => emit(ProfileLoaded(profile: profileData)),
    );
  }

  void _updateProfilePressed(
    UpdateProfilePressed event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final data = ProfileEntity(
      userName: event.name,
      email: event.email,
      institusi: event.institusi,
    );

    final result = await updateProfileUseCase(data);

    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profileData) => emit(ProfileUpdate()),
    );
  }
}
