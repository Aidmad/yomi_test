import 'package:jp_reading/notifiers/answer_display.dart';

class TypeInput {
  static final StringBuffer _typedBuffer = StringBuffer();
  static final List<void Function(String)> _listeners = [];

  static void addListener(void Function(String) listener) {
    _listeners.add(listener);
  }

  static void _notify() {
    for (final listener in _listeners) {
      listener(_typedBuffer.toString());
    }
  }

  static void typeLetter(String letter) {
    // Block input while feedback is being displayed
    if (AnswerDisplayNotifier.instance.isFeedbackActive) {
      return;
    }

    _typedBuffer.write(letter);
    _notify();
  }

  static void removeLastLetter() {
    if (_typedBuffer.isEmpty) return;
    final text = _typedBuffer.toString();
    _typedBuffer
      ..clear()
      ..write(text.substring(0, text.length - 1));
    _notify();
  }

  static void clear() {
    _typedBuffer.clear();
    _notify(); // updates listeners that text is now empty
  }
}
