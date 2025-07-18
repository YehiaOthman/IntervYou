import 'Author.dart';
import 'Comments.dart';

class PostDetailsDm {
  num? id;
  String? title;
  String? content;
  String? createdAt;
  String? updatedAt;
  Author? author;
  num? upvotes;
  num? downvotes;
  num? currentUserVote;
  List<Comments>? comments;

  PostDetailsDm({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.author,
    this.upvotes,
    this.downvotes,
    this.currentUserVote,
    this.comments,
  });

  PostDetailsDm.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    currentUserVote = json['currentUserVote'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['upvotes'] = upvotes;
    map['downvotes'] = downvotes;
    map['currentUserVote'] = currentUserVote;
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
