import 'package:jp_reading/data/progress_data.dart';
import 'dart:developer';

/// Returns true if any kana has 100% progress
bool checkProgress() {
  final progressList = getProgressList();
  bool hasAny = false;

  for (final entry in progressList) {
    if (entry['progress'] == 100) {
      log('Kana reached 100 progress: ${entry['kana']}');
      hasAny = true;
    }
  }

  if (!hasAny) log('No kana has reached 100 progress');
  return hasAny;
}

int getProgressOfKana(String kana) {
  final progressList = getProgressList();

  // Return a default entry with 0 progress if not found
  final entry = progressList.firstWhere(
        (e) => e['kana'] == kana,
    orElse: () => {'kana': kana, 'progress': 0},
  );

  if (entry['progress'] is int) {
    return entry['progress'] as int;
  }

  return 0;
}
