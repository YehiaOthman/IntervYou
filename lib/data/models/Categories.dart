import 'Topics.dart';

class Categories {
  num? categoryId;
  String? name;
  List<Topics>? topics; // list of roadMap phases

  Categories({
    this.categoryId,
    this.name,
    this.topics,
  });

  Categories.fromJson(dynamic json) {
    categoryId = json['categoryId'];
    name = json['name'];
    if (json['topics'] != null) {
      topics = [];
      json['topics'].forEach((v) {
        topics?.add(Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['name'] = name;
    if (topics != null) {
      map['topics'] = topics?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
