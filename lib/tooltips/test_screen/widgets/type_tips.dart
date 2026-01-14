import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TypeTips extends StatelessWidget {
  const TypeTips({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Image widths scale with screen width, minimum and maximum set
    final mainImageWidth = (screenWidth * 0.9).clamp(200.0, 600.0);
    final checkImageWidth = (screenWidth * 0.2).clamp(40.0, 80.0);
    final checkImageHeight = (checkImageWidth * 0.5).clamp(20.0, 40.0);

    // Text scales with screen width, minimum 14, maximum 20
    final textSize = (screenWidth * 0.04).clamp(14.0, 20.0);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/tutorial/input_field.png',
            width: mainImageWidth,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.tipsStep7Text1,
            style: TextStyle(
              color: AppColors.textBlack,
              fontSize: textSize,
            ),
          ),
          const SizedBox(height: 24),
          Image.asset(
            'assets/images/tutorial/input_buttons.png',
            width: mainImageWidth,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalizations.of(context)!.tipsStep7Text2,
                  style: TextStyle(
                    fontSize: textSize,
                    color: AppColors.textBlack,
                  ),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.tipsStep7Text3,
                  style: TextStyle(
                    fontSize: textSize,
                    color: AppColors.textBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: AppLocalizations.of(context)!.tipsStepText,
                  style: TextStyle(
                    fontSize: textSize,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: checkImageWidth,
                height: checkImageHeight,
                child: Image.asset(
                  'assets/images/tutorial/check.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep7Text4,
                        style: TextStyle(
                          fontSize: textSize,
                          color: AppColors.textBlack,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep7Text5,
                        style: TextStyle(
                          fontSize: textSize,
                          color: AppColors.textBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep7Text6,
                        style: TextStyle(
                          fontSize: textSize,
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
