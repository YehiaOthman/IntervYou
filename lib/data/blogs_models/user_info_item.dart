class UserInfoItem {
  String? userId;
  String? userName;
  String? profilePictureUrl;
  String? currentRoleOrHeadline;

  UserInfoItem({
      this.userId, 
      this.userName, 
      this.profilePictureUrl, 
      this.currentRoleOrHeadline,});

  UserInfoItem.fromJson(dynamic json) {
    userId = json['userId'];
    userName = json['userName'];
    profilePictureUrl = json['profilePictureUrl'];
    currentRoleOrHeadline = json['currentRoleOrHeadline'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['userName'] = userName;
    map['profilePictureUrl'] = profilePictureUrl;
    map['currentRoleOrHeadline'] = currentRoleOrHeadline;
    return map;
  }

}