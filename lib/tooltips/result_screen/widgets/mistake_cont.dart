import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MistakeCont extends StatelessWidget {
  const MistakeCont({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic sizing
    final imageWidth1 = (screenWidth * 0.25).clamp(80.0, 120.0);
    final imageHeight1 = (screenHeight * 0.08).clamp(60.0, 100.0);

    final imageWidth2 = (screenWidth * 0.25).clamp(80.0, 120.0);
    final imageHeight2 = (screenHeight * 0.15).clamp(80.0, 120.0);

    final fontSize = (screenWidth * 0.04).clamp(14.0, 18.0);
    final spacing = (screenHeight * 0.03).clamp(16.0, 32.0);

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First Row: Text on left, Image on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.tipsStep9Text1,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: AppColors.textBlack,
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              Image.asset(
                'assets/images/tutorial/mistakes.png',
                width: imageWidth1,
                height: imageHeight1,
                fit: BoxFit.contain,
              ),
            ],
          ),
          SizedBox(height: spacing),
          // Second Row: Image on left, Text on right with "Continue" highlighted
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/tutorial/continue.png',
                width: imageWidth2,
                height: imageHeight2,
                fit: BoxFit.contain,
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep9Text2,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlack,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep9Text3,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStepText,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
