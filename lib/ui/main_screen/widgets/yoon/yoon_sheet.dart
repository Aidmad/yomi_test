import 'package:flutter/material.dart';
import 'package:jp_reading/ui/main_screen/widgets/yoon/yoon_block.dart';
import 'package:jp_reading/ui/main_screen/widgets/yoon/yoon_text.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/data/yoon.dart';
import 'package:jp_reading/ui/main_screen/widgets/info_icon.dart';
import 'package:jp_reading/ui/main_screen/widgets/yoon/yoon_info.dart';

class YoonSheet extends StatelessWidget {
  const YoonSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final kanaList = getYoonList(); // Get Yoon characters

    const int blocksPerRow = 3;
    final List<List<Yoon>> rows = [];
    for (int i = 0; i < kanaList.length; i += blocksPerRow) {
      final endIndex = (i + blocksPerRow > kanaList.length)
          ? kanaList.length
          : i + blocksPerRow;
      rows.add(kanaList.sublist(i, endIndex));
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final titleFontSize = ((screenWidth * 0.05).clamp(18, 36)).toDouble();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 1),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InfoIcon(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: YoonInfo(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'ようん',
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row
                    .map(
                      (kana) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RepaintBoundary(
                        child: YoonBlock(
                          yoon: kana.yoon,
                          romaji: kana.romaji,
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
