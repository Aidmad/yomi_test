import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/ui/bottom_bar/button_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final verticalPadding = (screenHeight * 0.015).clamp(8.0, 16.0);
    final spacing = (screenHeight * 0.01).clamp(6.0, 12.0);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        color: AppColors.bottomBar,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: verticalPadding),

        child: LayoutBuilder(
          builder: (context, constraints) {
            // NOW this is the actual bottom bar height
            final barHeight = constraints.maxHeight;

            // Text scales correctly with real bar height
            final textFontSize = (barHeight * 0.12).clamp(14.0, 18.0);

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.bottomBar,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: textFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: spacing),
                const ButtonBottomBar(),
                SizedBox(height: spacing),
              ],
            );
          },
        ),
      ),
    );
  }
}
