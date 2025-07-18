import 'package:intervyou_app/data/blogs_models/post/posts_item.dart';

import '../Pagination.dart';


class AuthorPosts {
  List<PostsItem>? items;
  Pagination? pagination;

  AuthorPosts({
    this.items,
    this.pagination,
  });

  AuthorPosts.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(PostsItem.fromJson(v));
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
