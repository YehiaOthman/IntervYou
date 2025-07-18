class ConversationOtherUserIdItem {
  ConversationOtherUserIdItem({
      this.id, 
      this.senderId, 
      this.senderName, 
      this.senderProfilePictureUrl, 
      this.receiverId, 
      this.content, 
      this.sentAt, 
      this.isRead, 
      this.readAt,});

  ConversationOtherUserIdItem.fromJson(dynamic json) {
    id = json['id'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    senderProfilePictureUrl = json['senderProfilePictureUrl'];
    receiverId = json['receiverId'];
    content = json['content'];
    sentAt = json['sentAt'];
    isRead = json['isRead'];
    readAt = json['readAt'];
  }
  String? id;
  String? senderId;
  String? senderName;
  String? senderProfilePictureUrl;
  String? receiverId;
  String? content;
  String? sentAt;
  bool? isRead;
  String? readAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['senderId'] = senderId;
    map['senderName'] = senderName;
    map['senderProfilePictureUrl'] = senderProfilePictureUrl;
    map['receiverId'] = receiverId;
    map['content'] = content;
    map['sentAt'] = sentAt;
    map['isRead'] = isRead;
    map['readAt'] = readAt;
    return map;
  }

}