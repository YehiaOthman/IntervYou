class Options {
  num? quizOptionId;
  String? text;

  Options({
    this.quizOptionId,
    this.text,
  });

  Options.fromJson(dynamic json) {
    quizOptionId = json['quizOptionId'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quizOptionId'] = quizOptionId;
    map['text'] = text;
    return map;
  }
}
