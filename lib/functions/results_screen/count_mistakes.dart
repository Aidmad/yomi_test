import 'package:jp_reading/data/test_results.dart';

/// Dynamically calculates total wrong answers
String get totalWrongAnswers {
  return testResults
      .getResults()
      .where((entry) => entry['result'] != 'correct')
      .length
      .toString();
}
