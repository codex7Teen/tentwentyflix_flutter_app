import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';

class AppTextstyles {
  static TextStyle headingTextPoppinsDarkPurple = GoogleFonts.poppins(
    fontSize: 17.8,
    color: AppColors.darkPurpleThemeColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle genresTextsWhite = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle blackBoldPoppinsMediumText = GoogleFonts.poppins(
    color: AppColors.blackColor,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subHeadingTextPoppinsDarkpurple = GoogleFonts.poppins(
    fontSize: 15,
    color: AppColors.darkPurpleThemeColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headingTextPoppinsWhite = GoogleFonts.poppins(
    fontSize: 17.8,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle searchBarHintText = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.darkGreyThemeColor,
  );

  static TextStyle miniTextBlack = GoogleFonts.poppins(
    color: AppColors.blackColor,
    fontSize: 8.94,
    fontWeight: FontWeight.bold,
  );
}
