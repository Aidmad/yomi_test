import 'package:flutter/material.dart';
import 'package:jp_reading/data/selected_count.dart';
import 'package:jp_reading/ui/main_screen/widgets/kana_warning.dart';

class CheckCount {
  static final ValueNotifier<bool> buttonEnabledNotifier = ValueNotifier(false);

  /// Update only the button state (no popup needed)
  static void evaluateButtonState() {
    final count = SelectedCount.count;
    buttonEnabledNotifier.value = (count == 10);
  }

  /// Update button state and show popup if >10
  static void evaluateSelection(BuildContext context) {
    final count = SelectedCount.count;

    if (count == 10) {
      buttonEnabledNotifier.value = true;
    } else {
      buttonEnabledNotifier.value = false;

      if (count > 10) {
        // Show popup
        KanaWarningPopup.show(context).then((_) {
          final extraBlocks = SelectedCount.selectedKana.skip(10).toList();

          for (var kana in extraBlocks) {
            SelectedCount.updateSelection(false, kana);
          }

          // Recalculate button state AFTER cleanup
          CheckCount.evaluateButtonState();
        });

      }
    }
  }

  static Future<void> evaluateStartup(BuildContext context) async {
    final count = SelectedCount.count;

    if (count > 10) {
      await KanaWarningPopup.show(context);

      final extraBlocks = SelectedCount.selectedKana.skip(10).toList();
      for (var kana in extraBlocks) {
        SelectedCount.updateSelection(false, kana);
      }

      evaluateButtonState();
    } else {
      evaluateButtonState();
    }
  }

  /// Check if navigation is allowed (exactly 10 blocks)
  static bool canNavigate() => SelectedCount.count == 10;
}