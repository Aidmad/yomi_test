import 'package:flutter/foundation.dart';
import 'package:jp_reading/functions/test_screen/type_input.dart';
import 'package:jp_reading/notifiers/answer_display.dart';

class TypedText {
  static final ValueNotifier<String> _typedValue = ValueNotifier<String>('');

  static void initializeListener() {
    TypeInput.addListener((String updatedText) {
      // Prevent text updates while feedback (Correct/Wrong) is displaying
      if (AnswerDisplayNotifier.instance.isFeedbackActive) {
        debugPrint('TypedText ignored: feedback active');
        return;
      }

      _typedValue.value = updatedText;
      debugPrint('TypedText updated: $updatedText');
    });
  }

  static ValueNotifier<String> get typedValue => _typedValue;
  static String get currentText => _typedValue.value;

  static void clear() {
    TypeInput.clear();          // clears the actual buffer
    _typedValue.value = '';     // clears the notifier
  }
}
