import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/test_screen/back_button.dart';
import 'package:jp_reading/functions/test_screen/typed_text.dart';
import 'package:jp_reading/ui/test_screen/widgets/round_counter.dart';
import 'package:jp_reading/ui/test_screen/widgets/kana_card.dart';
import 'package:jp_reading/ui/test_screen/widgets/input_field.dart';
import 'package:jp_reading/ui/test_screen/widgets/input_buttons.dart';
import 'package:jp_reading/ui/test_screen/widgets/check_button.dart';
import 'package:jp_reading/functions/test_screen/next_kana.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/tooltips/test_screen/test_tips.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  static final GlobalKey testScreenKey = GlobalKey();

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool showTestTips = false; // initially false, will be set after checking prefs

  @override
  void initState() {
    super.initState();
    NextKanaController.instance.initialize();
    TypedText.initializeListener();
    _checkShowTestTips();
  }

  Future<void> _checkShowTestTips() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? hasShownTestTips = prefs.getBool('hasShownTestTips');

    if (hasShownTestTips != true) {
      // Show tips if never shown
      setState(() {
        showTestTips = true;
      });
      await prefs.setBool('hasShownTestTips', true);
    }
  }

  @override
  void dispose() {
    TypedText.clear();
    super.dispose();
  }

  void closeTips() {
    setState(() {
      showTestTips = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final titleFontSize = screenWidth * 0.08;
    final appBarHeight = titleFontSize * 1.8;

    return Stack(
      children: [
        Scaffold(
          key: TestScreen.testScreenKey,
          backgroundColor: AppColors.appBG,
          appBar: AppBar(
            toolbarHeight: appBarHeight,
            backgroundColor: AppColors.appBar,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.backButton,
                size: titleFontSize,
              ),
              onPressed: navigateBackToMain,
            ),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                AppLocalizations.of(context)!.testTitle,
                style: TextStyle(
                  color: AppColors.appBarText,
                  fontWeight: FontWeight.bold,
                  fontSize: titleFontSize,
                ),
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    children: [
                      RoundCounter(),
                      SizedBox(height: screenHeight * 0.001),
                      KanaCard(),
                      SizedBox(height: screenHeight * 0.02),
                      InputField(),
                      SizedBox(height: screenHeight * 0.02),
                      InputButtons(),
                      SizedBox(height: screenHeight * 0.02),
                      CheckButton(),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Tooltip overlay
        if (showTestTips)
          TestTips(
            onFinish: closeTips,
          ),
      ],
    );
  }
}
