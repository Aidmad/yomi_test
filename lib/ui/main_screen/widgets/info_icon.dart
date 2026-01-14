import 'package:flutter/material.dart';
import 'package:jp_reading/theme/app_colors.dart';

class InfoIcon extends StatelessWidget {
  final VoidCallback onTap; // tap callback injected by parent

  const InfoIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 18,
        height: 18,
        decoration: const BoxDecoration(
          color: AppColors.iconBorder,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.priority_high,
          size: 14,
          color: AppColors.icon,
        ),
      ),
    );
  }
}
