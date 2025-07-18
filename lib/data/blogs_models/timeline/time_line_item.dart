class TimeLineItem {
  String? uniqueId;
  num? sourceItemId;
  num? itemType;
  String? timestamp;
  String? sourceUserId;
  String? sourceUserName;
  String? sourceUserProfilePictureUrl;
  String? blogPostTitle;
  String? blogPostSnippet;
  String? blogPostLinkUrl;
  num? blogPostUpvotes;
  num? blogPostDownvotes;
  num? blogPostCommentCount;
  num? blogPostCurrentUserVote;
  String? connectedWithUserId;
  String? connectedWithUserName;
  String? connectedWithProfilePictureUrl;
  String? connectionMessage;

  TimeLineItem({
    this.uniqueId,
    this.sourceItemId,
    this.itemType,
    this.timestamp,
    this.sourceUserId,
    this.sourceUserName,
    this.sourceUserProfilePictureUrl,
    this.blogPostTitle,
    this.blogPostSnippet,
    this.blogPostLinkUrl,
    this.blogPostUpvotes,
    this.blogPostDownvotes,
    this.blogPostCommentCount,
    this.blogPostCurrentUserVote,
    this.connectedWithUserId,
    this.connectedWithUserName,
    this.connectedWithProfilePictureUrl,
    this.connectionMessage,
  });

  TimeLineItem.fromJson(dynamic json) {
    uniqueId = json['uniqueId'];
    sourceItemId = json['sourceItemId'];
    itemType = json['itemType'];
    timestamp = json['timestamp'];
    sourceUserId = json['sourceUserId'];
    sourceUserName = json['sourceUserName'];
    sourceUserProfilePictureUrl = json['sourceUserProfilePictureUrl'];
    blogPostTitle = json['blogPostTitle'];
    blogPostSnippet = json['blogPostSnippet'];
    blogPostLinkUrl = json['blogPostLinkUrl'];
    blogPostUpvotes = json['blogPostUpvotes'];
    blogPostDownvotes = json['blogPostDownvotes'];
    blogPostCommentCount = json['blogPostCommentCount'];
    blogPostCurrentUserVote = json['blogPostCurrentUserVote'];
    connectedWithUserId = json['connectedWithUserId'];
    connectedWithUserName = json['connectedWithUserName'];
    connectedWithProfilePictureUrl = json['connectedWithProfilePictureUrl'];
    connectionMessage = json['connectionMessage'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uniqueId'] = uniqueId;
    map['sourceItemId'] = sourceItemId;
    map['itemType'] = itemType;
    map['timestamp'] = timestamp;
    map['sourceUserId'] = sourceUserId;
    map['sourceUserName'] = sourceUserName;
    map['sourceUserProfilePictureUrl'] = sourceUserProfilePictureUrl;
    map['blogPostTitle'] = blogPostTitle;
    map['blogPostSnippet'] = blogPostSnippet;
    map['blogPostLinkUrl'] = blogPostLinkUrl;
    map['blogPostUpvotes'] = blogPostUpvotes;
    map['blogPostDownvotes'] = blogPostDownvotes;
    map['blogPostCommentCount'] = blogPostCommentCount;
    map['blogPostCurrentUserVote'] = blogPostCurrentUserVote;
    map['connectedWithUserId'] = connectedWithUserId;
    map['connectedWithUserName'] = connectedWithUserName;
    map['connectedWithProfilePictureUrl'] = connectedWithProfilePictureUrl;
    map['connectionMessage'] = connectionMessage;
    return map;
  }
}
