import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';

class SearchScreenWidgets {
  static PreferredSizeWidget buildAppbar(
    BuildContext context,
    double screenHeight,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        screenHeight > 500 ? screenHeight * 0.1 : screenHeight * 0.17,
      ),
      child: SafeArea(
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          //! S E A R C H - B A R
          flexibleSpace: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                height: 54,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ), // Inner padding
                decoration: BoxDecoration(
                  color: AppColors.whiteColor2,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.blackColor,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "TV shows, movies and more",
                          border: InputBorder.none,
                          hintStyle: AppTextstyles.searchBarHintText,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle close action
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/icons/close_icon.png',
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
