import 'package:choach_debate/features/Topics/domain/entities/topic_entity.dart';
import 'package:choach_debate/features/Topics/domain/usecases/get_categori_usecase.dart';
import 'package:choach_debate/features/Topics/domain/usecases/get_topic_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'topics_event.dart';
part 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final GetTopicUsecase getTopicUsecase;
  final GetCategoriUsecase getCategoriUsecase;

  TopicsBloc({required this.getTopicUsecase, required this.getCategoriUsecase})
    : super(TopicsInitial()) {
    
    on<GetTopicsEvent>((event, emit) async {
      emit(TopicsLoadingState());
      try {
        final categories = await getCategoriUsecase();
        emit(GetCategoriesState(categories: categories));
      } catch (e) {
        emit(TopicsErrorState(message: e.toString()));
      }
    });

    on<GetCategoryTopicsEvent>((event, emit) async {
      emit(TopicsLoadingState());
      try {
        final topics = await getTopicUsecase(event.category);
        emit(GetTopicsState(topics: topics));
      } catch (e) {
        emit(TopicsErrorState(message: e.toString()));
      }
    });
  }
}
