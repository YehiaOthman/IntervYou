class LearningPoints { // inside milestones
  num? learningPointId;
  String? name;
  dynamic contentUrl;
  dynamic description;
  num? status;

  LearningPoints({
    this.learningPointId,
    this.name,
    this.contentUrl,
    this.description,
    this.status,
  });

  LearningPoints.fromJson(dynamic json) {
    learningPointId = json['learningPointId'];
    name = json['name'];
    contentUrl = json['contentUrl'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['learningPointId'] = learningPointId;
    map['name'] = name;
    map['contentUrl'] = contentUrl;
    map['description'] = description;
    map['status'] = status;
    return map;
  }
}
