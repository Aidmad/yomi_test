import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:jp_reading/functions/test_screen/next_kana.dart';

class AnswerDisplayNotifier extends ChangeNotifier {
  static final AnswerDisplayNotifier instance = AnswerDisplayNotifier._internal();
  AnswerDisplayNotifier._internal();

  String _answerState = 'default';
  bool _feedbackActive = false;
  Timer? _timer;

  String get answerState => _answerState;
  bool get isFeedbackActive => _feedbackActive;

  void updateState(String newState) {
    _answerState = newState;
    _feedbackActive = true;             // lock during display
    notifyListeners();

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      _answerState = 'default';
      _feedbackActive = false;          // unlock after delay
      notifyListeners();

      NextKanaController.instance.notifyNext();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
