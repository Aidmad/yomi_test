import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestScreenTip extends StatelessWidget {
  const TestScreenTip({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const baseWidth = 400.0;
    final scale = (size.width / baseWidth).clamp(0.85, 1.2);

    final testImageWidth = 90 * scale;
    final testImageHeight = 130 * scale;

    final backButtonSize = 100 * scale;
    final counterWidth = 100 * scale;
    final counterHeight = 150 * scale;

    final fontSize = 16 * scale;

    final rowSpacing = 24 * scale;
    final innerSpacing = 12 * scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tutorial/test_screen.png',
              width: testImageWidth,
              height: testImageHeight,
              fit: BoxFit.contain,
            ),
            SizedBox(width: innerSpacing),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.tipsStep5Text1,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: rowSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.tipsStep5Text2,
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: fontSize,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.tipsStep5Text3,
                      style: TextStyle(
                        color: AppColors.textBlue,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.tipsStep5Text4,
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: innerSpacing),
            Image.asset(
              'assets/images/tutorial/back_button.png',
              width: backButtonSize,
              height: backButtonSize,
              fit: BoxFit.contain,
            ),
          ],
        ),
        SizedBox(height: rowSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tutorial/counter.png',
              width: counterWidth,
              height: counterHeight,
              fit: BoxFit.contain,
            ),
            SizedBox(width: innerSpacing),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.tipsStep5Text5,
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
