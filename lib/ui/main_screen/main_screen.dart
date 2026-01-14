import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/ui/main_screen/widgets/hiragana/hiragana_sheet.dart';
import 'package:jp_reading/ui/main_screen/widgets/han_dakuon/han_dakuon_sheet.dart';
import 'package:jp_reading/ui/main_screen/widgets/yoon/yoon_sheet.dart';
import 'package:jp_reading/ui/bottom_bar/bottom_bar.dart';
import 'package:jp_reading/ui/main_screen/widgets/clear_icon.dart';
import 'package:jp_reading/tooltips/main_screen/app_tips.dart';
import 'package:jp_reading/ui/main_screen/widgets/lesson_arrows.dart';
import 'package:jp_reading/functions/main_screen/next_lesson.dart';
import 'package:jp_reading/startup/startup_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Widget _persistentBottomPanel = const BottomPanel();
  bool showAppTips = false;

  // Key to access NextLessonState
  final nextLessonKey = GlobalKey<NextLessonState>();

  @override
  void initState() {
    super.initState();
    _checkShowAppTips();
  }

  Future<void> _checkShowAppTips() async {
    // Check if the tooltip was already shown using StartupState
    final wasShown = await StartupState.hasShownAppTips(); // Implement this in StartupState
    if (!wasShown) {
      setState(() {
        showAppTips = true;
      });
    }
  }

  void closeAppTips() {
    StartupState.markAppTipsShown(); // Persist that tooltip was shown
    setState(() => showAppTips = false);
  }

  Widget _getCurrentSheet() {
    switch (nextLessonKey.currentState?.currentPage ?? LessonPage.hiragana) {
      case LessonPage.hiragana:
        return HiraganaSheet();
      case LessonPage.hanDakuon:
        return HanDakuonSheet();
      case LessonPage.yoon:
        return YoonSheet();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final titleFontSize = screenWidth * 0.08;
    final spaceSize = screenHeight * 0.015;

    return Stack(
      children: [
        // Invisible NextLesson instance to hold state
        NextLesson(
          key: nextLessonKey,
          onPageChanged: () => setState(() {}),
        ),

        Scaffold(
          backgroundColor: AppColors.appBG,
          appBar: AppBar(
            backgroundColor: AppColors.appBar,
            centerTitle: true,
            toolbarHeight: titleFontSize * 1.8,
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'かな',
                style: TextStyle(
                  color: AppColors.appBarText,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: ClearIcon(),
                        ),
                        const SizedBox(height: 1),
                        Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: _getCurrentSheet(),
                              ),
                              // Arrow overlay calls NextLesson
                              LessonArrows(
                                edgeMargin: 1.0,
                                onLeftTap: () {
                                  if (nextLessonKey.currentState != null) {
                                    nextLessonKey.currentState!.onLeftTap();
                                  }
                                },
                                onRightTap: () {
                                  if (nextLessonKey.currentState != null) {
                                    nextLessonKey.currentState!.onRightTap();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spaceSize),
                _persistentBottomPanel,
              ],
            ),
          ),
        ),

        if (showAppTips)
          AppTips(
            onFinish: closeAppTips,
          ),
      ],
    );
  }
}
