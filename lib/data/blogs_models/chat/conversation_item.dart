class ConversationsItem {
  String? otherUserId;
  String? otherUserName;
  String? otherUserProfilePictureUrl;
  String? lastMessageSnippet;
  String? lastMessageAt;
  num? unreadMessagesCount;
  ConversationsItem({
      this.otherUserId, 
      this.otherUserName, 
      this.otherUserProfilePictureUrl, 
      this.lastMessageSnippet, 
      this.lastMessageAt, 
      this.unreadMessagesCount,});

  ConversationsItem.fromJson(dynamic json) {
    otherUserId = json['otherUserId'];
    otherUserName = json['otherUserName'];
    otherUserProfilePictureUrl = json['otherUserProfilePictureUrl'];
    lastMessageSnippet = json['lastMessageSnippet'];
    lastMessageAt = json['lastMessageAt'];
    unreadMessagesCount = json['unreadMessagesCount'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otherUserId'] = otherUserId;
    map['otherUserName'] = otherUserName;
    map['otherUserProfilePictureUrl'] = otherUserProfilePictureUrl;
    map['lastMessageSnippet'] = lastMessageSnippet;
    map['lastMessageAt'] = lastMessageAt;
    map['unreadMessagesCount'] = unreadMessagesCount;
    return map;
  }

}