import 'package:jp_reading/data/shared_preferences.dart';

final List<Map<String, dynamic>> _progressList = [];

/// Initializes progress data by loading from SharedPreferences.
Future<void> loadProgressData() async {
  final loadedData = await loadData('progress_data');
  if (loadedData != null && loadedData is List) {
    _progressList
      ..clear()
      ..addAll(loadedData.map((e) => Map<String, dynamic>.from(e)));
  }
}

/// Saves the current progress list using shared_preferences.dart.
Future<void> saveProgressData() async {
  await saveData('progress_data', _progressList);
}

/// Updates progress for a given kana and persists it.
Future<void> updateProgress(String kana, int change) async {
  final existingIndex = _progressList.indexWhere((entry) => entry['kana'] == kana);

  if (existingIndex == -1) {
    if (change == 1) {
      _progressList.add({'kana': kana, 'progress': 1});
    } else if (change == -1) {
      _progressList.add({'kana': kana, 'progress': 0});
    }
  } else {
    final currentProgress = _progressList[existingIndex]['progress'];
    int newProgress = currentProgress + change;

    if (newProgress < 0) newProgress = 0;
    if (newProgress > 100) newProgress = 100;

    _progressList[existingIndex]['progress'] = newProgress;
  }

  await saveProgressData();
}

/// Returns an immutable copy of the progress list.
List<Map<String, dynamic>> getProgressList() {
  return List.unmodifiable(_progressList);
}
