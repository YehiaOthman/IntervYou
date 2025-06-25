import 'Author.dart';

class Comments {
  num? id;
  String? content;
  String? createdAt;
  String? updatedAt;
  Author? author;
  num? blogPostId;
  num? upvotes;
  num? downvotes;
  num? currentUserVote;
  num? parentCommentId;
  List<String>? replies;

  Comments({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.author,
    this.blogPostId,
    this.upvotes,
    this.downvotes,
    this.currentUserVote,
    this.parentCommentId,
    this.replies,
  });

  Comments.fromJson(dynamic json) {
    id = json['id'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    blogPostId = json['blogPostId'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    currentUserVote = json['currentUserVote'];
    parentCommentId = json['parentCommentId'];
    replies = json['replies'] != null ? json['replies'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['blogPostId'] = blogPostId;
    map['upvotes'] = upvotes;
    map['downvotes'] = downvotes;
    map['currentUserVote'] = currentUserVote;
    map['parentCommentId'] = parentCommentId;
    map['replies'] = replies;
    return map;
  }
}
