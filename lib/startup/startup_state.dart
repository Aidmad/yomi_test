import 'package:shared_preferences/shared_preferences.dart';

class StartupState {
  static const _appTipsKey = 'app_tips_shown';

  /// Call this at app start to initialize any startup logic
  static Future<void> init() async {
    // You can preload or initialize other startup data here if needed
  }

  /// Returns true if the app tips have already been shown
  static Future<bool> hasShownAppTips() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_appTipsKey) ?? false;
  }

  /// Mark that the app tips have been shown
  static Future<void> markAppTipsShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_appTipsKey, true);
  }
}
