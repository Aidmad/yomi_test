import 'dart:developer' as developer;
import 'package:flutter/scheduler.dart';
import 'package:jp_reading/navigation/navigation_root.dart';
import 'package:jp_reading/functions/results_screen/calculate_results.dart';

int _roundCount = 0;
const int _maxRounds = 10;

/// Called by next_kana.dart when the app starts.
void initializeRoundCount() {
  _roundCount = 1; // start display as 1/10
  developer.log('$_roundCount/$_maxRounds', name: 'RoundCounter');
}

/// Called by next_kana.dart after each next kana is displayed.
void updateRoundCount() {
  // Increment first, so console and UI stay consistent
  _roundCount++;

  // If user has completed all 10 rounds, navigate to results
  if (_roundCount > _maxRounds) {
    // Schedule navigation after the current frame finishes
    SchedulerBinding.instance.addPostFrameCallback((_) {
      NavigationRoot.navTo('results');

      // Trigger result calculation after navigation
      calculateResult();
    });
    return;
  }

  // Log the same value the UI will show
  developer.log('$_roundCount/$_maxRounds', name: 'RoundCounter');
}

/// Getter so UI always reads the same source as the logger.
int getCurrentRoundCount() {
  return _roundCount;
}
