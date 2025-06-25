import 'package:intervyou_app/data/blogs_models/user_info_item.dart';

import '../Pagination.dart';

class SuggestionConnection {
  List<UserInfoItem>? items;
  Pagination? pagination;


  SuggestionConnection({
    this.items,
    this.pagination,
  });

  SuggestionConnection.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(UserInfoItem.fromJson(v));
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
