import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/data/progress_data.dart';

class ProgressBar extends StatelessWidget {
  final String kana;

  const ProgressBar({super.key, required this.kana});

  @override
  Widget build(BuildContext context) {
    final progressList = getProgressList();
    final kanaData =
    progressList.firstWhere((e) => e['kana'] == kana, orElse: () => {'progress': 0});
    final progressValue = (kanaData['progress'] ?? 0) / 100;

    final screenWidth = MediaQuery.of(context).size.width;
    final barHeight = screenWidth * 0.015; // responsive height

    return ClipRRect(
      borderRadius: BorderRadius.circular(barHeight / 2),
      child: Container(
        height: barHeight,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.emptyProgressBar),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: progressValue.clamp(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(color: AppColors.fullProgressBar),
          ),
        ),
      ),
    );
  }
}
