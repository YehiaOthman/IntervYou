class ConnectionStatus {
  String? targetUserId;
  String? status;

  ConnectionStatus({
    this.targetUserId,
    this.status,
  });

  ConnectionStatus.fromJson(dynamic json) {
    targetUserId = json['targetUserId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['targetUserId'] = targetUserId;
    map['status'] = status;
    return map;
  }
}
