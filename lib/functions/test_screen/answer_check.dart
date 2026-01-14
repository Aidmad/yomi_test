import 'dart:developer';
import 'package:jp_reading/functions/test_screen/randomize.dart';
import 'package:jp_reading/functions/test_screen/typed_text.dart';
import 'package:jp_reading/data/hiragana.dart';
import 'package:jp_reading/notifiers/answer_display.dart';
import 'package:jp_reading/data/test_results.dart';
import 'package:jp_reading/functions/main_screen/calculate_progress.dart';
import 'package:jp_reading/data/dakuon.dart';
import 'package:jp_reading/data/handakuon.dart';
import 'package:jp_reading/data/yoon.dart';

String checkAnswer() {
  if (AnswerDisplayNotifier.instance.isFeedbackActive) {
    log('[checkAnswer] Blocked — feedback displaying.');
    return 'locked';
  }

  final String typedInput = TypedText.currentText.trim();
  if (typedInput.isEmpty) {
    log('answer_check disabled — no typed input.');
    return 'no_input';
  }

  final String? currentKana = Randomizer.currentKana;
  if (currentKana == null || currentKana.isEmpty) {
    log('No current kana available — cannot check.');
    return 'no_kana';
  }

  String correctRomaji = '';

  // Check hiragana
  correctRomaji = hiraganaList.firstWhere(
        (h) => h.hiragana == currentKana,
    orElse: () => const Hiragana(hiragana: '', romaji: ''),
  ).romaji;

  // Check dakuon if not found
  if (correctRomaji.isEmpty) {
    correctRomaji = dakuonList.firstWhere(
          (d) => d.dakuon == currentKana,
      orElse: () => const Dakuon(dakuon: '', romaji: ''),
    ).romaji;
  }

  // Check handakuon if still not found
  if (correctRomaji.isEmpty) {
    correctRomaji = handakuonList.firstWhere(
          (h) => h.handakuon == currentKana,
      orElse: () => const Handakuon(handakuon: '', romaji: ''),
    ).romaji;
  }

  // Check yoon if still not found
  if (correctRomaji.isEmpty) {
    correctRomaji = yoonList.firstWhere(
          (y) => y.yoon == currentKana,
      orElse: () => const Yoon(yoon: '', romaji: ''),
    ).romaji;
  }

  String resultStatus;

  if (typedInput == correctRomaji && correctRomaji.isNotEmpty) {
    log('correct');
    AnswerDisplayNotifier.instance.updateState('match');
    resultStatus = 'correct';
  } else {
    log('wrong');
    AnswerDisplayNotifier.instance.updateState('not_match');
    resultStatus = 'wrong';
  }

  testResults.saveSingleResult(currentKana, resultStatus);

  calculateProgress();

  TypedText.clear();

  return resultStatus;
}
