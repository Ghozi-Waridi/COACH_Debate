import 'package:bloc/bloc.dart';
import 'package:choach_debate/features/History/domain/entities/history_entity.dart';
import 'package:choach_debate/features/History/domain/usecases/GetAllHistory_usecase.dart';
import 'package:choach_debate/features/History/domain/usecases/GetHIstory_usecase.dart';
import 'package:choach_debate/features/History/domain/usecases/DeleteHistory_usecase.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GethistoryUsecase getHistoryUsecase;
  final GetallhistoryUsecase getAllHistoryUsecase;
  final DeleteHistoryUsecase deleteHistoryUsecase;

  final String session_id = '';
  HistoryBloc({
    required this.getHistoryUsecase,
    required this.getAllHistoryUsecase,
    required this.deleteHistoryUsecase,
  }) : super(HistoryInitial()) {
    on<GetHistoryEvent>(getHistory);
    on<GetAllHistoryEvent>(getAllHistory);
    on<DeleteHistoryEvent>(deleteHistory);
  }

  Future<void> getHistory(
    GetHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final result = await getHistoryUsecase(event.session_id);
      emit(HistoryDetaulLoaded(result));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> getAllHistory(
    GetAllHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading());
    try {
      final result = await getAllHistoryUsecase();
      emit(HistoryLoaded(result));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> deleteHistory(
    DeleteHistoryEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      // Hapus session
      await deleteHistoryUsecase(event.sessionId);

      // Emit loading state
      emit(HistoryLoading());

      // Reload history langsung setelah delete berhasil
      final result = await getAllHistoryUsecase();
      emit(HistoryLoaded(result));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
