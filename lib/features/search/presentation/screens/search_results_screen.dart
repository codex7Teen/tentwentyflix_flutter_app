import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/utils/screen_dimension_util.dart';
import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/features/search/presentation/widgets/search_results_screen_widgets.dart';
import 'package:tentwentyflix/features/search/presentation/widgets/search_screen_widgets.dart';
import 'package:tentwentyflix/core/main_bottom_navigation/main_bottom_navigation.dart';

class ScreenSearchResults extends StatelessWidget {
  final List<MovieModel> movies;

  const ScreenSearchResults({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final screenHeight = ScreenDimensionsUtil.getScreenHeight(context);
    final screenWidth = ScreenDimensionsUtil.getScreenWidth(context);

    // Accessing the MainBottomNavigationState to get the bottom navigation bar
    final bottomNavBar = bottomNavKey.currentState?.buildBottomNavigationBar();

    //! S C A F F O L D
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: SearchResultsScreenWidgets.buildAppbar(
        screenHeight,
        context,
        movies.length,
      ),
      //! B O D Y
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return SearchScreenWidgets.buildMovieItem(
              context,
              movie,
              screenHeight,
              screenWidth,
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavBar,
    );
  }
}
