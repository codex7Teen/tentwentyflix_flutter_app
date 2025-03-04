import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/format_date_util.dart';
import 'package:tentwentyflix/core/utils/genre_util.dart';
import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/features/book_tickets/presentation/screens/book_tickets_screen.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_bloc.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_state.dart';
import 'package:tentwentyflix/features/details/presentation/screens/trailer_player_screen.dart';
import 'package:tentwentyflix/features/details/presentation/widgets/no_trailer_dialog_widget.dart';
import 'package:tentwentyflix/shared/navigation_helper.dart';

class MovieDetailScreenWidgets {
  static buildImage(double screenHeight, MovieModel movieModel) {
    return SizedBox(
      height: screenHeight * 0.6,
      child: Image.network(
        movieModel.getFullPosterPath(),
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
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          log("Error loading image: $error");
          return Center(child: Icon(Icons.error, color: AppColors.redColor));
        },
      ),
    );
  }

  static buildShadowEffect(double screenHeight) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: screenHeight * 0.5, // Adjust shadow height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            colors: [
              AppColors.blackColor.withValues(alpha: 1), // Dark at the bottom
              AppColors.blackColor.withValues(alpha: 0.7), // Medium fade
              AppColors.blackColor.withValues(
                alpha: 0.3,
              ), // Bit more medium fade
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  static buildMovieWatchAndGetTickets(
    MovieModel movieModel,
    BuildContext context,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //! RELEASE DATE TEXT
            Text(
              "In Theaters ${FormatDateUtil.formatReleaseDate(movieModel.releaseDate)}",
              style: AppTextstyles.headingTextPoppinsWhite,
            ),
            SizedBox(height: 12),
            //! GET TICKETS BUTTON
            GestureDetector(
              onTap:
                  () => NavigationHelper.navigateToWithoutReplacement(
                    context,
                    ScreenBookTickets(movieModel: movieModel),
                  ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 85, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.blueThemeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Get Tickets',
                  style: AppTextstyles.headingTextPoppinsWhite,
                ),
              ),
            ),
            SizedBox(height: 10),

            //! WATCH TRAILER BUTTON
            GestureDetector(
              onTap: () {
                // Trigger trailer loading and playback
                context.read<TrailerBloc>().add(
                  LoadTrailerEvent(movieModel.id),
                );
                _showTrailerDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 58, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.blueThemeColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: AppColors.whiteColor,
                      size: 24,
                    ),
                    Text(
                      'Watch Trailer',
                      style: AppTextstyles.headingTextPoppinsWhite,
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

  // show trailer dialog
  static void _showTrailerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<TrailerBloc, TrailerState>(
          builder: (context, state) {
            if (state is TrailerLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is TrailerLoadedState) {
              if (state.trailers.isNotEmpty) {
                // Automatically play the first trailer
                context.read<TrailerBloc>().add(
                  PlayTrailerEvent(state.trailers.first.key),
                );
              } else {
                return NoTrailerDialogWidget();
              }
            }

            if (state is TrailerPlayingState &&
                state.playerController != null) {
              return TrailerPlayerScreen(
                videoKey: state.videoKey,
                playerController: state.playerController!,
              );
            }

            if (state is TrailerErrorState) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(state.errorMessage),
              );
            }

            return Container(); // Fallback empty container
          },
        );
      },
    );
  }

  static buildBackbuttonAndWatchtext(BuildContext context) {
    return Positioned(
      top: 50,
      left: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: AppColors.whiteColor,
                size: 22,
              ),
            ),
          ),
          Text('Watch', style: AppTextstyles.headingTextPoppinsWhite),
        ],
      ),
    );
  }

  static buildGenresText() {
    return Text('Genres', style: AppTextstyles.headingTextPoppinsDarkPurple);
  }

  static buildAllGenres(MovieModel movieModel) {
    return Wrap(
      spacing: 8.0, // Horizontal spacing between genres
      runSpacing: 8.0, // Vertical spacing when wrapped
      children:
          movieModel.genreIds.asMap().entries.map((entry) {
            final index = entry.key;
            final genreId = entry.value;
            final genreName = GenreUtil.getGenreName(genreId);

            // List of predefined colors (You can modify these)
            final List<Color> genreColors = [
              AppColors.genreColor1,
              AppColors.genreColor2,
              AppColors.genreColor3,
              AppColors.genreColor4,
            ];

            final color =
                genreColors[index %
                    genreColors.length]; // Pick a color for each genre

            return Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(genreName, style: AppTextstyles.genresTextsWhite),
            );
          }).toList(),
    );
  }

  static buildOverviewText() {
    return Text('Overview', style: AppTextstyles.headingTextPoppinsDarkPurple);
  }

  static buildMovieDescription(MovieModel movieModel) {
    return Text(
      movieModel.overview.toString(),
      maxLines: 50,
      style: AppTextstyles.searchBarHintText,
    );
  }
}
