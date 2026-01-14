import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';
import 'package:jp_reading/functions/test_screen/count_rounds.dart';

class RoundCounter extends StatefulWidget {
  const RoundCounter({super.key});

  @override
  State<RoundCounter> createState() => _RoundCounterState();
}

class _RoundCounterState extends State<RoundCounter> {
  int _currentCount = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startCounterMonitor();
    });
  }

  void _startCounterMonitor() {
    _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (!mounted) return;

      final newCount = getCurrentRoundCount();
      if (newCount != _currentCount) {
        if (!mounted) return;
        setState(() {
          _currentCount = newCount;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.065; // scales relative to screen width

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$_currentCount/10',
          style: TextStyle(
            color: AppColors.textBlack,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
