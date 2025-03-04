import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/app_constants.dart';
import 'package:tentwentyflix/features/home/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:tentwentyflix/features/home/presentation/widgets/home_screen_widgets.dart';

class ScreenHome extends StatelessWidget {
  // Callback for navigating to search screen
  final VoidCallback onSearchTap;

  const ScreenHome({super.key, required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    //! FETCH UPCOMING MOVIES
    context.read<UpcomingMovieBloc>().add(FetchUpcomingMovies());
    final screenHeight = MediaQuery.sizeOf(context).height;
    log("SCREEN HEIGHT: ${screenHeight.toString()}");

    //! SET STATUS BAR STYLE
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor, // Background color: white
        statusBarIconBrightness: Brightness.dark, // Icons: dark mode
      ),
    );

    //! SCAFFOLD WITH APP BAR AND MOVIE LIST
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      appBar: HomeScreenWidgets.buildAppbar(screenHeight, onSearchTap),
      body: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
        builder: (context, state) {
          if (state is UpcomingMovieError) {
            // Show error message if fetching movies fails
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          } else if (state is UpcomingMovieLoading) {
            // Show a loading indicator while fetching movies
            return Center(child: CircularProgressIndicator());
          } else if (state is UpcomingMovieLoaded) {
            // Display the movie list when data is available
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies[index];

                      //! CONSTRUCT MOVIE IMAGE URL
                      final imageUrl =
                          "${AppConstants.imageBaseUrl}${movie.posterPath}";

                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 18,
                          left: 20,
                          right: 20,
                        ),
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
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
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

                                //! BLACK GRADIENT SHADOW (Bottom to Center)
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height:
                                        screenHeight *
                                        0.15, // Adjust shadow height
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.center,
                                        colors: [
                                          AppColors.blackColor.withValues(
                                            alpha: 1,
                                          ), // Dark at the bottom
                                          AppColors.blackColor.withValues(
                                            alpha: 0.7,
                                          ), // Medium fade
                                          AppColors.blackColor.withValues(
                                            alpha: 0.3,
                                          ), // Bit more medium fade
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
                                    movie.title, // Movie title displayed
                                    style:
                                        AppTextstyles.headingTextPoppinsWhite,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10), // Space at the bottom of the list
              ],
            );
          }
          return SizedBox.shrink(); // Return an empty widget if no state matches
        },
      ),
    );
  }
}
