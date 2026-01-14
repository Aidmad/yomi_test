import 'package:flutter/material.dart';
import 'package:jp_reading/functions/progress_check.dart';
import 'package:jp_reading/functions/check_type.dart';
import 'package:jp_reading/functions/main_screen/block_next.dart';
import 'package:jp_reading/ui/main_screen/widgets/no_progress.dart'; // contains NoProgressPopup

enum LessonPage {
  hiragana,
  hanDakuon,
  yoon,
}

class NextLesson extends StatefulWidget {
  final VoidCallback? onPageChanged;
  const NextLesson({super.key, this.onPageChanged});

  @override
  State<NextLesson> createState() => NextLessonState();
}

class NextLessonState extends State<NextLesson> {
  LessonPage _currentPage = LessonPage.hiragana;
  bool disabled = true; // default disabled

  void goNext() {
    checkType();

    final status = getNextLessonStatus();

    switch (status) {
      case NextLessonStatus.disabled:
        NoProgressPopup.show(context);
        return;

      case NextLessonStatus.enableHandakuon:
        break;

      case NextLessonStatus.enableYoon:
        break;
    }

    checkProgress();

    setState(() {
      switch (_currentPage) {
        case LessonPage.hiragana:
          _currentPage = LessonPage.hanDakuon;
          break;

        case LessonPage.hanDakuon:
          if (status == NextLessonStatus.enableYoon) {
            _currentPage = LessonPage.yoon;
          } else {
            NoProgressPopup.show(context); // yoon blocked
            return;
          }
          break;

        case LessonPage.yoon:
          _currentPage = LessonPage.hiragana;
          break;
      }

      widget.onPageChanged?.call();
    });
  }

  void goPrevious() {
    checkType();

    final status = getNextLessonStatus();

    if (status == NextLessonStatus.disabled) {
      NoProgressPopup.show(context);
      return;
    }

    checkProgress();

    setState(() {
      switch (_currentPage) {
        case LessonPage.hiragana:
          if (status == NextLessonStatus.enableYoon) {
            _currentPage = LessonPage.yoon;
          } else {
            NoProgressPopup.show(context);
            return;
          }
          break;

        case LessonPage.hanDakuon:
          _currentPage = LessonPage.hiragana;
          break;

        case LessonPage.yoon:
          _currentPage = LessonPage.hanDakuon;
          break;
      }

      widget.onPageChanged?.call();
    });
  }

  LessonPage get currentPage => _currentPage;

  VoidCallback get onLeftTap => goPrevious;
  VoidCallback get onRightTap => goNext;

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
