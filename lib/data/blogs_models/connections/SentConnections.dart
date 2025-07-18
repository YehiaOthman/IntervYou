import 'package:intervyou_app/data/blogs_models/connections/connections_items.dart';
import '../Pagination.dart';

class SentConnections {
  List<ConnectionsItem>? items;
  Pagination? pagination;


  SentConnections({
    this.items,
    this.pagination,
  });

  SentConnections.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(ConnectionsItem.fromJson(v));
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
