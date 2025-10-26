part of 'topics_bloc.dart';

abstract class TopicsEvent extends Equatable {
  const TopicsEvent();

  @override
  List<Object> get props => [];
}

class GetTopicsEvent extends TopicsEvent {
  const GetTopicsEvent();

  @override
  List<Object> get props => [];
}

class GetCategoryTopicsEvent extends TopicsEvent {
  final String category;
  const GetCategoryTopicsEvent({required this.category});

  @override
  List<Object> get props => [category];
}
