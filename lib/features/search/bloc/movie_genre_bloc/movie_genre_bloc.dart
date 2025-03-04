import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tentwentyflix/data/models/movie_generes_model.dart';
import 'package:tentwentyflix/data/repositories/movie_genre_repository.dart';

part 'movie_genre_event.dart';
part 'movie_genre_state.dart';

class MovieGenreBloc extends Bloc<MovieGenreEvent, MovieGenreState> {
  //! GET IMAGE PATH BASED ON API IMAGE DATA
  // Method to get image path based on api data
  String getGenreImagePath(String genreName) {
    switch (genreName) {
      case 'Action':
        return 'assets/images/horror.png';
      case 'Adventure':
        return 'assets/images/fantasy.png';
      case 'Animation':
        return 'assets/images/scifi.png';
      case 'Comedy':
        return 'assets/images/comedy.png';
      case 'Crime':
        return 'assets/images/crime.png';
      case 'Documentary':
        return 'assets/images/documentaty.png';
      case 'Drama':
        return 'assets/images/drama.png';
      case 'Family':
        return 'assets/images/family.png';
      case 'Fantasy':
        return 'assets/images/fantasy.png';
      case 'History':
        return 'assets/images/scifi.png';
      case 'Horror':
        return 'assets/images/horror.png';
      case 'Music':
        return 'assets/images/crime.png';
      case 'Mystery':
        return 'assets/images/documentaty.png';
      case 'Romance':
        return 'assets/images/fantasy.png';
      case 'Science Fiction':
        return 'assets/images/scifi.png';
      case 'TV Movie':
        return 'assets/images/crime.png';
      case 'Thriller':
        return 'assets/images/thriller.png';
      case 'War':
        return 'assets/images/family.png';
      case 'Western':
        return 'assets/images/scifi.png';
      default:
        return 'assets/images/scifi.png';
    }
  }

  final MovieGenreRepository movieGenreRepository;
  MovieGenreBloc(this.movieGenreRepository) : super(MovieGenreInitial()) {
    //! FETCH MOVIE GENRE EVENT
    on<FetchMovieGenre>((event, emit) async {
      emit(MovieGenreLoading());
      try {
        final genres = await movieGenreRepository.getMovieGenres();
        emit(MovieGenreLoaded(genres: genres));
      } catch (error) {
        log("BLOC: FETCH MOVIES ERROR: ${error.toString()}");
        emit(MovieGenreError(message: error.toString()));
      }
    });
  }
}
