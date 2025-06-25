import '../user_info_item.dart';
import '../Pagination.dart';

class SearchProfile {
  List<UserInfoItem>? items;
  Pagination? pagination;
  SearchProfile({
    this.items,
    this.pagination,
  });

  SearchProfile.fromJson(dynamic json) {
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
