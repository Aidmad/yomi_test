import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/theme/app_colors.dart';

class IntroTextWidget extends StatelessWidget {
  final double baseFont;
  final double titleFont;

  const IntroTextWidget({required this.baseFont, required this.titleFont, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: double.infinity,
            child: Text(
              AppLocalizations.of(context)!.tipsStep1Title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleFont,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlue,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.tipsStep1Text1,
                style: TextStyle(
                  fontSize: baseFont,
                  color: AppColors.textBlack,
                ),
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.tipsStep1Text2,
                style: TextStyle(
                  fontSize: baseFont,
                  color: AppColors.textBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.tipsStep1Text3,
          style: TextStyle(
            fontSize: baseFont,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.tipsStep1Text4,
          style: TextStyle(
            fontSize: baseFont,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppLocalizations.of(context)!.tipsStep1Text5,
          style: TextStyle(
            fontSize: baseFont,
            color: AppColors.textBlack,
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            AppLocalizations.of(context)!.tipsStep1Text6,
            style: TextStyle(
              fontSize: baseFont,
              color: AppColors.textBlue,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
