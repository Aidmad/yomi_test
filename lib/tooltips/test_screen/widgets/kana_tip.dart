import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/theme/app_colors.dart';

class KanaTip extends StatelessWidget {
  const KanaTip({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Image size scales with screen width, with a minimum of 150
    final imageSize = (screenWidth * 0.4).clamp(150.0, 300.0);

    // Text size scales with screen width, with a minimum of 14
    final textSize = (screenWidth * 0.04).clamp(14.0, 20.0);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/tutorial/kana.png',
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              AppLocalizations.of(context)!.tipsStep6Text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textBlack,
                fontSize: textSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
