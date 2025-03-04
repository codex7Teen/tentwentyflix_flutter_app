import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/features/search/bloc/bloc/movie_genre_bloc.dart';
import 'package:tentwentyflix/features/search/presentation/widgets/search_screen_widgets.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    //! FETCH UPCOMING MOVIES
    context.read<MovieGenreBloc>().add(FetchMovieGenre());
    final screenHeight = MediaQuery.sizeOf(context).height;
    log("SCREEN HEIGHT: ${screenHeight.toString()}");

    //! S T A T U S - B A R
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor, // Set status bar background color
        statusBarIconBrightness: Brightness.dark, // Dark icons
      ),
    );

    //! S C A F F O L D
    return Scaffold(
      backgroundColor: AppColors.whiteColor2,
      //! A P P - B A R
      appBar: SearchScreenWidgets.buildAppbar(context, screenHeight),
      body: BlocBuilder<MovieGenreBloc, MovieGenreState>(
        builder: (context, state) {
          if (state is MovieGenreError) {
            // Show error message if fetching movies fails
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)),
            );
          } else if (state is MovieGenreLoading) {
            // Show a loading indicator while fetching movies
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieGenreLoaded) {
            // Display the genre list when data is available
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing:
                            12, // Adds vertical spacing between items
                        crossAxisSpacing:
                            12, // Adds horizontal spacing between items
                        childAspectRatio:
                            15 /
                            9, // Adjust to control height (Increase value for shorter height)
                      ),
                      itemCount: state.genres.length,
                      itemBuilder: (context, index) {
                        final genre = state.genres[index];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.darkPurpleThemeColor,
                            ),
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                //! GENRE POSTER IMAGE
                                Image.asset(
                                  context
                                      .read<MovieGenreBloc>()
                                      .getGenreImagePath(genre.name),
                                  fit: BoxFit.cover,
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

                                //! GENRE TITLE TEXT
                                Positioned(
                                  bottom: 14,
                                  left: 18,
                                  child: Text(
                                    genre.name, // Genre title displayed
                                    style:
                                        AppTextstyles.headingTextPoppinsWhite,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
