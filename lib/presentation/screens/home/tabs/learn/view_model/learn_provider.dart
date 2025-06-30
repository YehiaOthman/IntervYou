import 'package:flutter/cupertino.dart';
import 'package:intervyou_app/data/api_manager.dart';
import 'package:intervyou_app/data/models/Topics.dart';

class LearnViewModel extends ChangeNotifier {
  bool loading = true;
  List<Topics> topics = [];
  late Topics currentTopic;
  int currentTopicIndex = 0;

  void getLearnData() async {
    loading = true;
    topics.clear();
    notifyListeners();
    var response = await ApiManger.getLearnData();
    if (response?.categories != null) {
      for (var category in response!.categories!) {
        topics.addAll(category.topics ?? []);
      }
    }
    isCurrentIndex();
    loading = false;
    notifyListeners();
  }

  void isCurrentIndex() {
    if (topics.isNotEmpty) {
      currentTopic = topics[0];
      currentTopicIndex = 0;
    }

    for (int i = 0; i < topics.length; i++) {
      final topic = topics[i];
      bool isTopicIncomplete = topic.progressPercentage != 100;

      if (isTopicIncomplete) {
        currentTopic = topic;
        currentTopicIndex = i;
        break;
      }
    }
  }

  Future<void> updateLearningPointStatus(num learningPointId) async {
    for (var topic in topics) {
      for (var subTopic in topic.subTopics ?? []) {
        int pointIndex = subTopic.learningPoints
            ?.indexWhere((p) => p.learningPointId == learningPointId) ??
            -1;

        if (pointIndex != -1) {
          final currentPoint = subTopic.learningPoints![pointIndex];
          final currentStatus = currentPoint.status ?? 0;
          final newStatus = currentStatus == 2 ? 1 : 2;

          final response = await ApiManger.updateLearningPointProgress(
              learningPointId, newStatus);

          if (response != null &&
              response.statusCode >= 200 &&
              response.statusCode < 300) {
            currentPoint.status = newStatus;
            notifyListeners();
          } else {
            print("Failed to update learning point status on the server.");
          }
          return;
        }
      }
    }
  }
}