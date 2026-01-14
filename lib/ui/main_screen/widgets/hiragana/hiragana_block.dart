import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/ui/main_screen/widgets/hiragana/hiragana_text.dart';
import 'package:jp_reading/ui/main_screen/widgets/progress_bar.dart';
import 'package:jp_reading/data/selected_count.dart';
import 'package:jp_reading/functions/main_screen/check_count.dart';

class HiraganaBlock extends StatefulWidget {
  final String hiragana;
  final String romaji;

  const HiraganaBlock({
    super.key,
    required this.hiragana,
    required this.romaji,
  });

  @override
  State<HiraganaBlock> createState() => _HiraganaBlockState();
}

class _HiraganaBlockState extends State<HiraganaBlock> {
  late final ValueNotifier<bool> _isTappedNotifier;

  @override
  void initState() {
    super.initState();
    _isTappedNotifier = SelectedCount.getNotifier(widget.hiragana);
  }

  void _handleTap() {
    final isSelected = _isTappedNotifier.value;

    // Toggle selection
    SelectedCount.updateSelection(!isSelected, widget.hiragana);

    // Always update button state (CheckCount will handle popup)
    CheckCount.evaluateSelection(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPaddingAndMargin = 16.0; // 8+8 padding + margin
        final safeMaxWidth = (constraints.maxWidth - horizontalPaddingAndMargin).clamp(0.0, double.infinity);
        final blockWidth = safeMaxWidth.toDouble();

        return ValueListenableBuilder<bool>(
          valueListenable: _isTappedNotifier,
          builder: (_, isTapped, __) {
            return GestureDetector(
              onTap: _handleTap,
              child: Container(
                width: blockWidth, // responsive block width
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                    HiraganaText(
                      hiragana: widget.hiragana,
                      notifier: _isTappedNotifier,
                      blockWidth: blockWidth,
                    ),
                    const SizedBox(height: 2),
                    RomajiText(
                      romaji: widget.romaji,
                      blockWidth: blockWidth,
                    ),
                    const SizedBox(height: 2),
                    ProgressBar(kana: widget.hiragana),
                  ],
                )
              ),
            );
          },
        );
      },
    );
  }
}
