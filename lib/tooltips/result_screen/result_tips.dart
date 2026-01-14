import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/tooltips/result_screen/widgets/percent_tip.dart';
import 'package:jp_reading/tooltips/result_screen/widgets/mistake_cont.dart';

class ResultTips extends StatefulWidget {
  final VoidCallback onFinish;

  const ResultTips({super.key, required this.onFinish});

  @override
  State<ResultTips> createState() => _ResultTipsState();
}

class _ResultTipsState extends State<ResultTips> {
  bool _showPercentTip = true;

  void _onNextPressed() {
    if (_showPercentTip) {
      setState(() {
        _showPercentTip = false;
      });
    } else {
      // Call the onFinish callback to close the panel
      widget.onFinish();
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
                    child: _showPercentTip
                        ? const PercentTipWidget()
                        : const MistakeCont(),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onNextPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.button,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _showPercentTip
                          ? AppLocalizations.of(context)!.tipsStepButton
                          : AppLocalizations.of(context)!.tipsFinishButton,
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
