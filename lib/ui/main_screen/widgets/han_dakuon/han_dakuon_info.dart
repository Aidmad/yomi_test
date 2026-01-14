import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HanDakuonInfo extends StatelessWidget {
  const HanDakuonInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Clamp text size so it doesn't get too small or too big
    final textFontSize = (screenWidth * 0.04).clamp(14.0, 18.0);

    return FractionallySizedBox(
      widthFactor: 0.9, // panel takes 90% of screen width
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // only as tall as content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.infoText5,
              style: TextStyle(fontSize: textFontSize, color: AppColors.textBlack),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.infoText6,
              style: TextStyle(fontSize: textFontSize, color: AppColors.textBlack),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.infoText7,
              style: TextStyle(fontSize: textFontSize, color: AppColors.textBlack),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.infoText8,
              style: TextStyle(fontSize: textFontSize, color: AppColors.textBlack),
            ),
          ],
        ),
      ),
    );
  }
}
