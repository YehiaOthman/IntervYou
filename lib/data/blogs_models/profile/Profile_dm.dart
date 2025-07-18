class ProfileDataModel {
  String? userId;
  String? fullName;
  String? userName;
  dynamic profilePictureUrl;
  String? preferredRole;
  String? experienceLevel;
  String? summary;
  num? connectionsCount;
  dynamic connectionStatusWithCurrentUser;
  bool? isConnectionRequestSentByCurrentUser;
  bool? hasPendingRequestFromThisUser;

  ProfileDataModel({
    this.userId,
    this.fullName,
    this.userName,
    this.profilePictureUrl,
    this.preferredRole,
    this.experienceLevel,
    this.summary,
    this.connectionsCount,
    this.connectionStatusWithCurrentUser,
    this.isConnectionRequestSentByCurrentUser,
    this.hasPendingRequestFromThisUser,
  });

  ProfileDataModel.fromJson(dynamic json) {
    userId = json['userId'];
    fullName = json['fullName'];
    userName = json['userName'];
    profilePictureUrl = json['profilePictureUrl'];
    preferredRole = json['preferredRole'];
    experienceLevel = json['experienceLevel'];
    summary = json['summary'];
    connectionsCount = json['connectionsCount'];
    connectionStatusWithCurrentUser = json['connectionStatusWithCurrentUser'];
    isConnectionRequestSentByCurrentUser =
        json['isConnectionRequestSentByCurrentUser'];
    hasPendingRequestFromThisUser = json['hasPendingRequestFromThisUser'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['fullName'] = fullName;
    map['userName'] = userName;
    map['profilePictureUrl'] = profilePictureUrl;
    map['preferredRole'] = preferredRole;
    map['experienceLevel'] = experienceLevel;
    map['summary'] = summary;
    map['connectionsCount'] = connectionsCount;
    map['connectionStatusWithCurrentUser'] = connectionStatusWithCurrentUser;
    map['isConnectionRequestSentByCurrentUser'] =
        isConnectionRequestSentByCurrentUser;
    map['hasPendingRequestFromThisUser'] = hasPendingRequestFromThisUser;
    return map;
  }
}
