import 'dart:math';
import 'package:jp_reading/data/selected_count.dart';
import 'package:flutter/foundation.dart';

class Randomizer {
  static final Random _random = Random();

  static String? currentKana;

  /// Returns a random kana from the currently selected kana list
  /// Can repeat kanas, order is randomized every call
  static String getRandomKana() {
    final selectedKana = SelectedCount.selectedKana;
    if (selectedKana.isEmpty) return ''; // nothing selected

    // Pick a random index
    final index = _random.nextInt(selectedKana.length);
    final kana = selectedKana[index];

    // >>> This line is the fix <<<
    currentKana = kana; // store the kana so answer_check.dart can see it

    debugPrint('Random kana selected: $kana'); // Console message
    return kana;
  }

  /// Returns a list of N random kana (no immediate repeats)
  static List<String> getRandomKanaList(int count) {
    final selectedKana = SelectedCount.selectedKana;
    if (selectedKana.isEmpty) return [];

    final randomList = <String>[];

    // Track the last two kana to avoid repeating within 2 positions
    String? previousKana;
    String? secondPreviousKana;

    for (int i = 0; i < count; i++) {
      String kana;
      int safety = 0; // prevents infinite loop if not enough unique kana

      do {
        final index = _random.nextInt(selectedKana.length);
        kana = selectedKana[index];
        safety++;
      } while (
      selectedKana.length > 2 &&
          (kana == previousKana || kana == secondPreviousKana) &&
          safety < 100
      );

      randomList.add(kana);
      secondPreviousKana = previousKana;
      previousKana = kana;
    }

    debugPrint('Random kana list: $randomList');
    return randomList;
  }

}
