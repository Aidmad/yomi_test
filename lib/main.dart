import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/navigation/navigation_root.dart';
import 'package:jp_reading/data/progress_data.dart';
import 'package:jp_reading/data/selected_count.dart';
import 'package:jp_reading/functions/main_screen/check_count.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jp_reading/startup/startup_state.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize tooltips and startup logic
  await StartupState.init();

  // 2. Load progress data
  await loadProgressData();

  // 3. Load selected counts
  await SelectedCount.loadFromPrefs();

  // 4. Evaluate button state
  CheckCount.evaluateButtonState();

  // 5. Hide system bars
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // 6. Run the app
  runApp(const JPReadingApp());

  // 7. Post-frame callback for startup-dependent logic
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      CheckCount.evaluateStartup(context);
    }
  });
}

class JPReadingApp extends StatelessWidget {
  const JPReadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'よみTest',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.appBG,
      ),
      home: NavigationRoot(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
