import '../Pagination.dart';
import 'connections_items.dart';

class PendingConnections {
  List<ConnectionsItem>? items;
  Pagination? pagination;

  PendingConnections({
      this.items, 
      this.pagination,});

  PendingConnections.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(ConnectionsItem.fromJson(v));
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