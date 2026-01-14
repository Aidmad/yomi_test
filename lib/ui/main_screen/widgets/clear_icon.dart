import 'package:jp_reading/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:jp_reading/functions/main_screen/clear_blocks.dart';

class ClearIcon extends StatelessWidget {
  const ClearIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final iconSize = (screenWidth + screenHeight) * 0.025;

    return GestureDetector(
      onTap: () {
        clearAllBlocks(context: context); // trigger button state update
      },
      child: Icon(
        Icons.close,
        color: AppColors.button,
        size: iconSize,
      ),
    );
  }
}
