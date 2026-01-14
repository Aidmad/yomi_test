import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/results_screen/wrong_kanas.dart';

class MistakePanel extends StatelessWidget {
  const MistakePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final kanaList = WrongKanas.getWrongKanaList();

    if (kanaList.isEmpty) {
      return const SizedBox.shrink();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic sizing based on screen size
    final horizontalMargin = screenWidth * 0.05; // 5% of screen width
    final verticalMargin = screenHeight * 0.02; // 2% of screen height
    final blockPadding = screenWidth * 0.03; // padding inside each block
    final kanaFontSize = screenWidth * 0.06; // scales with width
    final romajiFontSize = screenWidth * 0.04; // scales with width
    final borderRadius = screenWidth * 0.02; // rounded corners scale

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: verticalMargin,
        ),
        child: Wrap(
          spacing: horizontalMargin / 2, // horizontal spacing between blocks
          runSpacing: verticalMargin / 2, // vertical spacing between rows
          alignment: WrapAlignment.center,
          children: kanaList.map((item) {
            return Container(
              padding: EdgeInsets.all(blockPadding),
              decoration: BoxDecoration(
                color: AppColors.wrongAnswer,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item['kana']!,
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: kanaFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: blockPadding / 3),
                  Text(
                    item['romaji']!,
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: romajiFontSize,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
