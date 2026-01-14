import 'package:jp_reading/navigation/navigation_root.dart';

class LearnButton {
  /// Called to perform navigation when button is tapped
  static void navigateToTestScreen() {
    NavigationRoot.navTo('test');
  }
}
