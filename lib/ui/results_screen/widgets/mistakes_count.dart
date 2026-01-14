import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/results_screen/count_mistakes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MistakesCount extends StatelessWidget {
  const MistakesCount({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final fontSize = (screenWidth * 0.045).clamp(14.0, 28.0);

    final int totalWrongAnswersInt =
        int.tryParse(totalWrongAnswers.toString()) ?? 0;

    final String mistakeWord = totalWrongAnswersInt == 1
        ? AppLocalizations.of(context)!.mistake2
        : AppLocalizations.of(context)!.mistake3;

    return Center(
      child: Text(
        '${AppLocalizations.of(context)!.mistake1}'
            '$totalWrongAnswersInt'
            '$mistakeWord'
            '${AppLocalizations.of(context)!.mistake4}',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textBlack,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
