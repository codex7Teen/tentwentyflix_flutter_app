import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/features/search/bloc/movie_genre_bloc/movie_genre_bloc.dart';
import 'package:tentwentyflix/features/search/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:tentwentyflix/features/search/presentation/widgets/search_screen_widgets.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    //! FETCH UPCOMING MOVIES
    context.read<MovieGenreBloc>().add(FetchMovieGenre());
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
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
      body: BlocBuilder<MovieSearchBloc, MovieSearchState>(
        builder: (context, searchState) {
          // Show search results if there are any
          if (searchState is MovieSearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (searchState is MovieSearchError) {
            return Center(
              child: Text(
                searchState.message,
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (searchState is MovieSearchLoaded) {
            // Display search results
            return Padding(
              padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top Results",
                    style: AppTextstyles.subHeadingTextPoppinsDarkpurple,
                  ),
                  SizedBox(height: 2),
                  Divider(color: AppColors.lightGreyColor),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchState.movies.length,
                      itemBuilder: (context, index) {
                        final movie = searchState.movies[index];
                        return SearchScreenWidgets.buildMovieItem(
                          context,
                          movie,
                          screenHeight,
                          screenWidth,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (searchState is MovieSearchEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No movies found",
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ],
              ),
            );
          } else {
            // If no search is active, show the genres (default view)
            return BlocBuilder<MovieGenreBloc, MovieGenreState>(
              builder: (context, genreState) {
                if (genreState is MovieGenreError) {
                  // Show error message if fetching movies fails
                  return Center(
                    child: Text(
                      genreState.message,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (genreState is MovieGenreLoading) {
                  // Show a loading indicator while fetching movies
                  return Center(child: CircularProgressIndicator());
                } else if (genreState is MovieGenreLoaded) {
                  // Display the genre list when data is available and no input in search
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 26,
                            bottom: 8,
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing:
                                      12, // Adds vertical spacing between items
                                  crossAxisSpacing:
                                      12, // Adds horizontal spacing between items
                                  childAspectRatio:
                                      15 / 9, // Adjust to control height
                                ),
                            itemCount: genreState.genres.length,
                            itemBuilder: (context, index) {
                              final genre = genreState.genres[index];

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
                                              AppTextstyles
                                                  .headingTextPoppinsWhite,
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
                    ],
                  );
                }
                return SizedBox.shrink(); // Return an empty widget if no state matches
              },
            );
          }
        },
      ),
    );
  }
}
