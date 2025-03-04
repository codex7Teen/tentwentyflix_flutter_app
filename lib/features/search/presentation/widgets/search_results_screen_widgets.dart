import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';

class SearchResultsScreenWidgets {
  static PreferredSizeWidget buildAppbar(
    double screenHeight,
    BuildContext context,
    int movieCount,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        screenHeight > 500 ? screenHeight * 0.084 : screenHeight * 0.12,
      ),
      child: SafeArea(
        child: Material(
          elevation: 1, // Lower elevation to reduce shadow spread
          shadowColor: AppColors.blackColor.withValues(alpha: 0.1),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "$movieCount Results Found",
                style: AppTextstyles.headingTextPoppinsDarkPurple,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.darkPurpleThemeColor,
                  size: 22,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
