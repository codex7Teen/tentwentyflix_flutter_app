import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/utils/screen_dimension_util.dart';
import 'package:tentwentyflix/features/book_tickets/presentation/widgets/book_tickets_screen_widgets.dart';

class ScreenBookTickets extends StatelessWidget {
  // final MovieModel movieModel;
  const ScreenBookTickets({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    final screenWidth = ScreenDimensionsUtil.getScreenWidth(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      //! A P P - B A R
      appBar: BookTicketsScreenWidgets.buildAppbar(screenHeight, context),
      //! B O D Y
      body: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //! SPACING
            SizedBox(height: screenHeight * 0.1),
            //! DATE TEXT
            BookTicketsScreenWidgets.buildDateText(),
            //! SPACING
            const SizedBox(height: 10),
            //! DATES LIST VIEW (HORIZONTAL)
            BookTicketsScreenWidgets.buildDatesListView(),
            //! SPACING
            SizedBox(height: screenHeight * 0.04),
            //! BUILD SCREENS (HORIZONTAL)
            BookTicketsScreenWidgets.buildHorizontalMovieScreens(
              screenHeight,
              screenWidth,
            ),
            Spacer(),
            //! SELECT SEATS BUTTON
            BookTicketsScreenWidgets.buildSelectSeatsButton(context),
          ],
        ),
      ),
    );
  }
}
