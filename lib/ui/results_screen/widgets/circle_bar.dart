import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/results_screen/calculate_results.dart';

class CircleBar extends StatelessWidget {
  const CircleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double visualValue = latestPercentage / 100;
    final String displayText = '${latestPercentage.toStringAsFixed(0)}%';

    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 220,
              child: CircularProgressIndicator(
                value: visualValue.isNaN ? 0 : visualValue,
                strokeWidth: 18,
                backgroundColor: AppColors.circleBar.withValues(alpha: 0.18),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.circleBar),
              ),
            ),
            Text(
              displayText,
              style: TextStyle(
                color: AppColors.circleBarText,
                fontSize: 50,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
