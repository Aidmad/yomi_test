import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlocksSelect extends StatelessWidget {
  const BlocksSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Font size scales with width but minimum 12
    final double fontSize = (size.width * 0.045).clamp(12, 16);

    // Tutorial image: scale with width but cap max size
    final double tutorialImageWidth = (size.width * 0.4).clamp(120, 180);
    final double tutorialImageHeight = (size.height * 0.15).clamp(80, 120);

    // Clear icon: smaller and capped
    final double clearIconSize = (size.width * 0.15).clamp(50, 80);

    // Info image: scalable and adaptive
    final double infoImageWidth = (size.width * 0.4).clamp(120, 150);
    final double infoImageHeight = (size.height * 0.1).clamp(80, 120);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/tutorial/select_blocks.png',
          width: tutorialImageWidth,
          height: tutorialImageHeight,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppLocalizations.of(context)!.tipsStep2Text8,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.textBlack,
            ),
          ),
        ),
        const SizedBox(height: 48),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep2Text9,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlack,
                        ),
                      ),
                      TextSpan(
                        text: 'X ',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep2Text10,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                'assets/images/tutorial/clear.png',
                width: clearIconSize,
                height: clearIconSize,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep2Text11,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlack,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep2Text12,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.tipsStep2Text13,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset(
                'assets/images/tutorial/info.png',
                width: infoImageWidth,
                height: infoImageHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
