import 'package:choach_debate/features/Topics/domain/entities/topic_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel extends TopicEntity {
  @JsonKey(name: 'title')
  final String topicValue;

  const TopicModel({required this.topicValue}) : super(topic: topicValue);

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);

  static List<TopicModel> fromJsonList(List<dynamic> json) {
    if (json.isEmpty) return [];
    return json.map((data) => TopicModel.fromJson(data)).toList();
  }

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}
