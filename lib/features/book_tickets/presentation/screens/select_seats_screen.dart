import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/utils/screen_dimension_util.dart';
import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/features/book_tickets/presentation/widgets/select_seats_screen_widgets.dart';

class ScreenSelectSeats extends StatelessWidget {
  final MovieModel movieModel;
  const ScreenSelectSeats({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    final screenWidth = ScreenDimensionsUtil.getScreenWidth(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      //! A P P - B A R
      appBar: SelectSeatsScreenWidgets.buildAppbar(screenHeight, context),
      //! B O D Y
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //! SPACING
          SizedBox(height: screenHeight * 0.06),
          //! MOVIE SCREEN
          SelectSeatsScreenWidgets.buildSeatSelectionGrid(
            screenHeight,
            screenWidth,
          ),
          //! SPACING
          SizedBox(height: screenHeight * 0.18),

          //! CONTROL BUTTONS
          SelectSeatsScreenWidgets.buildControlButtons(),
          SizedBox(height: 8),
          //! SCROLL DIRECTOR BEAM
          SelectSeatsScreenWidgets.buildScrollDirectorBeam(),

          //! BOTTOM SECTION
          SelectSeatsScreenWidgets.buildBottomSection(
            screenWidth,
            screenHeight,
          ),
        ],
      ),
    );
  }
}
