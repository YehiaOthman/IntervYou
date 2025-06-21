class submitQuizResponse {
  final int subTopicId;
  final int scorePercentage;
  final bool isPassed;
  final int correctAnswers;
  final int totalQuestions;

  submitQuizResponse({
    required this.subTopicId,
    required this.scorePercentage,
    required this.isPassed,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  factory submitQuizResponse.fromJson(Map<String, dynamic> json) {
    return submitQuizResponse(
      subTopicId: json['subTopicId'],
      scorePercentage: json['scorePercentage'],
      isPassed: json['isPassed'],
      correctAnswers: json['correctAnswers'],
      totalQuestions: json['totalQuestions'],
    );
  }
}
