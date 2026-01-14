import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArrowsTip extends StatelessWidget {
  const ArrowsTip({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Text size scaling (clamped to prevent too small or too large)
    double scaleText(double value) => (value * screenWidth / 400).clamp(14, 20);

    // Image width scaling: proportional to screen, but capped to max pixel width
    double scaleImage(double baseWidth) => (baseWidth * screenWidth / 400).clamp(120, baseWidth);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.tipsStep10Text1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: scaleText(18),
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: scaleText(16)),
          Image.asset(
            'assets/images/tutorial/next_warning.png',
            width: scaleImage(200), // base width 200px, capped for large screens
            fit: BoxFit.contain,
          ),
          SizedBox(height: scaleText(24)),
          Text(
            AppLocalizations.of(context)!.tipsStep10Text2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: scaleText(16),
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: scaleText(6)),
          Image.asset(
            'assets/images/tutorial/full.png',
            width: scaleImage(200), // base width 200px, capped
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
