import 'package:flutter/material.dart';
import 'package:jp_reading/data/dakuon.dart';
import 'package:jp_reading/data/handakuon.dart';
import 'package:jp_reading/theme/app_colors.dart';

const TextStyle kanaStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: AppColors.kanaText,
);

const TextStyle romajiStyle = TextStyle(
  fontSize: 15,
  color: AppColors.romajiText,
);

// Getters for widgets to access data
List<Dakuon> getDakuonList() => dakuonList;
List<Handakuon> getHandakuonList() => handakuonList;

// Widget for Dakuon text
class DakuonText extends StatelessWidget {
  final String dakuon;
  final ValueNotifier<bool> notifier;
  final double blockWidth;

  const DakuonText({
    super.key,
    required this.dakuon,
    required this.notifier,
    required this.blockWidth,
  });

  @override
  Widget build(BuildContext context) {
    final scaleFactor = blockWidth / 35;

    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (_, isTapped, __) {
        return Text(
          dakuon,
          style: kanaStyle.copyWith(
            fontSize: kanaStyle.fontSize! * scaleFactor,
            color: isTapped ? AppColors.tappedText : kanaStyle.color,
          ),
        );
      },
    );
  }
}

// Widget for Handakuon text
class HandakuonText extends StatelessWidget {
  final String handakuon;
  final ValueNotifier<bool> notifier;
  final double blockWidth;

  const HandakuonText({
    super.key,
    required this.handakuon,
    required this.notifier,
    required this.blockWidth,
  });

  @override
  Widget build(BuildContext context) {
    final scaleFactor = blockWidth / 35;

    return ValueListenableBuilder<bool>(
      valueListenable: notifier,
      builder: (_, isTapped, __) {
        return Text(
          handakuon,
          style: kanaStyle.copyWith(
            fontSize: kanaStyle.fontSize! * scaleFactor,
            color: isTapped ? AppColors.tappedText : kanaStyle.color,
          ),
        );
      },
    );
  }
}

// Shared Romaji widget (same behavior)
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
    final scaleFactor = blockWidth / 35;

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
