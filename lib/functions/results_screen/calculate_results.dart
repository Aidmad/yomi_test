import 'dart:developer';
import 'package:jp_reading/data/test_results.dart';

double latestPercentage = 0.0;

void calculateResult() {
  // Use the globally shared 'testResults' instance from test_results.dart
  final results = testResults.getResults();

  if (results.isEmpty) {
    log('[Result] No results to calculate.');
    latestPercentage = 0.0;
    return;
  }

  final int totalKana = results.length;
  final int correctCount =
      results.where((entry) => entry['result'] == 'correct').length;
  final double percentage = (correctCount / totalKana) * 100;

  latestPercentage = percentage;

  log('=== Test Summary ===');
  log('Total kana tested: $totalKana');
  log('Correct answers: $correctCount');
  log('Wrong answers: ${totalKana - correctCount}');
  log('Score: ${percentage.toStringAsFixed(2)}%');
}
