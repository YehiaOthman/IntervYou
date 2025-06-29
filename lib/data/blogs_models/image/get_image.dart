class GetImage {
  GetImage({
      this.profilePictureUrl,});

  GetImage.fromJson(dynamic json) {
    profilePictureUrl = json['profilePictureUrl'];
  }
  String? profilePictureUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['profilePictureUrl'] = profilePictureUrl;
    return map;
  }

}