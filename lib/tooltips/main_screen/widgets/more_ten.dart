import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/theme/app_colors.dart';

class MoreTen extends StatelessWidget {
  const MoreTen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Calculate a scale factor based on screen width
    final double scaleFactor = (size.width / 360).clamp(0.8, 1.2);

    // Image sizes remain fixed (or you can slightly scale if needed)
    final double mainImageSize = 150; // keep constant to preserve clarity
    final double rowImageWidth = 100;
    final double rowImageHeight = 180;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0 * scaleFactor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image above text
            Image.asset(
              'assets/images/tutorial/select_10_en.png',
              width: mainImageSize,
              height: mainImageSize,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 8 * scaleFactor), // spacing between image and text

            // Text below image
            Text(
              AppLocalizations.of(context)!.tipsStep3Text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: (16 * scaleFactor).clamp(14, 20), // keep text readable
                color: AppColors.textBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16 * scaleFactor), // spacing before new row

            // Row with new image and text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/tutorial/more10_en.png',
                  width: rowImageWidth,
                  height: rowImageHeight,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8 * scaleFactor), // spacing between image and text
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.tipsStep3Text2,
                    style: TextStyle(
                      fontSize: (16 * scaleFactor).clamp(14, 20),
                      color: AppColors.textBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
