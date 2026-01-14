import 'package:flutter/material.dart';
import 'package:jp_reading/data/yoon.dart';
import 'package:jp_reading/theme/app_colors.dart';

// Text styles
const TextStyle yoonStyle = TextStyle(
  fontSize: 22, // smaller than before
  fontWeight: FontWeight.bold,
  color: AppColors.kanaText,
);
const TextStyle romajiStyle = TextStyle(
  fontSize: 15, // smaller
  color: AppColors.romajiText,
);

List<Yoon> getYoonList() => yoonList;

class YoonText extends StatelessWidget {
  final String yoon;
  final ValueNotifier<bool> notifier;
  final double blockWidth;

  const YoonText({
    super.key,
    required this.yoon,
    required this.notifier,
    required this.blockWidth,
  });

  @override
  Widget build(BuildContext context) {
    // limit scaling
    final scaleFactor = (blockWidth / 35).clamp(0.8, 1.2);

    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (_, isTapped, __) {
        return Text(
          yoon,
          style: yoonStyle.copyWith(
            fontSize: yoonStyle.fontSize! * scaleFactor,
            color: isTapped ? AppColors.tappedText : yoonStyle.color,
          ),
        );
      },
    );
  }
}

class YoonRomajiText extends StatelessWidget {
  final String romaji;
  final double blockWidth;

  const YoonRomajiText({
    super.key,
    required this.romaji,
    required this.blockWidth,
  });

  @override
  Widget build(BuildContext context) {
    final scaleFactor = (blockWidth / 35).clamp(0.8, 1.2);

    return Text(
      romaji,
      style: romajiStyle.copyWith(
        fontSize: romajiStyle.fontSize! * scaleFactor,
      ),
      maxLines: 1,
      softWrap: false,
      overflow: TextOverflow.visible,
    );
  }
}
