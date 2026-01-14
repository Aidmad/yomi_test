import 'package:flutter/material.dart';
import 'package:jp_reading/functions/test_screen/randomize.dart';
import 'package:jp_reading/functions/test_screen/count_rounds.dart';

class NextKanaController {
  NextKanaController._privateConstructor();

  static final NextKanaController instance = NextKanaController._privateConstructor();

  late List<String> _kanaList;
  int _currentIndex = 1;

  final ValueNotifier<String> currentKanaNotifier = ValueNotifier<String>('');

  /// Initialize with first kana from Randomizer when screen opens
  void initialize() {
    _kanaList = Randomizer.getRandomKanaList(10); // fetch list from Randomizer
    if (_kanaList.isNotEmpty) {
      _currentIndex = 0;
      final firstKana = _kanaList[_currentIndex];
      currentKanaNotifier.value = firstKana;
      Randomizer.currentKana = firstKana;
      initializeRoundCount();
    }
  }

  /// Triggered by answer_check.dart to show next kana
  void notifyNext() {
    if (_kanaList.isEmpty) return;

    // Check if user has already completed all rounds before showing new kana
    if (getCurrentRoundCount() >= 10) {
      // Do NOT update kana — just trigger navigation logic through updateRoundCount()
      updateRoundCount();
      return;
    }

    _currentIndex++;
    if (_currentIndex >= _kanaList.length) {
      _currentIndex = 0;
    }

    final nextKana = _kanaList[_currentIndex];
    currentKanaNotifier.value = nextKana;
    Randomizer.currentKana = nextKana;

    updateRoundCount();
  }


}
