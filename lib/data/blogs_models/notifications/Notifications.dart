import '../Pagination.dart';
import 'notifications_Item.dart';


class Notifications {
  List<NotificationsItem>? items;
  Pagination? pagination;

  Notifications({
      this.items, 
      this.pagination,});

  Notifications.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(NotificationsItem.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
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