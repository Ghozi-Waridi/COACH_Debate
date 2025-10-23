import 'package:choach_debate/features/Topics/domain/entities/topic_entity.dart';

class TopicModel extends TopicEntity {
  const TopicModel({required super.topic});

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(topic: json['title']);
  }

  static List<TopicModel> fromJsonList(List<dynamic> json) {
    if (json.isEmpty) return [];
    return json.map((data) => TopicModel.fromJson(data)).toList();
  }

  Map<String, dynamic> toJson() {
    return {'topic': topic};
  }
}
