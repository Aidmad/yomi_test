import 'package:jp_reading/data/test_results.dart';
import 'package:jp_reading/data/progress_data.dart';

/// Reads kana test results and updates progress for each kana individually.
/// No lists or aggregations are created here — each kana entry is processed
/// exactly as it appears in test_results.
void calculateProgress() {
  final results = testResults.getResults();

  for (final entry in results) {
    final kana = entry['kana'];
    final result = entry['result'];

    if (kana == null || result == null) continue;

    if (result == 'correct') {
      updateProgress(kana, 1);
    } else if (result == 'wrong') {
      updateProgress(kana, -1);
    }
  }
}
