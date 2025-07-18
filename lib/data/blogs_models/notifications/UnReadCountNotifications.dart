class UnReadCountNotifications {
  num? unreadCount;



  UnReadCountNotifications({
      this.unreadCount,});
  UnReadCountNotifications.fromJson(dynamic json) {
    unreadCount = json['unreadCount'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unreadCount'] = unreadCount;
    return map;
  }

}