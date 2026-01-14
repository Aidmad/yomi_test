import 'package:flutter/material.dart';

class LessonArrows extends StatelessWidget {
  final Color color;
  final double edgeMargin;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  const LessonArrows({
    super.key,
    this.color = Colors.black,
    this.edgeMargin = 4.0,
    this.onLeftTap,
    this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Scale size from screen width
          final screenWidth = constraints.maxWidth;

          double arrowSize = screenWidth * 0.06; // 6% of width

          // Clamp so size is never too small or too big
          arrowSize = arrowSize.clamp(18.0, 36.0);

          final verticalCenter =
              constraints.maxHeight / 2 - arrowSize / 2;

          return Stack(
            children: [
              // Left arrow
              Positioned(
                left: edgeMargin,
                top: verticalCenter,
                child: GestureDetector(
                  onTap: onLeftTap,
                  behavior: HitTestBehavior.translucent,
                  child: Transform.rotate(
                    angle: 3.14159,
                    child: Icon(
                      Icons.arrow_forward,
                      size: arrowSize,
                      color: color,
                    ),
                  ),
                ),
              ),

              // Right arrow
              Positioned(
                right: edgeMargin,
                top: verticalCenter,
                child: GestureDetector(
                  onTap: onRightTap,
                  behavior: HitTestBehavior.translucent,
                  child: Icon(
                    Icons.arrow_forward,
                    size: arrowSize,
                    color: color,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
