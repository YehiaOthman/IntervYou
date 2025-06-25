class NotificationsItem {
  num? id;
  num? type;
  String? message;
  String? linkUrl;
  String? createdAt;
  bool? isRead;
  dynamic readAt;
  String? sourceUserId;
  String? sourceUserName;
  String? sourceUserProfilePictureUrl;
  dynamic relatedEntityId;
  String? relatedEntityType;
  NotificationsItem({
    this.id,
    this.type,
    this.message,
    this.linkUrl,
    this.createdAt,
    this.isRead,
    this.readAt,
    this.sourceUserId,
    this.sourceUserName,
    this.sourceUserProfilePictureUrl,
    this.relatedEntityId,
    this.relatedEntityType,
  });

  NotificationsItem.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    message = json['message'];
    linkUrl = json['linkUrl'];
    createdAt = json['createdAt'];
    isRead = json['isRead'];
    readAt = json['readAt'];
    sourceUserId = json['sourceUserId'];
    sourceUserName = json['sourceUserName'];
    sourceUserProfilePictureUrl = json['sourceUserProfilePictureUrl'];
    relatedEntityId = json['relatedEntityId'];
    relatedEntityType = json['relatedEntityType'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['message'] = message;
    map['linkUrl'] = linkUrl;
    map['createdAt'] = createdAt;
    map['isRead'] = isRead;
    map['readAt'] = readAt;
    map['sourceUserId'] = sourceUserId;
    map['sourceUserName'] = sourceUserName;
    map['sourceUserProfilePictureUrl'] = sourceUserProfilePictureUrl;
    map['relatedEntityId'] = relatedEntityId;
    map['relatedEntityType'] = relatedEntityType;
    return map;
  }
}
