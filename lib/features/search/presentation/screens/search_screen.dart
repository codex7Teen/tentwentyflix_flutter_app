import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    log("SCREEN HEIGHT: ${screenHeight.toString()}");

    //! S T A T U S - B A R
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor, // Set status bar background color
        statusBarIconBrightness: Brightness.dark, // Dark icons
      ),
    );

    //! S C A F F O L D
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,

      //! A P P - B A R
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          screenHeight > 500 ? screenHeight * 0.1 : screenHeight * 0.17,
        ),
        child: SafeArea(
          child: AppBar(
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
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
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.darkGreyThemeColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle close action
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
      ),
    );
  }
}
