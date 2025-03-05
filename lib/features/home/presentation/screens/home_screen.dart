import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/utils/screen_dimension_util.dart';
import 'package:tentwentyflix/features/home/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:tentwentyflix/features/home/presentation/widgets/home_screen_widgets.dart';
import 'package:tentwentyflix/shared/user_friendly_error_display_widget.dart';

class ScreenHome extends StatelessWidget {
  //! C A L L B A C K - S E A R C H
  final VoidCallback onSearchTap;

  const ScreenHome({super.key, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    //! F E T C H  U P C O M I N G  M O V I E S
    context.read<UpcomingMovieBloc>().add(FetchUpcomingMovies());

    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);

    //! S T A T U S - B A R
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor, // White background
        statusBarIconBrightness: Brightness.dark, // Dark icons
      ),
    );

    //! S C A F F O L D
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: HomeScreenWidgets.buildAppbar(screenHeight, onSearchTap),
      body: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
        builder: (context, state) {
          if (state is UpcomingMovieError) {
            //! S H O W  E R R O R
            return UserFriendlyErrorDisplayWidget(errorMessage: state.message);
          } else if (state is UpcomingMovieLoading) {
            //! S H O W  L O A D I N G
            return Center(child: CircularProgressIndicator());
          } else if (state is UpcomingMovieLoaded) {
            //! D I S P L A Y  M O V I E S
            return Column(
              children: [
                HomeScreenWidgets.buildUpcomingMoviesList(screenHeight, state),
                SizedBox(height: 10), // Space at the bottom
              ],
            );
          }
          return SizedBox.shrink(); // Empty widget
        },
      ),
    );
  }
}
