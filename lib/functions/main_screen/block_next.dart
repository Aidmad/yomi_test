import 'package:jp_reading/data/full_progress.dart';
import 'package:jp_reading/data/hiragana.dart';
import 'package:jp_reading/data/dakuon.dart';
import 'package:jp_reading/data/handakuon.dart';

enum NextLessonStatus {
  disabled,        // Cannot proceed: current list incomplete
  enableHandakuon, // All Hiragana complete, move to Dakuon/Handakuon
  enableYoon,      // All Hiragana + all Dakuon/Handakuon complete
}

NextLessonStatus getNextLessonStatus() {
  final completedKana = getFullProgressKana();

  // Use first-time completion instead of current 100%
  int hiraganaCompleted = firstTimeCompletedLists.contains('hiragana') ? hiraganaList.length : 0;
  int dakuonCompleted = firstTimeCompletedLists.contains('dakuon') ? dakuonList.length : 0;
  int handakuonCompleted = firstTimeCompletedLists.contains('handakuon') ? handakuonList.length : 0;

  // Stepwise progression check
  if (hiraganaCompleted < hiraganaList.length) {
    return NextLessonStatus.disabled; // Cannot move to Dakuon/Handakuon yet
  } else if (dakuonCompleted < dakuonList.length || handakuonCompleted < handakuonList.length) {
    return NextLessonStatus.enableHandakuon; // Hiragana complete, move to Dakuon/Handakuon
  } else {
    return NextLessonStatus.enableYoon; // All complete
  }
}

/// Convenience boolean
bool canEnableNextLesson() => getNextLessonStatus() != NextLessonStatus.disabled;
