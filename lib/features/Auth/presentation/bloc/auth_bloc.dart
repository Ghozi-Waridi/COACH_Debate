import 'package:bloc/bloc.dart';
import 'package:choach_debate/features/Auth/domain/usecases/getCurrentUser_usecase.dart';
import 'package:choach_debate/features/Auth/domain/usecases/singIn_usecase.dart';
import 'package:choach_debate/features/Auth/domain/usecases/singOut_usecase.dart';
import 'package:choach_debate/features/Auth/domain/usecases/singUp_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  GetcurrentuserUsecase getCurrentUsecase;
  SinginUsecase singinUsecase;
  SingupUsecase singupUsecase;
  SingoutUsecase singOutUsecase;

  AuthBloc({
    required this.getCurrentUsecase,
    required this.singinUsecase,
    required this.singupUsecase,
    required this.singOutUsecase,
  }) : super(AuthInitial()) {
    on<LoginButtonPressed>(_loginPressed);
    on<SingUpButtonPressed>(_singupPressed);
    on<LogoutPressed>(_logoutPresed);
    on<GetCurrentUser>(_getCurrentUser);
  }

  void _loginPressed(LoginButtonPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await singinUsecase(event.email, event.password);
    result.fold((failure) => emit(AuthError(failure.message)), (user) {
      emit(AuthSuccess('Login berhasil! Selamat datang.'));
      emit(Authenticated(user));
    });
  }

  void _singupPressed(
    SingUpButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await singupUsecase(
      event.email,
      event.password,
      event.user!,
    );
    result.fold((failure) => emit(AuthError(failure.message)), (user) {
      emit(AuthSuccess('Registrasi berhasil! Akun Anda telah dibuat.'));
      emit(Authenticated(user));
    });
  }

  void _logoutPresed(LogoutPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await singOutUsecase();
    result.fold((failure) => emit(AuthError(failure.message)), (_) {
      emit(AuthSuccess('Logout berhasil. Sampai jumpa!'));
      emit(UnAuthenticated());
    });
  }

  void _getCurrentUser(GetCurrentUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await getCurrentUsecase();
    result.fold((failure) => emit(AuthError(failure.message)), (user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    });
  }
}
