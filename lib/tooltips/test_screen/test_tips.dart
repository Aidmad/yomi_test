import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/tooltips/test_screen/widgets/test_screen_tip.dart';
import 'package:jp_reading/tooltips/test_screen/widgets/kana_tip.dart';
import 'package:jp_reading/tooltips/test_screen/widgets/type_tips.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestTips extends StatefulWidget {
  final VoidCallback onFinish;
  const TestTips({super.key, required this.onFinish});

  @override
  State<TestTips> createState() => _TestTipsState();
}

class _TestTipsState extends State<TestTips> {
  int currentStep = 0; // 0 = TestScreenTip, 1 = KanaTip, 2 = TypeTips

  void _handleNext() {
    if (currentStep < 2) {
      setState(() => currentStep += 1);
    } else {
      widget.onFinish();
    }
  }

  Widget _getCurrentTip() {
    switch (currentStep) {
      case 0:
        return const TestScreenTip();
      case 1:
        return const KanaTip();
      case 2:
        return const TypeTips();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double panelWidth = size.width * 0.8;
    final double panelHeight = size.height * 0.75;
    final double finalWidth = panelWidth.clamp(260, 550);
    final double finalHeight = panelHeight.clamp(380, 620);

    final String buttonText = currentStep < 2
        ? AppLocalizations.of(context)!.tipsStepButton
        : AppLocalizations.of(context)!.tipsFinishButton;

    return Positioned.fill(
      child: Stack(
        children: [
          // Background overlay
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.black.withValues(alpha: 0.8),
            ),
          ),
          Center(
            child: Container(
              width: finalWidth,
              height: finalHeight,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.appBG,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: _getCurrentTip(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _handleNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
