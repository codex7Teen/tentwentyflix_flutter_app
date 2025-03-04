import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';

class AppTextstyles {
  static TextStyle headingTextPoppinsDarkPurple = GoogleFonts.poppins(
    fontSize: 17.5,
    color: AppColors.darkPurpleThemeColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle genresTextsWhite = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontSize: 14,
  );

  static TextStyle subHeadingTextPoppinsDarkpurple = GoogleFonts.poppins(
    fontSize: 15,
    color: AppColors.darkPurpleThemeColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headingTextPoppinsWhite = GoogleFonts.poppins(
    fontSize: 17.5,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle searchBarHintText = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.darkGreyThemeColor,
  );
}
