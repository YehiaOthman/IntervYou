import 'SubTopics.dart';

class Topics { // Road map phases
  num? topicId;
  String? name;
  num? estimatedHours;
  num? status;
  bool? recommendedFocus;
  num? progressPercentage;
  List<SubTopics>? subTopics;

  Topics({
    this.topicId,
    this.name,
    this.estimatedHours,
    this.status,
    this.recommendedFocus,
    this.progressPercentage,
    this.subTopics,
  });

  Topics.fromJson(dynamic json) {
    topicId = json['topicId'];
    name = json['name'];
    estimatedHours = json['estimatedHours'];
    status = json['status'];
    recommendedFocus = json['recommendedFocus'];
    progressPercentage = json['progressPercentage'];
    if (json['subTopics'] != null) {
      subTopics = [];
      json['subTopics'].forEach((v) {
        subTopics?.add(SubTopics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['topicId'] = topicId;
    map['name'] = name;
    map['estimatedHours'] = estimatedHours;
    map['status'] = status;
    map['recommendedFocus'] = recommendedFocus;
    map['progressPercentage'] = progressPercentage;
    if (subTopics != null) {
      map['subTopics'] = subTopics?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
