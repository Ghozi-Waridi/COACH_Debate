part of 'topics_bloc.dart';

abstract class TopicsState extends Equatable {
  const TopicsState();

  @override
  List<Object> get props => [];
}

class TopicsInitial extends TopicsState {}

class TopicsLoadingState extends TopicsState {}

class GetTopicsState extends TopicsState {
  final List<TopicEntity> topics;

  const GetTopicsState({required this.topics});

  @override
  List<Object> get props => [topics];
}

class GetCategoriesState extends TopicsState {
  final List<String> categories;

  const GetCategoriesState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class TopicsErrorState extends TopicsState {
  final String message;

  const TopicsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
