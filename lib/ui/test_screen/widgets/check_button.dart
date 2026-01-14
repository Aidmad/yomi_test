import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/test_screen/answer_check.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckButton extends StatelessWidget {
  const CheckButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: _CheckButtonCore(),
    );
  }
}

class _CheckButtonCore extends StatelessWidget {
  const _CheckButtonCore();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final buttonHeight = screenWidth * 0.11;
    final textSize = screenWidth * 0.05;

    return SizedBox(
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: checkAnswer,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.inputButtons,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.checkButton,
          style: TextStyle(
            color: AppColors.textWhite,
            fontSize: textSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
