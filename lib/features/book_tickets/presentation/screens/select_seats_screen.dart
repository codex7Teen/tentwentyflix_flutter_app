import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/screen_dimension_util.dart';
import 'package:tentwentyflix/shared/custom_blue_button.dart';
import 'package:tentwentyflix/shared/custom_control_button.dart';
import 'package:tentwentyflix/shared/custom_movie_seat_widget.dart';

class ScreenSelectSeats extends StatelessWidget {
  // final MovieModel movieModel;
  ScreenSelectSeats({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    final screenWidth = ScreenDimensionsUtil.getScreenWidth(context);
    // list of dates
    final List<DateTime> dates = List.generate(
      10,
      (index) => DateTime.now().add(Duration(days: index)),
    );
    int rows = 16;
    int cols = 32;
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      //! A P P - B A R
      appBar: PreferredSize(
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //! SPACING
          SizedBox(height: screenHeight * 0.06),
          //! MOVIE SCREEN
          Padding(
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
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                    style: AppTextstyles.searchBarHintText.copyWith(
                      fontSize: 12,
                    ),
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
          ),
          SizedBox(height: screenHeight * 0.18),

          //! CONTROL BUTTONS
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomControlButton(icon: Icons.add),
                CustomControlButton(icon: Icons.remove),
              ],
            ),
          ),
          SizedBox(height: 8),
          //! SCROLL DIRECTOR BEAM
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
            child: Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor2,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          //! BOTTOM SECTION
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(color: AppColors.whiteColor),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
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
                            CustomMovieSeatWidget(
                              color: AppColors.lightGreyColor,
                            ),
                            buildSelectedSeatText('Not available'),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            CustomMovieSeatWidget(color: AppColors.genreColor3),
                            buildSelectedSeatText('VIP (150\$)'),
                            SizedBox(width: screenWidth * 0.163),
                            CustomMovieSeatWidget(
                              color: AppColors.blueThemeColor,
                            ),
                            buildSelectedSeatText('Regular (50 \$)'),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.001),
                        //! SEAT ROW
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
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
                                style: GoogleFonts.poppins(
                                  color: AppColors.darkPurpleThemeColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '/',
                                style: GoogleFonts.poppins(
                                  color: AppColors.darkPurpleThemeColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '3 row',
                                style: GoogleFonts.poppins(
                                  color: AppColors.darkPurpleThemeColor,
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
                                    style: AppTextstyles
                                        .headingTextPoppinsDarkPurple
                                        .copyWith(fontSize: 15),
                                  ),
                                  Text(
                                    '\$ 50',
                                    style: AppTextstyles
                                        .headingTextPoppinsDarkPurple
                                        .copyWith(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 19,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: CustomBlueButton(buttonName: 'Proceed to pay'))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //! BLACK GRADIENT SHADOW (Bottom to Center)
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
          ),
        ],
      ),
    );
  }

  buildSelectedSeatText(String text) {
    return Text(
      text,
      style: AppTextstyles.searchBarHintText,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  final Random random = Random();

  final List<Color> colors = [
    AppColors.blueThemeColor,
    AppColors.genreColor1,
    AppColors.genreColor2,
    Colors.grey,
  ];
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color =
              AppColors
                  .blueThemeColor // Match with theme
          ..strokeWidth = 0.4
          ..style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      size.height,
    ); // Arc shape

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
