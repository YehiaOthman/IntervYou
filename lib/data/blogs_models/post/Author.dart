class Author {
  String? userId;
  String? userName;
  String? profilePictureUrl;

  Author({
    this.userId,
    this.userName,
    this.profilePictureUrl,
  });

  Author.fromJson(dynamic json) {
    userId = json['userId'];
    userName = json['userName'];
    profilePictureUrl = json['profilePictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['userName'] = userName;
    map['profilePictureUrl'] = profilePictureUrl;
    return map;
  }
}
