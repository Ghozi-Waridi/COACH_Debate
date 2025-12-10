import 'package:bloc/bloc.dart';
import 'package:choach_debate/features/Analis/domain/usecases/get_analytics_usecase.dart';
import 'package:choach_debate/features/Analis/domain/usecases/get_recent_sessions_usecase.dart';
import 'package:choach_debate/features/Analis/presentation/bloc/analis_event.dart';
import 'package:choach_debate/features/Analis/presentation/bloc/analis_state.dart';

/// BLoC untuk mengelola state Analis
class AnalisBloc extends Bloc<AnalisEvent, AnalisState> {
  final GetAnalyticsUseCase getAnalyticsUseCase;
  final GetRecentSessionsUseCase getRecentSessionsUseCase;

  AnalisBloc({
    required this.getAnalyticsUseCase,
    required this.getRecentSessionsUseCase,
  }) : super(const AnalisInitial()) {
    on<LoadAnalisDataEvent>(_onLoadAnalisData);
    on<RefreshAnalisDataEvent>(_onRefreshAnalisData);
  }

  Future<void> _onLoadAnalisData(
    LoadAnalisDataEvent event,
    Emitter<AnalisState> emit,
  ) async {
    emit(const AnalisLoading());
    await _loadData(emit);
  }

  Future<void> _onRefreshAnalisData(
    RefreshAnalisDataEvent event,
    Emitter<AnalisState> emit,
  ) async {
    // Tidak emit loading saat refresh untuk UX yang lebih baik
    await _loadData(emit);
  }

  Future<void> _loadData(Emitter<AnalisState> emit) async {
    // Load analytics dan recent sessions secara paralel
    final analyticsResult = await getAnalyticsUseCase();
    final sessionsResult = await getRecentSessionsUseCase(limit: 5);

    // Handle hasil
    analyticsResult.fold(
      (failure) {
        emit(AnalisError(message: failure.message));
      },
      (analytics) {
        sessionsResult.fold(
          (failure) {
            emit(AnalisError(message: failure.message));
          },
          (sessions) {
            emit(AnalisLoaded(analytics: analytics, recentSessions: sessions));
          },
        );
      },
    );
  }
}
