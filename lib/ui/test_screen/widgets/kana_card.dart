import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/test_screen/next_kana.dart';
import 'package:jp_reading/notifiers/answer_display.dart';

class KanaCard extends StatefulWidget {
  const KanaCard({super.key});

  @override
  KanaCardState createState() => KanaCardState();
}

class KanaCardState extends State<KanaCard> {
  late String currentKana;
  late VoidCallback _listener;

  Color _cardColor = AppColors.questionCard;

  @override
  void initState() {
    super.initState();

    currentKana = NextKanaController.instance.currentKanaNotifier.value;

    _listener = () {
      setState(() {
        currentKana = NextKanaController.instance.currentKanaNotifier.value;
        _cardColor = AppColors.questionCard;
      });
    };
    NextKanaController.instance.currentKanaNotifier.addListener(_listener);

    AnswerDisplayNotifier.instance.addListener(_handleAnswerStateChange);
  }

  void _handleAnswerStateChange() {
    final state = AnswerDisplayNotifier.instance.answerState;

    setState(() {
      if (state == 'match') {
        _cardColor = AppColors.correctAnswer;
      } else if (state == 'not_match') {
        _cardColor = AppColors.wrongAnswer;
      } else if (state == 'default') {
        _cardColor = AppColors.questionCard;
      }
    });
  }

  @override
  void dispose() {
    NextKanaController.instance.currentKanaNotifier.removeListener(_listener);
    AnswerDisplayNotifier.instance.removeListener(_handleAnswerStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Scale card size
    final cardWidth = screenWidth * 0.5;
    final cardHeight = screenWidth * 0.57;

    // Scale kana text
    final kanaFontSize = screenWidth * 0.25;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            currentKana,
            style: TextStyle(
              fontSize: kanaFontSize, // serves as max size
              color: AppColors.kanaText,
            ),
          ),
        ),
      ),
    );
  }
}
