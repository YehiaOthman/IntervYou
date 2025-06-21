import 'package:flutter/cupertino.dart';
import 'package:intervyou_app/data/models/Topics.dart';

import '../../../../../../data/api_manager.dart';


class LearnViewModel extends ChangeNotifier {
  bool loading = false;
  List<Topics> topics =[];
  late Topics currentTopic;
  late int currentTopicIndex = 0;

  void getLearnData() async {
    loading = true;
    notifyListeners();
    var response = await ApiManger.getLearnData();
    for(var category in response!.categories!) {
      topics.addAll(category.topics!);
    }
    isCurrentIndex();
    loading = false;
    notifyListeners();
  }
  void isCurrentIndex() {
    for (int i = 0; i < topics.length; i++) {
      final topic = topics[i];

      bool isTopicComplete = topic.progressPercentage == 100 &&
          (topic.subTopics?.every((sub) => sub.isQuizPassed == true) ?? false);

      if (!isTopicComplete) {
        currentTopic = topic;
        currentTopicIndex = i;
        break;
      }
    }
  }



}
