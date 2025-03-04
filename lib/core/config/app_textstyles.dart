import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';

class AppTextstyles {
  static TextStyle headingTextPoppinsBlack = GoogleFonts.poppins(
    fontSize: 17.5,
    color: AppColors.blackColor,
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
