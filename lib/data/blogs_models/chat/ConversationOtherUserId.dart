import '../Pagination.dart';
import 'conversation_other_user_id_item.dart';


class ConversationOtherUserId {
  List<ConversationOtherUserIdItem>? items;
  Pagination? pagination;
  ConversationOtherUserId({

      this.items,
      this.pagination,});

  ConversationOtherUserId.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(ConversationOtherUserIdItem.fromJson(v));
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