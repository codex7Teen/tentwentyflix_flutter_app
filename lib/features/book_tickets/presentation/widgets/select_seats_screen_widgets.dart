import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/format_date_util.dart';
import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/features/book_tickets/presentation/widgets/arc_painter_widget.dart';
import 'package:tentwentyflix/shared/custom_blue_button.dart';
import 'package:tentwentyflix/shared/custom_control_button.dart';
import 'package:tentwentyflix/shared/custom_movie_seat_widget.dart';

class SelectSeatsScreenWidgets {
  static buildSeatSelectionGrid(double screenHeight, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 5),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Container for Seats
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 34),
                  child: Column(
                    children: List.generate(12, (index) {
                      return Text(
                        "${index + 1}",
                        style: AppTextstyles.miniTextBlack,
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.215,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 16,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols - 4,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: rows * (cols - 4),
                      itemBuilder: (context, index) {
                        int row = index ~/ (cols - 4);
                        int col = index % (cols - 4);

                        // Keep existing removed portions untouched
                        if ((col == 0 || col == (cols - 5)) && row < 4) {
                          return SizedBox();
                        }
                        if ((col == 1 || col == 2) && row == 0) {
                          return SizedBox();
                        }
                        if ((col == (cols - 6) || col == (cols - 7)) &&
                            row == 0) {
                          return SizedBox();
                        }
                        if (col == 0 && row == rows - 1) {
                          return SizedBox();
                        }
                        if (col == (cols - 5) && row == rows - 1) {
                          return SizedBox();
                        }

                        // Center aisle removal (already existing)
                        int centerStart = ((cols - 4) ~/ 2) - 2;
                        int centerEnd = centerStart + 4;
                        if (row == rows - 1 &&
                            col >= centerStart &&
                            col <= centerEnd) {
                          return SizedBox();
                        }

                        // **New: Remove 5th and 6th columns from the left**
                        if (col == 4 || col == 5) return SizedBox();

                        // **New: Remove 5th and 6th columns from the right**
                        if (col == (cols - 8) || col == (cols - 9)) {
                          return SizedBox();
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: colors[random.nextInt(colors.length)],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          //! SCREEN TEXT
          Positioned(
            top: 22,
            child: Text(
              "SCREEN",
              style: AppTextstyles.searchBarHintText.copyWith(fontSize: 12),
            ),
          ),

          //! Curved Arc
          Positioned(
            child: SizedBox(
              width: screenWidth * 0.85,
              height: screenHeight * 0.042, // Control arc size
              child: CustomPaint(painter: ArcPainter()),
            ),
          ),
        ],
      ),
    );
  }

  static buildBottomSection(double screenWidth, double screenHeight) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: AppColors.whiteColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  //! SEAT CATEGORIES
                  Row(
                    spacing: 10,
                    children: [
                      CustomMovieSeatWidget(color: AppColors.genreColor4),
                      buildSelectedSeatText('Selected'),
                      SizedBox(width: screenWidth * 0.18),
                      CustomMovieSeatWidget(color: AppColors.lightGreyColor),
                      buildSelectedSeatText('Not available'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      CustomMovieSeatWidget(color: AppColors.genreColor3),
                      buildSelectedSeatText('VIP (150\$)'),
                      SizedBox(width: screenWidth * 0.163),
                      CustomMovieSeatWidget(color: AppColors.blueThemeColor),
                      buildSelectedSeatText('Regular (50 \$)'),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.001),
                  //! SEAT ROW
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        Text(
                          '4',
                          style: AppTextstyles.headingTextPoppinsDarkPurple
                              .copyWith(fontSize: 17),
                        ),
                        Text(
                          '/',
                          style: AppTextstyles.headingTextPoppinsDarkPurple
                              .copyWith(fontSize: 18),
                        ),
                        Text(
                          '3 row',
                          style: AppTextstyles.headingTextPoppinsDarkPurple
                              .copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.close,
                          color: AppColors.darkPurpleThemeColor,
                        ),
                      ],
                    ),
                  ),

                  //! PRICE AND PAY BUTTON
                  Row(
                    spacing: 12,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              'Total Price',
                              style: AppTextstyles.headingTextPoppinsDarkPurple
                                  .copyWith(fontSize: 15),
                            ),
                            Text(
                              '\$ 50',
                              style: AppTextstyles.headingTextPoppinsDarkPurple
                                  .copyWith(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 19,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CustomBlueButton(buttonName: 'Proceed to pay'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //! BORDER SHADOW
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.lightGreyColor2.withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // list of dates
  static final List<DateTime> dates = List.generate(
    10,
    (index) => DateTime.now().add(Duration(days: index)),
  );

  // Number of theater seat row and columns
  static const int rows = 16;
  static const int cols = 32;

  static buildSelectedSeatText(String text) {
    return Text(
      text,
      style: AppTextstyles.searchBarHintText,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  static final Random random = Random();

  static final List<Color> colors = [
    AppColors.blueThemeColor,
    AppColors.genreColor1,
    AppColors.genreColor2,
    AppColors.darkGreyThemeColor,
  ];

  static buildScrollDirectorBeam() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
      child: Container(
        height: 6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor2,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  static buildControlButtons() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomControlButton(icon: Icons.add),
          CustomControlButton(icon: Icons.remove),
        ],
      ),
    );
  }

  static PreferredSizeWidget buildAppbar(
    double screenHeight,
    BuildContext context,
    MovieModel movieModel,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        screenHeight > 500 ? screenHeight * 0.084 : screenHeight * 0.175,
      ),
      child: SafeArea(
        child: Material(
          elevation: 1, // Lower elevation to reduce shadow spread
          shadowColor: AppColors.blackColor.withValues(alpha: 0.1),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    movieModel.title,
                    style: AppTextstyles.headingTextPoppinsDarkPurple,
                  ),
                  Text(
                    "In Theaters ${FormatDateUtil.formatReleaseDate(movieModel.releaseDate)}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.blueThemeColor,
                    ),
                  ),
                ],
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
