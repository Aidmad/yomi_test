import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HiraganaListTip extends StatelessWidget {
  const HiraganaListTip({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double baseWidth = 360.0;
        double scale = constraints.maxWidth / baseWidth;

        // scale font size but ensure it never goes below 14
        double fontSize = math.max(16 * scale, 14);
        double spacing = math.max(8 * scale, 6);

        double imageWidth = 100 * scale;
        double imageHeight = 320 * scale;

        return Padding(
          padding: EdgeInsets.all(16 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.tipsStep2Text1,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: AppColors.textBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.tipsStep2Text2,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: AppColors.textBlack,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacing),
              Text(
                AppLocalizations.of(context)!.tipsStep2Text3,
                style: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: spacing + 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/tutorial/scroll3.png',
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10 * scale),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.tipsStep2Text4,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: AppColors.textBlack,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.tipsStep2Text5,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: AppColors.textBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.tipsStep2Text6,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: AppColors.textBlack,
                            ),
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.tipsStep2Text7,
                            style: TextStyle(
                              fontSize: fontSize,
                              color: AppColors.textBlue,
                              fontWeight: FontWeight.bold,
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
      },
    );
  }
}
