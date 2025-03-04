import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';

class CustomControlButton extends StatelessWidget {
  final IconData icon;
  const CustomControlButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: AppColors.blackColor),
    );
  }
}
