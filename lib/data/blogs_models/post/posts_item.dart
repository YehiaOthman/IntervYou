import 'Author.dart';

class PostsItem {
  num? id;
  String? title;
  String? snippet;
  String? createdAt;
  String? updatedAt;
  Author? author;
  num? upvotes;
  num? downvotes;
  num? commentCount;
  num? currentUserVote;

  PostsItem({
      this.id, 
      this.title, 
      this.snippet, 
      this.createdAt, 
      this.updatedAt, 
      this.author, 
      this.upvotes, 
      this.downvotes, 
      this.commentCount, 
      this.currentUserVote,});

  PostsItem.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    snippet = json['snippet'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    commentCount = json['commentCount'];
    currentUserVote = json['currentUserVote'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['snippet'] = snippet;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['upvotes'] = upvotes;
    map['downvotes'] = downvotes;
    map['commentCount'] = commentCount;
    map['currentUserVote'] = currentUserVote;
    return map;
  }

}