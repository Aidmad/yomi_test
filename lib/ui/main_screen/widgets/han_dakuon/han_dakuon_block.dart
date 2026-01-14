import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/ui/main_screen/widgets/han_dakuon/han_dakuon_text.dart';
import 'package:jp_reading/ui/main_screen/widgets/progress_bar.dart';
import 'package:jp_reading/data/selected_count.dart';
import 'package:jp_reading/functions/main_screen/check_count.dart';

class HanDakuonBlock extends StatefulWidget {
  final String kana;   // Either a Dakuon or Handakuon character
  final String romaji;
  final bool isHandakuon; // True if kana is a Handakuon

  const HanDakuonBlock({
    super.key,
    required this.kana,
    required this.romaji,
    this.isHandakuon = false,
  });

  @override
  State<HanDakuonBlock> createState() => _HanDakuonBlockState();
}

class _HanDakuonBlockState extends State<HanDakuonBlock> {
  late final ValueNotifier<bool> _isTappedNotifier;

  @override
  void initState() {
    super.initState();
    _isTappedNotifier = SelectedCount.getNotifier(widget.kana);
  }

  void _handleTap() {
    final isSelected = _isTappedNotifier.value;

    SelectedCount.updateSelection(!isSelected, widget.kana);

    CheckCount.evaluateSelection(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const horizontalPaddingAndMargin = 16.0;
        final safeMaxWidth = (constraints.maxWidth - horizontalPaddingAndMargin).clamp(0.0, double.infinity);
        final blockWidth = safeMaxWidth.toDouble();

        return ValueListenableBuilder<bool>(
          valueListenable: _isTappedNotifier,
          builder: (_, isTapped, __) {
            return GestureDetector(
              onTap: _handleTap,
              child: Container(
                width: blockWidth,
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
                    // Display the single kana (Dakuon or Handakuon)
                    widget.isHandakuon
                        ? HandakuonText(
                      handakuon: widget.kana,
                      notifier: _isTappedNotifier,
                      blockWidth: blockWidth,
                    )
                        : DakuonText(
                      dakuon: widget.kana,
                      notifier: _isTappedNotifier,
                      blockWidth: blockWidth,
                    ),
                    const SizedBox(height: 2),
                    RomajiText(
                      romaji: widget.romaji,
                      blockWidth: blockWidth,
                    ),
                    const SizedBox(height: 2),
                    ProgressBar(kana: widget.kana),
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
