import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/tutorial/button_en.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: AppLocalizations.of(context)!.tipsStep4Text1,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textBlack,
                ),
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.tipsStep4Text2,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.tipsStep4Text3,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textBlack,
                ),
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.tipsStep4Text4,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.tipsStep4Text5,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.textBlack,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 35), // spacing between texts
        Text(
          AppLocalizations.of(context)!.tipsStep4Text6,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: AppColors.textBlack,
          ),
        ),
      ],
    );
  }
}
