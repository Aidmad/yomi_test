import 'dart:developer';
import 'package:jp_reading/functions/test_screen/count_rounds.dart';

class TestResults {
  final List<Map<String, String>> _results = [];
  int _lastRecordedRound = 0;

  /// Called from answer_check.dart after each kana check.
  void saveSingleResult(String kana, String result) {
    final int currentRound = getCurrentRoundCount();

    // Detect start of new test (round count reset)
    if (currentRound < _lastRecordedRound) {
      _results.clear();
      log('[TestResults] New test started — previous results cleared.');
    }

    _lastRecordedRound = currentRound;

    // Only save if under 10 results
    if (_results.length < 10) {
      _results.add({'kana': kana, 'result': result});
      log('[TestResults] $kana: $result');
    }

    // When 10th kana recorded, print all results once
    if (_results.length == 10) {
      _printFinalResults();
    }
  }

  /// Print all results after 10th kana
  void _printFinalResults() {
    log('=== Test Completed (10 Kana) ===');
    for (final entry in _results) {
      log('${entry['kana']}: ${entry['result']}');
    }
  }

  /// Manually clear results (optional)
  void clearResults() {
    _results.clear();
    _lastRecordedRound = 0;
    log('[TestResults] Results cleared manually.');
  }

  /// Return unmodifiable copy of current results
  List<Map<String, String>> getResults() {
    return List.unmodifiable(_results);
  }
}

/// Shared singleton instance accessible anywhere
final TestResults testResults = TestResults();
