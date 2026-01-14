import 'package:flutter/material.dart';
import 'package:jp_reading/ui/main_screen/widgets/hiragana/hiragana_block.dart';
import 'package:jp_reading/ui/main_screen/widgets/hiragana/hiragana_text.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/ui/main_screen/widgets/info_icon.dart';
import 'package:jp_reading/ui/main_screen/widgets/hiragana/hiragana_info.dart';

class HiraganaSheet extends StatelessWidget {
  const HiraganaSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final kanaList = getHiraganaList();

    final rowStructure = [5, 5, 5, 5, 5, 5, 5, 3, 5, 2, 1];
    final List<List> rows = [];
    int startIndex = 0;

    for (final count in rowStructure) {
      if (startIndex >= kanaList.length) break;

      final endIndex = (startIndex + count > kanaList.length)
          ? kanaList.length
          : startIndex + count;
      rows.add(kanaList.sublist(startIndex, endIndex));
      startIndex = endIndex;
    }

    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive font size: use min(screenWidth * 0.05, screenHeight * 0.05)
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
                        child: HiraganaInfo(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'ひらがな',
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
          for (int i = 0; i < rows.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildRow(rows[i], i),
            ),
        ],
      ),
    );
  }

  Widget _buildRow(List row, int rowIndex) {
    const totalColumns = 5;

    if (rowIndex == 7) return _buildCustomRow(row, [0, 2, 4], totalColumns);
    if (rowIndex == 9) return _buildCustomRow(row, [0, 4], totalColumns);
    if (rowIndex == 10) return _buildCustomRow(row, [0], totalColumns);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: row
          .map(
            (kana) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: RepaintBoundary(
              child: HiraganaBlock(
                hiragana: kana.hiragana,
                romaji: kana.romaji,
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }

  Widget _buildCustomRow(List row, List<int> filledPositions, int totalColumns) {
    int blockIndex = 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalColumns, (col) {
        if (filledPositions.contains(col) && blockIndex < row.length) {
          final kana = row[blockIndex++];
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: HiraganaBlock(
                hiragana: kana.hiragana,
                romaji: kana.romaji,
              ),
            ),
          );
        } else {
          return const Expanded(child: SizedBox());
        }
      }),
    );
  }
}
