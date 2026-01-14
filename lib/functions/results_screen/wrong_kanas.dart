import 'package:jp_reading/data/test_results.dart';
import 'package:jp_reading/data/hiragana.dart';
import 'package:jp_reading/data/dakuon.dart';
import 'package:jp_reading/data/handakuon.dart';
import 'package:jp_reading/data/yoon.dart';

class WrongKanas {
  static List<Map<String, String>> getWrongKanaList() {
    final results = testResults.getResults();

    return results
        .where((entry) => entry['result'] == 'wrong')
        .map((entry) {
      final String? kana = entry['kana'];
      if (kana == null) return null;

      // Hiragana
      for (final h in hiraganaList) {
        if (h.hiragana == kana) {
          return {'kana': kana, 'romaji': h.romaji};
        }
      }

      // Dakuon
      for (final d in dakuonList) {
        if (d.dakuon == kana) {
          return {'kana': kana, 'romaji': d.romaji};
        }
      }

      // Handakuon
      for (final h in handakuonList) {
        if (h.handakuon == kana) {
          return {'kana': kana, 'romaji': h.romaji};
        }
      }

      // Yoon
      for (final y in yoonList) {
        if (y.yoon == kana) {
          return {'kana': kana, 'romaji': y.romaji};
        }
      }

      // Fallback (should not happen, but safe)
      return {'kana': kana, 'romaji': ''};
    })
        .whereType<Map<String, String>>()
        .toList();
  }
}
