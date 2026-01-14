import 'package:jp_reading/functions/progress_check.dart';
import 'package:jp_reading/data/hiragana.dart';
import 'package:jp_reading/data/dakuon.dart';
import 'package:jp_reading/data/handakuon.dart';

// Stores fully completed kana
final List<Map<String, dynamic>> _fullProgressKana = [];

// Tracks which lists have ever been fully completed
final Set<String> firstTimeCompletedLists = {};

// Saves matched kana received from check_type.dart
void saveMatchedKana(List<Map<String, dynamic>> kanaList) {
  _fullProgressKana.clear();

  for (final entry in kanaList) {
    final kana = entry['kana'];
    final listName = entry['list'];
    final progress = getProgressOfKana(kana);

    if (progress == 100) {
      _fullProgressKana.add({
        'kana': kana,
        'progress': progress,
        'list': listName,
      });
    }
  }

  // Permanently track first-time completion
  updateFirstTimeCompletedLists();
}

// Permanently mark lists that have ever been fully completed
void updateFirstTimeCompletedLists() {
  if (!firstTimeCompletedLists.contains('hiragana') &&
      _fullProgressKana.where((e) => e['list'] == 'hiragana').length == hiraganaList.length) {
    firstTimeCompletedLists.add('hiragana');
  }

  if (!firstTimeCompletedLists.contains('dakuon') &&
      _fullProgressKana.where((e) => e['list'] == 'dakuon').length == dakuonList.length) {
    firstTimeCompletedLists.add('dakuon');
  }

  if (!firstTimeCompletedLists.contains('handakuon') &&
      _fullProgressKana.where((e) => e['list'] == 'handakuon').length == handakuonList.length) {
    firstTimeCompletedLists.add('handakuon');
  }
}

// Returns a copy of fully completed kana
List<Map<String, dynamic>> getFullProgressKana() =>
    List.unmodifiable(_fullProgressKana);

// Returns true if a list has ever been fully completed
bool isFirstTimeCompleted(String listName) =>
    firstTimeCompletedLists.contains(listName);
