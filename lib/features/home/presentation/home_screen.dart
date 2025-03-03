import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    log("SCREEN HEIGHT: ${screenHeight.toString()}");

    //! S T A T U S - B A R
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:
            AppColors.whiteColor, // Set status bar background color to black
        statusBarIconBrightness: Brightness.dark, // Set icons to light mode
      ),
    );

    //! S C A F F O L D
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      //! A P P - B A R
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          screenHeight > 500 ? screenHeight * 0.084 : screenHeight * 0.15,
        ),
        child: SafeArea(
          child: AppBar(
            backgroundColor: AppColors.whiteColor,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Watch',
                  style: AppTextstyles.headingTextPoppinsBlack,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 16),
                child: Icon(
                  Icons.search_rounded,
                  color: AppColors.blackColor,
                  size: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
