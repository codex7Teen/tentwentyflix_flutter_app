import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/features/search/bloc/movie_genre_bloc/movie_genre_bloc.dart';
import 'package:tentwentyflix/features/search/bloc/movie_search_bloc/movie_search_bloc.dart';
import 'package:tentwentyflix/features/search/presentation/widgets/search_screen_widgets.dart';
import 'package:tentwentyflix/shared/user_friendly_error_display_widget.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    //! F E T C H  U P C O M I N G  M O V I E S
    context.read<MovieGenreBloc>().add(FetchMovieGenre());

    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    log("SCREEN HEIGHT: ${screenHeight.toString()}");

    //! S T A T U S - B A R
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.whiteColor, // Background color
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
          if (searchState is MovieSearchLoading) {
            return Center(child: CircularProgressIndicator()); // Loading state
          } else if (searchState is MovieSearchError) {
            return Center(
              child: Text(
                searchState.message,
                style: TextStyle(color: Colors.red), // Error message
              ),
            );
          } else if (searchState is MovieSearchLoaded) {
            //! S H O W  S E A R C H  R E S U L T S
            return SearchScreenWidgets.buildSearchResults(
              searchState,
              screenHeight,
              screenWidth,
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
            return BlocBuilder<MovieGenreBloc, MovieGenreState>(
              builder: (context, genreState) {
                if (genreState is MovieGenreError) {
                  return UserFriendlyErrorDisplayWidget(
                    errorMessage: genreState.message,
                  );
                } else if (genreState is MovieGenreLoading) {
                  // Just showing a sizedbox instead of progress indicatore or shimmer to avoid ui breaks
                  return SizedBox.shrink();
                } else if (genreState is MovieGenreLoaded) {
                  //! S H O W  G E N R E S
                  return SearchScreenWidgets.buildGenreList(
                    genreState,
                    screenHeight,
                  );
                }
                return SizedBox.shrink(); // Default empty state
              },
            );
          }
        },
      ),
    );
  }
}
