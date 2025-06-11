import 'Options.dart';

class DailyQuizzes {
  num? quizQuestionId;
  String? text;
  num? order;
  List<Options>? options;

  DailyQuizzes({
    this.quizQuestionId,
    this.text,
    this.order,
    this.options,
  });

  DailyQuizzes.fromJson(dynamic json) {
    quizQuestionId = json['quizQuestionId'];
    text = json['text'];
    order = json['order'];
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quizQuestionId'] = quizQuestionId;
    map['text'] = text;
    map['order'] = order;
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
