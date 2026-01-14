import 'package:jp_reading/data/progress_data.dart';
import 'package:jp_reading/data/hiragana.dart';
import 'package:jp_reading/data/dakuon.dart';
import 'package:jp_reading/data/handakuon.dart';
import 'package:jp_reading/data/full_progress.dart';
import 'package:jp_reading/functions/progress_check.dart';
import 'dart:developer';

/// Filters saved kana to keep only those in Hiragana, Dakuon, or Handakuon lists
/// and transfers them to full_progress.dart
void checkType() {
  final progressList = getProgressList(); // all saved kana

  // Temporary collection of matched kana
  final matchedKana = <Map<String, dynamic>>[];

  for (final entry in progressList) {
    final kana = entry['kana'];
    final progress = entry['progress'];

    if (hiraganaList.any((h) => h.hiragana == kana)) {
      matchedKana.add({
        'kana': kana,
        'progress': progress,
        'list': 'hiragana',
      });
    } else if (dakuonList.any((d) => d.dakuon == kana)) {
      matchedKana.add({
        'kana': kana,
        'progress': progress,
        'list': 'dakuon',
      });
    } else if (handakuonList.any((h) => h.handakuon == kana)) {
      matchedKana.add({
        'kana': kana,
        'progress': progress,
        'list': 'handakuon',
      });
    }
  }

  if (matchedKana.isNotEmpty) {
    log('Transferring matched kana to full_progress.dart: $matchedKana');
    saveMatchedKana(matchedKana); // send to full_progress.dart
  }

  // Optional: still call global progress check
  checkProgress();
}
