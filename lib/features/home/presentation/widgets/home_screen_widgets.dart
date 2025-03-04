import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';

class HomeScreenWidgets {
  static PreferredSizeWidget buildAppbar(
    double screenHeight,
    void Function()? onTap,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        screenHeight > 500 ? screenHeight * 0.084 : screenHeight * 0.12,
      ),
      child: SafeArea(
        child: Material(
          elevation: 1, // Lower elevation to reduce shadow spread
          shadowColor: AppColors.blackColor.withValues(alpha: 0.10),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Watch',
                  style: AppTextstyles.headingTextPoppinsDarkPurple,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 22, top: 16),
                child: GestureDetector(
                  onTap: onTap,
                  child: Icon(
                    Icons.search_rounded,
                    color: AppColors.blackColor,
                    size: 23.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
