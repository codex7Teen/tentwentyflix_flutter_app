import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/genre_util.dart';
import 'package:tentwentyflix/data/models/movie_model.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_bloc.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_state.dart';
import 'package:tentwentyflix/features/details/presentation/screens/trailer_player_screen.dart';
import 'package:tentwentyflix/features/details/presentation/widgets/no_trailer_dialog_widget.dart';

class ScreenMovieDetails extends StatelessWidget {
  final MovieModel movieModel;
  const ScreenMovieDetails({super.key, required this.movieModel});

  // Formatted Movie release date
  String formatReleaseDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      String formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return "Release date not available";
    }
  }

  @override
  Widget build(BuildContext context) {
    //! SET STATUS BAR STYLE
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:
            AppColors.transparentColor, // Background color: transparent
        statusBarIconBrightness: Brightness.light, // Icons: light mode
      ),
    );

    final screenHeight = MediaQuery.sizeOf(context).height;
    // final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //! STACK
            Stack(
              children: [
                SizedBox(
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
                      return Center(
                        child: Icon(Icons.error, color: AppColors.redColor),
                      );
                    },
                  ),
                ),

                //! BLACK GRADIENT SHADOW (Bottom to Center)
                Positioned(
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

                Positioned(
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
                          "In Theaters ${formatReleaseDate(movieModel.releaseDate)}",
                          style: AppTextstyles.headingTextPoppinsWhite,
                        ),
                        SizedBox(height: 12),
                        //! GET TICKETS BUTTON
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 85,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blueThemeColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Get Tickets',
                            style: AppTextstyles.headingTextPoppinsWhite,
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
                            padding: EdgeInsets.symmetric(
                              horizontal: 58,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.blueThemeColor,
                              ),
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
                ),

                //! BACK BUTTON & WATCH TEXT
                Positioned(
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
                      Text(
                        'Watch',
                        style: AppTextstyles.headingTextPoppinsWhite,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! G E N R E S - T E X T
                  Text(
                    'Genres',
                    style: AppTextstyles.headingTextPoppinsDarkPurple,
                  ),
                  SizedBox(height: 14),
                  //! A L L - G E N R E S
                  Wrap(
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
                                  genreColors
                                      .length]; // Pick a color for each genre

                          return Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              genreName,
                              style: AppTextstyles.genresTextsWhite,
                            ),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: 14),

                  //! D I V I D E R
                  Divider(color: AppColors.lightGreyColor, thickness: 0),
                  SizedBox(height: 12),
                  //! O V E R V I E W - T E X T
                  Text(
                    'Overview',
                    style: AppTextstyles.headingTextPoppinsDarkPurple,
                  ),
                  SizedBox(height: 15),

                  //! M O V I E - D E S C R I P T I O N
                  Text(
                    movieModel.overview.toString(),
                    maxLines: 50,
                    style: AppTextstyles.searchBarHintText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add this method to the ScreenMovieDetails class
  void _showTrailerDialog(BuildContext context) {
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
}
