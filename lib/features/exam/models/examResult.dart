class ExamResult {
  ExamResult({
    required this.id,
    required this.languageId,
    required this.title,
    required this.date,
    required this.examKey,
    required this.duration,
    required this.status,
    required this.totalDuration,
    required this.statistics,
  });

  late final String id;
  late final String languageId;
  late final String title;
  late final String date;
  late final String examKey;
  late final String duration;
  late final String status;
  late final String totalDuration;
  late final List<Statistics> statistics;

  late final String totalMarks;

  ExamResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageId = json['language_id'];
    title = json['title'];
    date = json['date'];
    examKey = json['exam_key'];
    duration = json['duration'];
    status = json['status'];
    totalDuration = json['total_duration'] ?? "0";

    totalMarks = json['total_marks'] ?? "0";
    statistics = List.from(json['statistics'] ?? [])
        .map((e) => Statistics.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['language_id'] = languageId;
    data['title'] = title;
    data['date'] = date;
    data['exam_key'] = examKey;
    data['duration'] = duration;
    data['status'] = status;
    data['total_duration'] = totalDuration;
    data['statistics'] = statistics.map((e) => e.toJson()).toList();

    data['total_marks'] = totalMarks;
    return data;
  }

  int obtainedMarks() {
    int totalObtainedMarks = 0;
    for (var markStatistics in statistics) {
      totalObtainedMarks = totalObtainedMarks +
          int.parse(markStatistics.mark) *
              int.parse(markStatistics.correctAnswer);
    }

    return totalObtainedMarks;
  }

  int totalQuestions() {
    int totalQuestion = 0;
    for (var markStatistics in statistics) {
      totalQuestion = totalQuestion +
          int.parse(markStatistics.correctAnswer) +
          int.parse(markStatistics.incorrect);
    }
    return totalQuestion;
  }

  int totalCorrectAnswers() {
    int correctAnswers = 0;
    for (var markStatistics in statistics) {
      correctAnswers = correctAnswers + int.parse(markStatistics.correctAnswer);
    }
    return correctAnswers;
  }

  int totalInCorrectAnswers() {
    int inCorrectAnswers = 0;
    for (var markStatistics in statistics) {
      inCorrectAnswers = inCorrectAnswers + int.parse(markStatistics.incorrect);
    }
    return inCorrectAnswers;
  }

  int totalQuestionsByMark(String questionMark) {
    Statistics statistics = _getStatisticsByMark(questionMark);
    return (int.parse(statistics.correctAnswer) +
        int.parse(statistics.incorrect));
  }

  int totalInCorrectAnswersByMark(String questionMark) {
    Statistics statistics = _getStatisticsByMark(questionMark);
    return int.parse(statistics.incorrect);
  }

  int totalCorrectAnswersByMark(String questionMark) {
    Statistics statistics = _getStatisticsByMark(questionMark);
    return int.parse(statistics.correctAnswer);
  }

  Statistics _getStatisticsByMark(String questionMark) {
    return statistics
        .where((element) => element.mark == questionMark)
        .toList()
        .first;
  }

  List<String> getUniqueMarksOfQuestion() {
    return statistics.map((e) => e.mark).toList();
  }
}

class Statistics {
  Statistics({
    required this.mark,
    required this.correctAnswer,
    required this.incorrect,
  });

  late final String mark;
  late final String correctAnswer;
  late final String incorrect;

  Statistics.fromJson(Map<String, dynamic> json) {
    mark = json['mark'];
    correctAnswer = json['correct_answer'];
    incorrect = json['incorrect'];
  }

  Map<String, dynamic> toJson() => {
        'mark': mark,
        'correct_answer': correctAnswer,
        'incorrect': incorrect,
      };
}
