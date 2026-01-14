import 'package:flutter/material.dart';
import 'package:jp_reading/data/hiragana.dart';
import 'package:jp_reading/theme/app_colors.dart';

// Text styles
const TextStyle hiraganaStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: AppColors.kanaText,
);
const TextStyle romajiStyle = TextStyle(
  fontSize: 15,
  color: AppColors.romajiText,
);

// Getter for widgets to access Hiragana data
List<Hiragana> getHiraganaList() => hiraganaList;

// Widget for Hiragana text that listens to taps
class HiraganaText extends StatelessWidget {
  final String hiragana;
  final ValueNotifier<bool> notifier;
  final double blockWidth;

  const HiraganaText({
    super.key,
    required this.hiragana,
    required this.notifier,
    required this.blockWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Determine a scaling factor based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = blockWidth / 35;

    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (_, isTapped, __) {
        return Text(
          hiragana,
          style: hiraganaStyle.copyWith(
            fontSize: hiraganaStyle.fontSize! * scaleFactor,
            color: isTapped ? AppColors.tappedText : hiraganaStyle.color,
          ),
        );
      },
    );
  }
}
class RomajiText extends StatelessWidget {
  final String romaji;
  final double blockWidth;

  const RomajiText({
    super.key,
    required this.romaji,
    required this.blockWidth,
  });


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = blockWidth / 35;

    return Text(
      romaji,
      style: romajiStyle.copyWith(
        fontSize: romajiStyle.fontSize! * scaleFactor,
      ),
      maxLines: 1,          // stays on one line
      softWrap: false,      // prevents wrapping
      overflow: TextOverflow.visible, // allows overflow instead of going to next line
    );
  }
}

