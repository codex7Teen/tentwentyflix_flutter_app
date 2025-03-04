import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/data/repositories/movie_genre_repository.dart';
import 'package:tentwentyflix/data/repositories/movie_search_repository.dart';
import 'package:tentwentyflix/data/repositories/trailer_repository.dart';
import 'package:tentwentyflix/data/repositories/upcoming_movie_repository.dart';
import 'package:tentwentyflix/features/details/bloc/movie_trailer_bloc/trailer_bloc.dart';
import 'package:tentwentyflix/features/home/bloc/upcoming_movie_bloc/upcoming_movie_bloc.dart';
import 'package:tentwentyflix/features/search/bloc/movie_genre_bloc/movie_genre_bloc.dart';
import 'package:tentwentyflix/features/search/bloc/movie_search_bloc/movie_search_bloc.dart';

//! BLOC PROVIDERS
class AppBlocProviders {
  static List<BlocProvider> providers = [
    //!  B L O C   F O R   U P C O M I N G   M O V I E S
    BlocProvider<UpcomingMovieBloc>(
      create: (context) => UpcomingMovieBloc(UpcomingMovieRepository()),
    ),
    //!  B L O C   F O R   M O V I E   G E N R E S
    BlocProvider<MovieGenreBloc>(
      create: (context) => MovieGenreBloc(MovieGenreRepository()),
    ),
    //!  B L O C   F O R   S E A R C H   M O V I E S
    BlocProvider<MovieSearchBloc>(
      create: (context) => MovieSearchBloc(MovieSearchRepository()),
    ),
    //!  B L O C   F O R   T R A I L E R S
    BlocProvider<TrailerBloc>(
      create: (context) => TrailerBloc(TrailerRepository()),
    ),
  ];
}
