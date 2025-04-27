class PostDataModel {
  String userName;
  String dateTime;
  String imgUrl;
  String postContent;
  String? postImgUrl;
  int voteCount;
  int commentCount;

  PostDataModel({
    required this.userName,
    required this.dateTime,
    required this.imgUrl,
    required this.postContent,
    this.postImgUrl,
    required this.voteCount,
    required this.commentCount,
  });
}