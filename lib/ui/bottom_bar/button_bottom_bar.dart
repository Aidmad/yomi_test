import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/main_screen/check_count.dart';
import 'package:jp_reading/functions/bottom_bar/learn_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonBottomBar extends StatelessWidget {
  const ButtonBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Button height scales with screen height
    final buttonHeight = (screenHeight * 0.065).clamp(46.0, 60.0);

    return ValueListenableBuilder<bool>(
      valueListenable: CheckCount.buttonEnabledNotifier,
      builder: (context, isEnabled, _) {
        return SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Text size scales with actual button height
              final textSize = (constraints.maxHeight * 0.38).clamp(14.0, 20.0);

              return Material(
                color: isEnabled
                    ? AppColors.bottomBarButton
                    : AppColors.bottomBarButtonDisabled,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: isEnabled
                      ? () {
                    CheckCount.evaluateSelection(context);
                    if (CheckCount.canNavigate()) {
                      LearnButton.navigateToTestScreen();
                    }
                  }
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.bottomBarButton,
                      style: TextStyle(
                        color: AppColors.bottomBarButtonText,
                        fontSize: textSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
