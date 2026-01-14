import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/ui/results_screen/widgets/circle_bar.dart';
import 'package:jp_reading/ui/results_screen/widgets/mistake_panel.dart';
import 'package:jp_reading/ui/results_screen/widgets/mistakes_count.dart';
import 'package:jp_reading/ui/results_screen/widgets/continue_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/tooltips/result_screen/result_tips.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey resultsScreenKey = GlobalKey();

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool showResultTips = false; // initially false, will be set after checking prefs

  @override
  void initState() {
    super.initState();
    _checkShowResultTips();
  }

  Future<void> _checkShowResultTips() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? hasShownResultTips = prefs.getBool('hasShownResultTips');

    if (hasShownResultTips != true) {
      // Show overlay if never shown
      setState(() {
        showResultTips = true;
      });
      await prefs.setBool('hasShownResultTips', true);
    }
  }

  void closeResultTips() {
    setState(() {
      showResultTips = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final appBarHeight = screenHeight * 0.08;
    final titleFontSize = appBarHeight * 0.5;
    final textFontSize = screenWidth * 0.065;

    return Stack(
      children: [
        Scaffold(
          key: resultsScreenKey,
          backgroundColor: AppColors.appBG,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(appBarHeight),
            child: AppBar(
              backgroundColor: AppColors.appBar,
              automaticallyImplyLeading: false,
              title: Container(
                height: appBarHeight,
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.result,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appBarText,
                  ),
                ),
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: constraints.maxHeight < 500
                    ? const AlwaysScrollableScrollPhysics()
                    : const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.completed,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textBlack,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(child: CircleBar()),
                      SizedBox(height: screenHeight * 0.03),
                      MistakePanel(),
                      SizedBox(height: screenHeight * 0.02),
                      MistakesCount(),
                      SizedBox(height: screenHeight * 0.01),
                      ContinueButton(),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Overlay ResultTips only if showResultTips is true
        if (showResultTips)
          ResultTips(
            onFinish: closeResultTips,
          ),
      ],
    );
  }
}
