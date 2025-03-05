import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/app_constants.dart';
import 'package:tentwentyflix/features/details/presentation/screens/movie_details_screen.dart';
import 'package:tentwentyflix/features/home/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:tentwentyflix/shared/navigation_helper.dart';

class HomeScreenWidgets {
  //! BUILD APP BAR
  static PreferredSizeWidget buildAppbar(
    double screenHeight,
    void Function()? onTap,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        screenHeight > 500 ? screenHeight * 0.084 : screenHeight * 0.12,
      ),
      child: SafeArea(
        child: Material(
          elevation: 1, // LOWER ELEVATION TO REDUCE SHADOW SPREAD
          shadowColor: AppColors.blackColor.withValues(alpha: 0.10),
          child: AppBar(
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Watch',
                  style: AppTextstyles.headingTextPoppinsDarkPurple,
                ),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.only(right: 22, top: 16),
                  child: Icon(
                    Icons.search_rounded,
                    color: AppColors.blackColor,
                    size: 23.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //! BUILD UPCOMING MOVIES LIST
  static buildUpcomingMoviesList(
    double screenHeight,
    UpcomingMovieLoaded state,
  ) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.movies.length,
        itemBuilder: (context, index) {
          final movie = state.movies[index];

          //! CONSTRUCT MOVIE IMAGE URL
          final imageUrl = "${AppConstants.imageBaseUrl}${movie.posterPath}";

          return GestureDetector(
            //! NAVIGATE TO MOVIE DETAILS SCREEN
            onTap:
                () => NavigationHelper.navigateToWithoutReplacement(
                  context,
                  ScreenMovieDetails(movieModel: movie),
                ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18, left: 20, right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.darkPurpleThemeColor,
                  ),
                  height: screenHeight * 0.22,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      //! MOVIE POSTER IMAGE
                      if (movie.posterPath != null)
                        Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            log("Error loading image: $error");
                            return Center(
                              child: Icon(
                                Icons.error,
                                color: AppColors.redColor,
                              ),
                            );
                          },
                        ),

                      //! BLACK GRADIENT SHADOW (BOTTOM TO CENTER)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: screenHeight * 0.15, // ADJUST SHADOW HEIGHT
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.center,
                              colors: [
                                AppColors.blackColor.withValues(
                                  alpha: 1,
                                ), // DARK AT THE BOTTOM
                                AppColors.blackColor.withValues(
                                  alpha: 0.7,
                                ), // MEDIUM FADE
                                AppColors.blackColor.withValues(
                                  alpha: 0.3,
                                ), // LIGHT FADE
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      //! MOVIE TITLE TEXT
                      Positioned(
                        bottom: 14,
                        left: 18,
                        child: Text(
                          movie.title, // MOVIE TITLE DISPLAYED
                          style: AppTextstyles.headingTextPoppinsWhite,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
