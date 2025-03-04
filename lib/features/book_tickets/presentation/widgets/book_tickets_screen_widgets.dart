import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/features/book_tickets/presentation/screens/select_seats_screen.dart';
import 'package:tentwentyflix/features/book_tickets/presentation/widgets/arc_painter_widget.dart';
import 'package:tentwentyflix/shared/custom_blue_button.dart';
import 'package:tentwentyflix/shared/navigation_helper.dart';

class BookTicketsScreenWidgets {
  static buildAppbar(double screenHeight, BuildContext context) {
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
                    'movieModel.title',
                    style: AppTextstyles.headingTextPoppinsDarkPurple,
                  ),
                  Text(
                    "In Theaters {FormatDateUtil.formatReleaseDate(movieModel.releaseDate)}",
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

  static buildDatesListView() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          final date = dates[index];
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
              decoration: BoxDecoration(
                color:
                    index < 1
                        ? AppColors.blueThemeColor
                        : AppColors.lightGreyColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('d MMM').format(date),
                    style: AppTextstyles.genresTextsWhite.copyWith(
                      color:
                          index < 1
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static buildDateText() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text('Date', style: AppTextstyles.headingTextPoppinsDarkPurple),
    );
  }

  static buildHorizontalMovieScreens(double screenHeight, double screenWidth) {
    return SizedBox(
      height: screenHeight * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //! TIME AND MOVIE SCREEN NAME
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        index < 1 ? '12:30' : '13:30',
                        style: AppTextstyles.subHeadingTextPoppinsDarkpurple,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Cinetech + Hall 1',
                      style: AppTextstyles.searchBarHintText,
                    ),
                  ],
                ),

                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Container for Seats
                    Container(
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.215,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              index < 1
                                  ? AppColors.blueThemeColor
                                  : AppColors.lightGreyColor,
                        ),
                      ),
                      child: GridView.builder(
                        padding: EdgeInsets.all(40),
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

                    // Curved Arc
                    Positioned(
                      child: SizedBox(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.042, // Control arc size
                        child: CustomPaint(painter: ArcPainter()),
                      ),
                    ),
                  ],
                ),

                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('From', style: AppTextstyles.searchBarHintText),
                    Text(
                      index < 1 ? "50\$" : "75\$",
                      style: AppTextstyles.blackBoldPoppinsMediumText,
                    ),
                    Text('or', style: AppTextstyles.searchBarHintText),
                    Text(
                      index < 1 ? "2500 bonus" : "3000 bonus",
                      style: AppTextstyles.blackBoldPoppinsMediumText,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static final Random random = Random();

  static final List<Color> colors = [
    AppColors.blueThemeColor,
    AppColors.genreColor1,
    AppColors.genreColor2,
    AppColors.darkGreyThemeColor,
  ];

  // thetre seat grid columns and rows
  static const int rows = 16;
  static const int cols = 30;

  // list of dates
  static final List<DateTime> dates = List.generate(
    10,
    (index) => DateTime.now().add(Duration(days: index)),
  );

  static buildSelectSeatsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: CustomBlueButton(
        buttonName: 'Select Seats',
        onTap:
            () => NavigationHelper.navigateToWithoutReplacement(
              context,
              ScreenSelectSeats(),
            ),
      ),
    );
  }
}
