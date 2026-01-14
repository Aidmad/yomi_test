import 'package:jp_reading/data/selected_count.dart';
import 'package:jp_reading/functions/main_screen/check_count.dart';
import 'package:flutter/widgets.dart';

/// Clears all selected Hiragana blocks and updates their UI & button state.
void clearAllBlocks({BuildContext? context}) {
  SelectedCount.reset();

  // Update button state if context is available
  if (context != null) {
    CheckCount.evaluateSelection(context);
  }
}