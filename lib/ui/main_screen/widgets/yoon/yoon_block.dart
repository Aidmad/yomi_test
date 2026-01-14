import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/ui/main_screen/widgets/yoon/yoon_text.dart';
import 'package:jp_reading/ui/main_screen/widgets/progress_bar.dart';
import 'package:jp_reading/data/selected_count.dart';
import 'package:jp_reading/functions/main_screen/check_count.dart';

class YoonBlock extends StatefulWidget {
  final String yoon;
  final String romaji;

  const YoonBlock({
    super.key,
    required this.yoon,
    required this.romaji,
  });

  @override
  State<YoonBlock> createState() => _YoonBlockState();
}

class _YoonBlockState extends State<YoonBlock> {
  late final ValueNotifier<bool> _isTappedNotifier;

  @override
  void initState() {
    super.initState();
    _isTappedNotifier = SelectedCount.getNotifier(widget.yoon);
  }

  void _handleTap() {
    final isSelected = _isTappedNotifier.value;
    SelectedCount.updateSelection(!isSelected, widget.yoon);
    CheckCount.evaluateSelection(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPaddingAndMargin = 16.0;
        final safeMaxWidth =
        (constraints.maxWidth - horizontalPaddingAndMargin).clamp(0.0, double.infinity);

        const blocksPerRow = 3; // Always 3 blocks per row
        final blockWidth = (safeMaxWidth / blocksPerRow).clamp(50.0, 120.0); // limit width

        return ValueListenableBuilder<bool>(
          valueListenable: _isTappedNotifier,
          builder: (_, isTapped, __) {
            return GestureDetector(
              onTap: _handleTap,
              child: Container(
                width: blockWidth,
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: BoxDecoration(
                  color: isTapped ? AppColors.tappedBlock : Colors.transparent,
                  border: Border.all(
                    color: isTapped ? AppColors.tappedBlock : AppColors.blockBorder,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    YoonText(
                      yoon: widget.yoon,
                      notifier: _isTappedNotifier,
                      blockWidth: blockWidth,
                    ),
                    const SizedBox(height: 2),
                    YoonRomajiText(
                      romaji: widget.romaji,
                      blockWidth: blockWidth,
                    ),
                    const SizedBox(height: 2),
                    ProgressBar(kana: widget.yoon),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
