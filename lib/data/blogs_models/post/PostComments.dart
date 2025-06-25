import 'package:intervyou_app/data/blogs_models/post/Comments.dart';
import '../Pagination.dart';

class PostComments {
  List<Comments>? items;
  Pagination? pagination;

  PostComments({
    this.items,
    this.pagination,
  });

  PostComments.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(Comments.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}
