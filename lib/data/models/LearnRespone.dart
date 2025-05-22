import 'Categories.dart';

class LearnResponse {
  String? userId;
  List<Categories>? categories; //[backEnd , frontEnd , flutter ,....]

  LearnResponse({
    this.userId,
    this.categories,
  });

  LearnResponse.fromJson(dynamic json) {
    userId = json['userId'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
