import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PercentTipWidget extends StatelessWidget {
  const PercentTipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate sizes proportionally
    final imageSize = (screenWidth * 0.5).clamp(150.0, 300.0); // min 150, max 300
    final fontSize = (screenWidth * 0.045).clamp(14.0, 20.0); // min 14, max 20

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/tutorial/percent.png',
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
          SizedBox(height: screenHeight * 0.03), // spacing scales with screen height
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              AppLocalizations.of(context)!.tipsStep8Text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                color: AppColors.textBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
