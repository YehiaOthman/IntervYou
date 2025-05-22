import 'LearningPoints.dart';

class SubTopics { // Milestones
  num? subTopicId;
  String? name;
  String? description;
  num? estimatedHours;
  String? contentUrl;
  num? status;
  num? progressPercentage;
  bool? isQuizPassed;
  List<LearningPoints>? learningPoints; // list of subTopics in milestone

  SubTopics({
    this.subTopicId,
    this.name,
    this.description,
    this.estimatedHours,
    this.contentUrl,
    this.status,
    this.progressPercentage,
    this.isQuizPassed,
    this.learningPoints,
  });

  SubTopics.fromJson(dynamic json) {
    subTopicId = json['subTopicId'];
    name = json['name'];
    description = json['description'];
    estimatedHours = json['estimatedHours'];
    contentUrl = json['contentUrl'];
    status = json['status'];
    progressPercentage = json['progressPercentage'];
    isQuizPassed = json['isQuizPassed'];
    if (json['learningPoints'] != null) {
      learningPoints = [];
      json['learningPoints'].forEach((v) {
        learningPoints?.add(LearningPoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subTopicId'] = subTopicId;
    map['name'] = name;
    map['description'] = description;
    map['estimatedHours'] = estimatedHours;
    map['contentUrl'] = contentUrl;
    map['status'] = status;
    map['progressPercentage'] = progressPercentage;
    map['isQuizPassed'] = isQuizPassed;
    if (learningPoints != null) {
      map['learningPoints'] = learningPoints?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
