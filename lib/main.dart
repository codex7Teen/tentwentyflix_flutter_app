import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/main_bottom_navigation/main_bottom_navigation.dart';
import 'package:tentwentyflix/data/repositories/movie_genre_repository.dart';
import 'package:tentwentyflix/data/repositories/movie_search_repository.dart';
import 'package:tentwentyflix/data/repositories/upcoming_movie_repository.dart';
import 'package:tentwentyflix/features/home/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:tentwentyflix/features/search/bloc/movie_genre_bloc/movie_genre_bloc.dart';
import 'package:tentwentyflix/features/search/bloc/movie_search_bloc/movie_search_bloc.dart';

//! ROOT
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final upcomingMovieRepository = UpcomingMovieRepository();
    final movieGenres = MovieGenreRepository();
    final searchMovies = MovieSearchRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpcomingMovieBloc(upcomingMovieRepository),
        ),
        BlocProvider(create: (context) => MovieGenreBloc(movieGenres)),
        BlocProvider(create: (context) => MovieSearchBloc(searchMovies)),
      ],
      child: MaterialApp(
        title: 'TEN_TWENTYFLIX',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.whiteColor,
          ), // White theme
          scaffoldBackgroundColor: AppColors.whiteColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            titleTextStyle: AppTextstyles.headingTextPoppinsDarkPurple,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: MainBottomNavigation(key: bottomNavKey),
      ),
    );
  }
}
