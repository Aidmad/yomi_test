import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/results_screen/finish_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Scale padding and font size relative to screen size
    final horizontalPadding = screenWidth * 0.06; // 6% of screen width
    final verticalPadding = screenHeight * 0.015; // 1.5% of screen height
    final fontSize = (screenWidth * 0.045).clamp(14.0, 28.0); // responsive font

    return GestureDetector(
      onTap: () {
        finishTest();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.button,
          borderRadius: BorderRadius.circular(screenWidth * 0.02), // scaled corner radius
        ),
        child: Text(
          AppLocalizations.of(context)!.continueButton,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
