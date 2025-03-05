import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/genre_util.dart';
import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/features/details/presentation/screens/movie_details_screen.dart';
import 'package:tentwentyflix/features/search/bloc/movie_genre_bloc/movie_genre_bloc.dart';
import 'package:tentwentyflix/features/search/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:tentwentyflix/features/search/presentation/screens/search_results_screen.dart';
import 'package:tentwentyflix/shared/navigation_helper.dart';

class SearchScreenWidgets {
  static PreferredSizeWidget buildAppbar(
    BuildContext context,
    double screenHeight,
  ) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        screenHeight > 500 ? screenHeight * 0.1 : screenHeight * 0.17,
      ),
      child: SafeArea(
        child: Material(
          elevation: 1,
          shadowColor: AppColors.blackColor.withValues(alpha: 0.10),
          child: AppBar(
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor2,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search_rounded,
                        color: AppColors.blackColor,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "TV shows, movies and more",
                            border: InputBorder.none,
                            hintStyle: AppTextstyles.searchBarHintText,
                          ),
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              context.read<MovieSearchBloc>().add(
                                SearchMovies(query: value),
                              );
                            } else {
                              context.read<MovieSearchBloc>().add(
                                ClearSearch(),
                              );
                            }
                          },
                          onFieldSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              final state =
                                  context.read<MovieSearchBloc>().state;
                              if (state is MovieSearchLoaded) {
                                NavigationHelper.navigateToWithoutReplacement(
                                  context,
                                  ScreenSearchResults(movies: state.movies),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<MovieSearchBloc>().add(ClearSearch());
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/icons/close_icon.png',
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildMovieItem(
    BuildContext context,
    MovieModel movie,
    double screenHeight,
    double screenWidth,
  ) {
    return GestureDetector(
      onTap:
          () => NavigationHelper.navigateToWithoutReplacement(
            context,
            ScreenMovieDetails(movieModel: movie),
          ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            // Movie poster
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                movie.getFullPosterPath(),
                width: screenWidth * 0.39,
                height: screenHeight * 0.12,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: screenWidth * 0.39,
                    height: screenHeight * 0.12,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.movie, size: 40, color: Colors.grey),
                  );
                },
              ),
            ),

            // Movie details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextstyles.headingTextPoppinsDarkPurple,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          // Display genre names
                          Text(
                            GenreUtil.getGenreNames(movie.genreIds),
                            style: GoogleFonts.poppins(
                              color: AppColors.lightGreyColor,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Image.asset(
                        'assets/icons/threedots_icon_blue.png',
                        width: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static buildSearchResults(
    MovieSearchLoaded searchState,
    double screenHeight,
    double screenWidth,
  ) {
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
  }

  static buildGenreList(MovieGenreLoaded genreState, double screenHeight) {
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12, // Adds vertical spacing between items
                crossAxisSpacing: 12, // Adds horizontal spacing between items
                childAspectRatio: 15 / 9, // Adjust to control height
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
                          context.read<MovieGenreBloc>().getGenreImagePath(
                            genre.name,
                          ),
                          fit: BoxFit.cover,
                        ),

                        //! BLACK GRADIENT SHADOW (Bottom to Center)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: screenHeight * 0.15, // Adjust shadow height
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
                            style: AppTextstyles.headingTextPoppinsWhite,
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
}
