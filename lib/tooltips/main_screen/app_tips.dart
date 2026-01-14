import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/tooltips/main_screen/widgets/intro_text.dart';
import 'package:jp_reading/tooltips/main_screen/widgets/hiragana_list_tip.dart';
import 'package:jp_reading/tooltips/main_screen/widgets/blocks_select.dart';
import 'package:jp_reading/tooltips/main_screen/widgets/more_ten.dart';
import 'package:jp_reading/tooltips/main_screen/widgets/arrows_tip.dart';
import 'package:jp_reading/tooltips/main_screen/widgets/next_button.dart';

class AppTips extends StatefulWidget {
  final VoidCallback onFinish;

  const AppTips({super.key, required this.onFinish});

  @override
  State<AppTips> createState() => _AppTipsState();
}

class _AppTipsState extends State<AppTips> {
  int step = 0;

  static const int lastStep = 5;

  Widget _buildStep(double baseFont, double titleFont) {
    switch (step) {
      case 0:
        return IntroTextWidget(
          baseFont: baseFont,
          titleFont: titleFont,
        );
      case 1:
        return const HiraganaListTip();
      case 2:
        return const BlocksSelect();
      case 3:
        return const MoreTen();
      case 4:
        return const ArrowsTip();
      case 5:
        return const NextButton();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double panelWidth = size.width * 0.8;
    final double panelHeight = size.height * 0.7;

    final double finalWidth = panelWidth.clamp(260, 550);
    final double finalHeight = panelHeight.clamp(420, 750);

    final double baseFont = finalWidth * 0.045;
    final double titleFont = finalWidth * 0.06;

    final bool isLastStep = step == lastStep;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withValues(alpha: 0.8),
        ),
        Center(
          child: Container(
            width: finalWidth,
            height: finalHeight,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildStep(baseFont, titleFont),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastStep) {
                        widget.onFinish();
                      } else {
                        setState(() {
                          step++;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isLastStep
                          ? AppLocalizations.of(context)!.tipsFinishButton
                          : AppLocalizations.of(context)!.tipsStepButton,
                      style: TextStyle(
                        fontSize: baseFont,
                        color: AppColors.textWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
