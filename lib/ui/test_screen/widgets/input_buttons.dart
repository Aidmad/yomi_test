import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/test_screen/type_input.dart';

class InputButtons extends StatelessWidget {
  const InputButtons({super.key});

  final List<String> firstRow = const ['w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'];
  final List<String> secondRow = const ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k'];
  final List<String> thirdRow = const ['z', 'c', 'b', 'n', 'm'];

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRow(context, firstRow),
            const SizedBox(height: 8),
            _buildRow(context, secondRow, horizontalPadding: 12),
            const SizedBox(height: 8),
            _buildRow(context, thirdRow, horizontalPadding: 24, includeBackspace: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
      BuildContext context,
      List<String> letters, {
        double horizontalPadding = 0,
        bool includeBackspace = false,
      }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonHeight = screenWidth * 0.09;
    final iconAndLetterSize = screenWidth * 0.04;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final letter in letters)
            Expanded(
              child: _SingleInputButton(
                letter: letter,
                height: buttonHeight,
                fontSize: iconAndLetterSize,
              ),
            ),
          if (includeBackspace) const SizedBox(width: 4),
          if (includeBackspace)
            SizedBox(
              width: buttonHeight * 1.2,
              height: buttonHeight,
              child: _BackspaceButton(fontSize: iconAndLetterSize),
            ),
        ],
      ),
    );
  }
}

class _SingleInputButton extends StatelessWidget {
  final String letter;
  final double height;
  final double fontSize;

  const _SingleInputButton({
    required this.letter,
    required this.height,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isPressed = ValueNotifier<bool>(false);

    return RepaintBoundary(
      child: ValueListenableBuilder<bool>(
        valueListenable: isPressed,
        builder: (context, pressed, _) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: height,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: pressed
                    ? AppColors.inputButtons.withValues(alpha: 0.8)
                    : AppColors.inputButtons,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                isPressed.value = true;
                Future.delayed(const Duration(milliseconds: 120), () {
                  isPressed.value = false;
                });
                TypeInput.typeLetter(letter);
              },
              child: Text(
                letter.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BackspaceButton extends StatelessWidget {
  final double fontSize;

  const _BackspaceButton({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isPressed = ValueNotifier<bool>(false);

    return RepaintBoundary(
      child: ValueListenableBuilder<bool>(
        valueListenable: isPressed,
        builder: (context, pressed, _) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: pressed
                  ? AppColors.inputButtons.withValues(alpha: 0.8)
                  : AppColors.inputButtons,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              isPressed.value = true;
              Future.delayed(const Duration(milliseconds: 120), () {
                isPressed.value = false;
              });
              TypeInput.removeLastLetter();
            },
            child: Icon(
              Icons.backspace_outlined,
              size: fontSize,
              color: AppColors.textWhite,
            ),
          );
        },
      ),
    );
  }
}
