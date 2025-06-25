class ConnectionsItem {
  num? connectionId;
  String? userId;
  String? userName;
  String? profilePictureUrl;
  num? status;
  String? requestedAt;
  String? actionedAt;
  bool? isInitiatedByCurrentUser;


  ConnectionsItem({
      this.connectionId, 
      this.userId, 
      this.userName, 
      this.profilePictureUrl, 
      this.status, 
      this.requestedAt, 
      this.actionedAt, 
      this.isInitiatedByCurrentUser,});
  ConnectionsItem.fromJson(dynamic json) {
    connectionId = json['connectionId'];
    userId = json['userId'];
    userName = json['userName'];
    profilePictureUrl = json['profilePictureUrl'];
    status = json['status'];
    requestedAt = json['requestedAt'];
    actionedAt = json['actionedAt'];
    isInitiatedByCurrentUser = json['isInitiatedByCurrentUser'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['connectionId'] = connectionId;
    map['userId'] = userId;
    map['userName'] = userName;
    map['profilePictureUrl'] = profilePictureUrl;
    map['status'] = status;
    map['requestedAt'] = requestedAt;
    map['actionedAt'] = actionedAt;
    map['isInitiatedByCurrentUser'] = isInitiatedByCurrentUser;
    return map;
  }

}