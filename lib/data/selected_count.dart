import 'package:flutter/foundation.dart';
import 'package:jp_reading/data/shared_preferences.dart';

class SelectedCount {
  static int _selectedBlocks = 0;
  static final List<String> _selectedKana = [];
  static final Map<String, ValueNotifier<bool>> _kanaNotifiers = {};

  static void registerKana(String kana) {
    if (!_kanaNotifiers.containsKey(kana)) {
      _kanaNotifiers[kana] = ValueNotifier<bool>(_selectedKana.contains(kana));
    }
  }

  static ValueNotifier<bool> getNotifier(String kana) {
    registerKana(kana);
    return _kanaNotifiers[kana]!;
  }

  static void updateSelection(bool isSelected, String kana) async {
    if (isSelected) {
      if (!_selectedKana.contains(kana)) {
        _selectedKana.add(kana);
        _selectedBlocks++; // always increment
      }
    } else {
      if (_selectedKana.remove(kana)) {
        if (_selectedBlocks > 0) _selectedBlocks--;
      }
    }

    // Update notifier
    if (_kanaNotifiers.containsKey(kana)) {
      _kanaNotifiers[kana]!.value = _selectedKana.contains(kana);
    }

    // Save only first 10
    await _saveToPrefs(); // save current state
  }

  static int get count => _selectedBlocks;
  static List<String> get selectedKana => List.unmodifiable(_selectedKana);

  static void reset() async {
    _selectedKana.clear();
    _selectedBlocks = 0;
    for (var notifier in _kanaNotifiers.values) {
      notifier.value = false;
    }
    await _saveToPrefs();
  }

  // Save current data
  static Future<void> _saveToPrefs() async {
    await saveSelectedKanaData({
      'selectedBlocks': _selectedBlocks,
      'selectedKana': _selectedKana,
    });
  }

  // Load saved data at startup
  static Future<void> loadFromPrefs() async {
    final data = await loadSelectedKanaData();
    if (data != null) {
      _selectedBlocks = data['selectedBlocks'] ?? 0;
      final List<dynamic>? kanaList = data['selectedKana'] as List<dynamic>?;
      if (kanaList != null) {
        _selectedKana
          ..clear()
          ..addAll(kanaList.map((e) => e.toString()));
      }
      for (var kana in _selectedKana) {
        registerKana(kana);
      }
    }
  }
}
